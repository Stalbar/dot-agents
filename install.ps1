[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$TargetRepo,

    [switch]$Force
)

$ErrorActionPreference = "Stop"

$sourceRoot = $PSScriptRoot

$targetPath = if ([System.IO.Path]::IsPathRooted($TargetRepo)) {
    $TargetRepo
} else {
    Join-Path (Get-Location) $TargetRepo
}
$targetPath = [System.IO.Path]::GetFullPath($targetPath)

if (-not (Test-Path $targetPath -PathType Container)) {
    Write-Error "Target repository directory does not exist: $targetPath"
    exit 1
}

Write-Host "Installing .agents kit into: $targetPath"

# Preserved project files that should never be overwritten unless -Force
$protectedFiles = @(
    "project_overview.md",
    "architecture.md",
    "coding_standards.md",
    "context.md",
    "USER.md"
)

# 1. Copy .agents directory
$sourceAgents = Join-Path $sourceRoot ".agents"
$targetAgents = Join-Path $targetPath ".agents"

if (-not (Test-Path $targetAgents)) {
    New-Item -ItemType Directory -Path $targetAgents -Force | Out-Null
}

Get-ChildItem -Path $sourceAgents -Recurse | ForEach-Object {
    $item = $_
    $relPath = $item.FullName.Substring($sourceAgents.Length).TrimStart("\", "/")

    # Exclude git-related items
    if ($relPath -like ".git*" -or $relPath -like "*\.git*") {
        return
    }

    $destPath = Join-Path $targetAgents $relPath

    if ($item.PSIsContainer) {
        if (-not (Test-Path $destPath)) {
            New-Item -ItemType Directory -Path $destPath -Force | Out-Null
        }
    } else {
        $fileName = $item.Name
        $isProtected = $protectedFiles -contains $fileName -and ($item.DirectoryName -eq $sourceAgents)

        # Check for repo-installed custom skills
        $isRepoSkill = $false
        if ($relPath.StartsWith("skills\") -or $relPath.StartsWith("skills/")) {
            $parts = $relPath.Split("\/")
            if ($parts.Length -ge 2) {
                $skillName = $parts[1]
                $sourceSkillDir = Join-Path $sourceAgents "skills\$skillName"
                $targetSkillDir = Join-Path $targetAgents "skills\$skillName"
                if ((Test-Path $targetSkillDir) -and -not (Test-Path $sourceSkillDir)) {
                    $isRepoSkill = $true
                }
            }
        }

        if ((Test-Path $destPath) -and -not $Force) {
            if ($isProtected) {
                Write-Host "  [SKIP] Preserving existing: .agents/$relPath" -ForegroundColor Yellow
                return
            }
            if ($isRepoSkill) {
                Write-Host "  [SKIP] Preserving repo-installed skill: $relPath" -ForegroundColor Yellow
                return
            }
        }

        Copy-Item -Path $item.FullName -Destination $destPath -Force
    }
}

# 2. Copy bootstrap files (AGENTS.md, CLAUDE.md, GEMINI.md)
$bootstrapFiles = @("AGENTS.md", "CLAUDE.md", "GEMINI.md")
foreach ($bFile in $bootstrapFiles) {
    $srcFile = Join-Path $sourceRoot "bootstrap\$bFile"
    $dstFile = Join-Path $targetPath $bFile
    if (Test-Path $srcFile) {
        if ((Test-Path $dstFile) -and -not $Force) {
            Write-Host "  [SKIP] Preserving existing root pointer: $bFile" -ForegroundColor Yellow
        } else {
            Copy-Item -Path $srcFile -Destination $dstFile -Force
            Write-Host "  [COPY] Installed root pointer: $bFile" -ForegroundColor Green
        }
    }
}

Write-Host "`nInstallation successful! Next steps:" -ForegroundColor Cyan
Write-Host "1. cd `"$targetPath`""
Write-Host "2. Run /project-init to configure the governance kit for your stack."
