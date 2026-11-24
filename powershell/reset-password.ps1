<# Resets a password and forces a change at next logon. Password is typed at run time. #>
#Requires -Modules ActiveDirectory
[CmdletBinding()]
param([Parameter(Mandatory)][ValidatePattern('^[A-Za-z0-9._-]{2,20}$')][string]$Username)
. "$PSScriptRoot\common.ps1"
$pw = Read-Host "New temporary password" -AsSecureString
Set-ADAccountPassword -Identity $Username -Reset -NewPassword $pw
Set-ADUser -Identity $Username -ChangePasswordAtLogon $true
Write-AdminLog 'RESET_PASSWORD' $Username
Write-Host "Password reset for $Username. User must change it at next logon."
