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

# Note: Target-only custom skills in .agents/skills/ are naturally preserved since iteration only traverses source files.
Get-ChildItem -Path $sourceAgents -Recurse -Force | ForEach-Object {
    $item = $_
    $relPath = $item.FullName.Substring($sourceAgents.Length).TrimStart('\', '/')

    # Exclude .git directory and contents (allow .gitignore and dotfiles)
    if ($relPath -eq ".git" -or $relPath.StartsWith(".git\") -or $relPath.StartsWith(".git/")) {
        return
    }

    # Exclude python cache files and directories
    if ($relPath -eq "__pycache__" -or $relPath -like "*\__pycache__*" -or $relPath -like "*\__pycache__" -or $relPath -like "*.pyc" -or $relPath -like "*.pyo") {
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

        if ((Test-Path $destPath) -and -not $Force) {
            if ($isProtected) {
                Write-Host "  [SKIP] Preserving existing: .agents/$relPath" -ForegroundColor Yellow
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
