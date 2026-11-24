# Shared helpers. Dot-source with:  . "$PSScriptRoot\common.ps1"
function Write-AdminLog {
    param([string]$Action, [string]$Target)
    $dir = Join-Path $PSScriptRoot '..\logs'
    New-Item $dir -ItemType Directory -Force | Out-Null
    "{0:u} | {1} | {2} | {3}" -f (Get-Date), $env:USERNAME, $Action, $Target |
        Add-Content (Join-Path $dir 'admin-actions.log')
}
