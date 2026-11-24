<# Disables an AD account (e.g. employee leaving). Asks for confirmation. #>
#Requires -Modules ActiveDirectory
[CmdletBinding(SupportsShouldProcess)]
param([Parameter(Mandatory)][ValidatePattern('^[A-Za-z0-9._-]{2,20}$')][string]$Username)
. "$PSScriptRoot\common.ps1"
if ($PSCmdlet.ShouldProcess($Username, 'Disable account')) {
    Disable-ADAccount -Identity $Username
    Write-AdminLog 'DISABLE' $Username
    Write-Host "$Username disabled. Existing sessions stay active until logoff - see troubleshooting/."
}
