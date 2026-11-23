[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$TargetRepo,

    [switch]$Force,
    [switch]$AllPointers,
    [switch]$LocalIgnore,
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

$sourceRoot = $PSScriptRoot

$targetPath = if ([System.IO.Path]::IsPathRooted($TargetRepo)) {
    $TargetRepo
} else {
    Join-Path (Get-Location) $TargetRepo
}
$targetPath = [System.IO.Path]::GetFullPath($targetPath)

# Guard against installing into dot-agents repository itself
if ($targetPath.TrimEnd('\', '/') -ieq $sourceRoot.TrimEnd('\', '/')) {
    Write-Error "Target repository cannot be the source dot-agents repository: $targetPath"
    exit 1
}

if (-not (Test-Path $targetPath -PathType Container)) {
    Write-Error "Target repository directory does not exist: $targetPath"
    exit 1
}

Write-Host "Installing .agents kit into: $targetPath"
if ($DryRun) {
    Write-Host "[DRY-RUN MODE] No files will be modified or deleted." -ForegroundColor Magenta
}

$protectedFiles = @(
    "project_overview.md",
    "architecture.md",
    "coding_standards.md",
    "context.md",
    "USER.md"
)

$sourceAgents = Join-Path $sourceRoot ".agents"
$targetAgents = Join-Path $targetPath ".agents"

# Step A: Upgrade tracking via .kit-manifest
$targetManifestPath = Join-Path $targetAgents ".kit-manifest"
if (Test-Path $targetManifestPath) {
    $oldManifestLines = Get-Content $targetManifestPath | Where-Object { $_.Trim() -and -not $_.StartsWith("#") }
    foreach ($oldRel in $oldManifestLines) {
        $oldRelNormalized = $oldRel.Trim().Replace("/", "\")
        if ($oldRelNormalized.StartsWith(".agents\")) {
            $oldRelNormalized = $oldRelNormalized.Substring(8)
        }
        $sourceFile = Join-Path $sourceAgents $oldRelNormalized
        $targetFile = Join-Path $targetAgents $oldRelNormalized

        if (-not (Test-Path $sourceFile)) {
            $fileName = [System.IO.Path]::GetFileName($oldRelNormalized)
            $isProtected = ($protectedFiles -contains $fileName) -and (-not $oldRelNormalized.Contains("\"))
            if (-not $isProtected -and (Test-Path $targetFile)) {
                if ($DryRun) {
                    Write-Host "  [DRY-RUN REMOVE] Obsolete file: .agents/$($oldRel.Trim())" -ForegroundColor Red
                } else {
                    Remove-Item -Path $targetFile -Force
                    Write-Host "  [REMOVE] Obsolete file: .agents/$($oldRel.Trim())" -ForegroundColor Red
                }
            }
        }
    }

    # Prune empty directories in target .agents/skills
    $targetSkillsDir = Join-Path $targetAgents "skills"
    if (Test-Path $targetSkillsDir) {
        Get-ChildItem -Path $targetSkillsDir -Recurse -Directory | Sort-Object -Property FullName -Descending | ForEach-Object {
            $dir = $_
            $remaining = Get-ChildItem -Path $dir.FullName -Force
            if ($remaining.Count -eq 0) {
                $dirRel = $dir.FullName.Substring($targetAgents.Length).TrimStart('\', '/').Replace('\', '/')
                if ($DryRun) {
                    Write-Host "  [DRY-RUN REMOVE] Empty folder: .agents/$dirRel" -ForegroundColor DarkRed
                } else {
                    Remove-Item -Path $dir.FullName -Force
                    Write-Host "  [REMOVE] Empty folder: .agents/$dirRel" -ForegroundColor DarkRed
                }
            }
        }
    }
}

# Step B: Copy .agents directory
if (-not $DryRun -and -not (Test-Path $targetAgents)) {
    New-Item -ItemType Directory -Path $targetAgents -Force | Out-Null
}

$manifestEntries = [System.Collections.Generic.List[string]]::new()

# Note: Target-only custom skills in .agents/skills/ are naturally preserved since iteration only traverses source files.
Get-ChildItem -Path $sourceAgents -Recurse -Force | ForEach-Object {
    $item = $_
    $relPath = $item.FullName.Substring($sourceAgents.Length).TrimStart('\', '/')
    $relForward = $relPath.Replace('\', '/')

    # Exclude .git directory and contents (allow .gitignore and dotfiles)
    if ($relPath -eq ".git" -or $relPath.StartsWith(".git\") -or $relPath.StartsWith(".git/")) {
        return
    }

    # Exclude python cache files and directories
    if ($relPath -eq "__pycache__" -or $relPath -like "*\__pycache__*" -or $relPath -like "*\__pycache__" -or $relPath -like "*.pyc" -or $relPath -like "*.pyo") {
        return
    }

    # Exclude .kit-manifest from source
    if ($relPath -eq ".kit-manifest") {
        return
    }

    # Exclude local override files (*.local.*)
    if ($item.Name -like "*.local.*") {
        return
    }

    $destPath = Join-Path $targetAgents $relPath

    if ($item.PSIsContainer) {
        if (-not $DryRun -and -not (Test-Path $destPath)) {
            New-Item -ItemType Directory -Path $destPath -Force | Out-Null
        }
    } else {
        $manifestEntries.Add($relForward)

        $fileName = $item.Name
        $isProtected = ($protectedFiles -contains $fileName) -and ($item.DirectoryName -eq $sourceAgents)

        if ((Test-Path $destPath) -and -not $Force) {
            if ($isProtected) {
                if ($DryRun) {
                    Write-Host "  [DRY-RUN SKIP] Preserving existing: .agents/$relPath" -ForegroundColor Yellow
                } else {
                    Write-Host "  [SKIP] Preserving existing: .agents/$relPath" -ForegroundColor Yellow
                }
                return
            }
        }

        if ($DryRun) {
            Write-Host "  [DRY-RUN COPY] .agents/$relPath" -ForegroundColor Green
        } else {
            Copy-Item -Path $item.FullName -Destination $destPath -Force
        }
    }
}

# Write .kit-manifest
$manifestEntries.Sort()
$commitSha = ""
try {
    $gitRes = & git -C "$sourceRoot" rev-parse --short HEAD 2>$null
    if ($LASTEXITCODE -eq 0 -and $gitRes) {
        $commitSha = $gitRes.Trim()
    }
} catch {}

$manifestLines = [System.Collections.Generic.List[string]]::new()
if ($commitSha) {
    $manifestLines.Add("# commit: $commitSha")
}
foreach ($entry in $manifestEntries) {
    $manifestLines.Add($entry)
}

if ($DryRun) {
    Write-Host "  [DRY-RUN WRITE] Manifest: .agents/.kit-manifest ($($manifestEntries.Count) entries)" -ForegroundColor Cyan
} else {
    $manifestContent = ($manifestLines -join "`n") + "`n"
    [System.IO.File]::WriteAllText($targetManifestPath, $manifestContent, [System.Text.UTF8Encoding]::new($false))
}

# Step C: Copy bootstrap pointers
$bootstrapFiles = if ($AllPointers) {
    @("AGENTS.md", "CLAUDE.md", "GEMINI.md")
} else {
    @("AGENTS.md")
}

foreach ($bFile in $bootstrapFiles) {
    $srcFile = Join-Path $sourceRoot "bootstrap\$bFile"
    $dstFile = Join-Path $targetPath $bFile
    if (Test-Path $srcFile) {
        if ((Test-Path $dstFile) -and -not $Force) {
            if ($DryRun) {
                Write-Host "  [DRY-RUN SKIP] Preserving existing root pointer: $bFile" -ForegroundColor Yellow
            } else {
                Write-Host "  [SKIP] Preserving existing root pointer: $bFile" -ForegroundColor Yellow
            }
        } else {
            if ($DryRun) {
                Write-Host "  [DRY-RUN COPY] Root pointer: $bFile" -ForegroundColor Green
            } else {
                Copy-Item -Path $srcFile -Destination $dstFile -Force
                Write-Host "  [COPY] Installed root pointer: $bFile" -ForegroundColor Green
            }
        }
    }
}

# Step D: Local ignore via info/exclude
if ($LocalIgnore) {
    $excludePath = $null
    try {
        $gitExclude = & git -C "$targetPath" rev-parse --git-path info/exclude 2>$null
        if ($LASTEXITCODE -eq 0 -and $gitExclude) {
            $gitExcludeTrim = $gitExclude.Trim()
            $excludePath = if ([System.IO.Path]::IsPathRooted($gitExcludeTrim)) {
                $gitExcludeTrim
            } else {
                Join-Path $targetPath $gitExcludeTrim
            }
        }
    } catch {}

    if (-not $excludePath) {
        $fallbackDir = Join-Path $targetPath ".git\info"
        if (Test-Path (Join-Path $targetPath ".git") -PathType Container) {
            $excludePath = Join-Path $fallbackDir "exclude"
        }
    }

    if (-not $excludePath) {
        Write-Warning "Target repository is not a git repository; skipping -LocalIgnore."
    } else {
        $existingExcludeLines = @()
        if (Test-Path $excludePath) {
            $existingExcludeLines = Get-Content $excludePath | ForEach-Object { $_.Trim() }
        }

        $ignoreEntries = @(".agents/", "AGENTS.md", "CLAUDE.md", "GEMINI.md", "skills-lock.json")
        $missingEntries = @()
        foreach ($ign in $ignoreEntries) {
            if ($existingExcludeLines -notcontains $ign) {
                $missingEntries += $ign
            }
        }

        if ($missingEntries.Count -gt 0) {
            if ($DryRun) {
                foreach ($m in $missingEntries) {
                    Write-Host "  [DRY-RUN EXCLUDE] Add to info/exclude: $m" -ForegroundColor Cyan
                }
            } else {
                $excludeParent = [System.IO.Path]::GetDirectoryName($excludePath)
                if (-not (Test-Path $excludeParent)) {
                    New-Item -ItemType Directory -Path $excludeParent -Force | Out-Null
                }

                $linesToAdd = [System.Collections.Generic.List[string]]::new()
                if ($existingExcludeLines -notcontains "# dot-agents (local)") {
                    $linesToAdd.Add("`n# dot-agents (local)")
                }
                foreach ($m in $missingEntries) {
                    $linesToAdd.Add($m)
                    Write-Host "  [EXCLUDE] Added to info/exclude: $m" -ForegroundColor Green
                }
                Add-Content -Path $excludePath -Value ($linesToAdd -join "`n") -Encoding utf8
            }
        }
    }
}

if (-not $DryRun) {
    Write-Host "`nInstallation successful! Next steps:" -ForegroundColor Cyan
    Write-Host "1. cd `"$targetPath`""
    Write-Host "2. Run /project-init to configure the governance kit for your stack."
}
