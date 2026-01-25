$ErrorActionPreference = 'Stop'

function Get-Timestamp {
  return (Get-Date -Format 'yyyyMMdd-HHmmss')
}

function Ensure-Command {
  param(
    [Parameter(Mandatory = $true)][string]$Name
  )

  if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
    throw "missing required command: $Name"
  }
}

function Backup-PathIfExists {
  param(
    [Parameter(Mandatory = $true)][string]$Path,
    [Parameter(Mandatory = $true)][string]$Timestamp
  )

  if (Test-Path -LiteralPath $Path) {
    Move-Item -LiteralPath $Path -Destination ("$Path.bak-$Timestamp") -Force
  }
}

function Copy-DirOverwrite {
  param(
    [Parameter(Mandatory = $true)][string]$Source,
    [Parameter(Mandatory = $true)][string]$Destination,
    [Parameter(Mandatory = $true)][string]$Timestamp
  )

  if (-not (Test-Path -LiteralPath $Source)) {
    throw "missing directory: $Source"
  }

  Backup-PathIfExists -Path $Destination -Timestamp $Timestamp
  $parent = Split-Path -Parent $Destination
  if ($parent) {
    New-Item -ItemType Directory -Force -Path $parent | Out-Null
  }

  Copy-Item -LiteralPath $Source -Destination $Destination -Recurse -Force
}

function Copy-FileOverwrite {
  param(
    [Parameter(Mandatory = $true)][string]$Source,
    [Parameter(Mandatory = $true)][string]$Destination,
    [Parameter(Mandatory = $true)][string]$Timestamp
  )

  if (-not (Test-Path -LiteralPath $Source)) {
    throw "missing file: $Source"
  }

  Backup-PathIfExists -Path $Destination -Timestamp $Timestamp
  $parent = Split-Path -Parent $Destination
  if ($parent) {
    New-Item -ItemType Directory -Force -Path $parent | Out-Null
  }

  Copy-Item -LiteralPath $Source -Destination $Destination -Force
}

$timestamp = Get-Timestamp

$opencodeConfigDir = if ($env:OPENCODE_CONFIG_DIR) {
  $env:OPENCODE_CONFIG_DIR
} else {
  Join-Path $HOME ".config\opencode"
}

$repoUrl = if ($env:REPO_URL) {
  $env:REPO_URL
} else {
  "https://github.com/BryanHoo/superpowers-ccg.git"
}

$srcDir = if ($env:SRC_DIR) {
  $env:SRC_DIR
} else {
  Join-Path $opencodeConfigDir "sources\superpowers-ccg"
}

Ensure-Command -Name git

New-Item -ItemType Directory -Force -Path $opencodeConfigDir | Out-Null
New-Item -ItemType Directory -Force -Path (Split-Path -Parent $srcDir) | Out-Null

if (Test-Path -LiteralPath (Join-Path $srcDir ".git")) {
  Write-Host "Updating source repo: $srcDir"
  git -C $srcDir pull --ff-only
} else {
  if (Test-Path -LiteralPath $srcDir) {
    Backup-PathIfExists -Path $srcDir -Timestamp $timestamp
  }

  Write-Host "Cloning source repo: $repoUrl -> $srcDir"
  git clone $repoUrl $srcDir
}

Write-Host "Installing skills..."
Copy-DirOverwrite -Source (Join-Path $srcDir "skills") -Destination (Join-Path $opencodeConfigDir "skills") -Timestamp $timestamp

Write-Host "Installing commands..."
$commandsDir = Join-Path $opencodeConfigDir "commands"
New-Item -ItemType Directory -Force -Path $commandsDir | Out-Null
$commandsSrc = Join-Path $srcDir "commands"
if (Test-Path -LiteralPath $commandsSrc) {
  Get-ChildItem -Path $commandsSrc -Filter *.md -File -ErrorAction SilentlyContinue | ForEach-Object {
    $destination = Join-Path $commandsDir $_.Name
    Copy-FileOverwrite -Source $_.FullName -Destination $destination -Timestamp $timestamp
  }
}

Write-Host "Installing agents..."
Copy-DirOverwrite -Source (Join-Path $srcDir "agents") -Destination (Join-Path $opencodeConfigDir "agents") -Timestamp $timestamp

Write-Host ""
Write-Host "Installed to: $opencodeConfigDir"
Write-Host "Source repo:   $srcDir"
Write-Host "Backups:       *.bak-$timestamp"
Write-Host ""
Write-Host "Note: This installer does not create or install any hooks directory."
Write-Host "Next: restart OpenCode and try /superpowers-ccg-brainstorm or load a skill by name."
