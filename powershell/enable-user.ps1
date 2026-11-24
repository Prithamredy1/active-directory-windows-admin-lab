<# Enables a disabled AD account. #>
#Requires -Modules ActiveDirectory
[CmdletBinding()]
param([Parameter(Mandatory)][ValidatePattern('^[A-Za-z0-9._-]{2,20}$')][string]$Username)
. "$PSScriptRoot\common.ps1"
$u = Get-ADUser -Identity $Username -Properties LockedOut
Write-Host "Before: Enabled=$($u.Enabled) LockedOut=$($u.LockedOut)"
Enable-ADAccount -Identity $Username
Write-AdminLog 'ENABLE' $Username
$u = Get-ADUser -Identity $Username -Properties LockedOut
Write-Host "After:  Enabled=$($u.Enabled) LockedOut=$($u.LockedOut)"
