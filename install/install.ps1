# adhd-mode installer (Windows)
# Usage: .\install.ps1 [-Tool agents|cursor|copilot|windsurf|gemini|codex|claude] [-Overwrite] [-List]
param([switch]$Overwrite, [switch]$List, [string]$Tool = "")
$ErrorActionPreference = "Stop"; $Version = "1.0.0"; $RepoRoot = Split-Path -Parent $PSScriptRoot
$Tools = [ordered]@{
  agents = @{ Rule = "AGENTS.md"; Dest = "AGENTS.md" }
  cursor = @{ Rule = "rules\cursor\adhd-mode.mdc"; Dest = ".cursor\rules\adhd-mode.mdc" }
  copilot = @{ Rule = "rules\copilot\copilot-instructions.md"; Dest = ".github\copilot-instructions.md" }
  windsurf = @{ Rule = "rules\windsurf\rules\adhd-mode.md"; Dest = ".windsurf\rules\adhd-mode.md" }
  gemini = @{ Rule = "rules\gemini\GEMINI.md"; Dest = "GEMINI.md" }
  codex = @{ Rule = "rules\codex\AGENTS.md"; Dest = "AGENTS.md" }
  claude = @{ Rule = "claude\SKILL.md"; Dest = ".claude\skills\adhd-mode\SKILL.md" }
}
function Strip-Frontmatter([string]$text) {
  if ($text -match "(?s)^---\r?\n.*?\r?\n---\r?\n") { $text = $text -replace "(?s)^---\r?\n.*?\r?\n---\r?\n", "" }
  return $text
}
Write-Host "adhd-mode v$Version installer (project mode)`n"
foreach ($name in $Tools.Keys) {
  if ($Tool -and $Tool -ne $name) { continue }
  $rulePath = Join-Path $RepoRoot $Tools[$name].Rule; $dest = $Tools[$name].Dest
  if (-not (Test-Path $rulePath)) { Write-Host "  !  $name : missing, skipping"; continue }
  $full = Get-Content -Raw $rulePath; $body = Strip-Frontmatter $full
  if ($List) { Write-Host "  [dry-run] $name -> $dest"; continue }
  $destDir = Split-Path -Parent $dest
  if ($destDir -and -not (Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir -Force | Out-Null }
  if (Test-Path $dest) {
    $existing = Get-Content -Raw $dest
    if ($existing -match "adhd-mode v$Version") { Write-Host "  =  $name : already installed"; continue }
    Copy-Item $dest "$dest.bak-adhd-mode"
    if ($Overwrite) { Set-Content -Path $dest -Value $full -Encoding UTF8; Write-Host "  +  $name : $dest (replaced)" }
    else { Add-Content -Path $dest -Value "`n<!-- adhd-mode v$Version (begin) -->`n$body`n<!-- adhd-mode (end) -->" -Encoding UTF8; Write-Host "  +  $name : merged into $dest" }
  } else { Set-Content -Path $dest -Value $full -Encoding UTF8; Write-Host "  +  $name : $dest" }
}
if (-not $Tool -or $Tool -eq "agents" -or $Tool -eq "claude") {
  $claudeDest = "CLAUDE.md"
  if ($List) { Write-Host "  [dry-run] claude-md -> $claudeDest" }
  elseif (-not (Test-Path $claudeDest)) { Set-Content -Path $claudeDest -Value "# CLAUDE.md`n`n@AGENTS.md`n" -Encoding UTF8; Write-Host "  +  claude-md : $claudeDest" }
  else {
    $existing = Get-Content -Raw $claudeDest
    if ($existing -notmatch "@AGENTS\.md") { Copy-Item $claudeDest "$claudeDest.bak-adhd-mode"; Add-Content -Path $claudeDest -Value "`n@AGENTS.md" -Encoding UTF8; Write-Host "  +  claude-md : added @AGENTS.md (backup kept)" }
    else { Write-Host "  =  claude-md : already present" }
  }
}
Write-Host "`nDone. Restart your editor. Say 'stop adhd mode' to pause."
