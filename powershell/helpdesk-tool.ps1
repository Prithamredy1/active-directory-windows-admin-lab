<# TechCorp Help Desk tool - lab script. Run as a user with delegated rights. Actions are logged to ..\logs. #>
#Requires -Modules ActiveDirectory
. "$PSScriptRoot\common.ps1"
function Get-TargetUser {
    $name = (Read-Host "Employee username (e.g. rahul.k)").Trim()
    if ($name -notmatch '^[A-Za-z0-9._-]{2,20}$') { Write-Warning "Invalid username format."; return $null }
    try { Get-ADUser -Identity $name -Properties Enabled, LockedOut, LastLogonDate, PasswordLastSet, MemberOf }
    catch { Write-Warning "User '$name' not found."; $null }
}
do {
    Write-Host "`n1 Check account   2 Unlock   3 Reset password   4 Disable   5 Enable   6 Group membership   0 Exit"
    $c = Read-Host "Select"
    if ($c -in @('1','2','3','4','5','6')) { $u = Get-TargetUser; if (-not $u) { continue } }
    switch ($c) {
        '1' { $u | Select-Object Name, SamAccountName, Enabled, LockedOut, LastLogonDate, PasswordLastSet | Format-List }
        '2' { Unlock-ADAccount -Identity $u; Write-AdminLog 'UNLOCK' $u.SamAccountName; Write-Host "Account unlocked." }
        '3' { $p = Read-Host "New temporary password" -AsSecureString
              Set-ADAccountPassword -Identity $u -Reset -NewPassword $p
              Set-ADUser -Identity $u -ChangePasswordAtLogon $true
              Write-AdminLog 'RESET_PASSWORD' $u.SamAccountName; Write-Host "Password reset; change required at next logon." }
        '4' { if ((Read-Host "Disable $($u.SamAccountName)? (y/n)") -eq 'y') { Disable-ADAccount -Identity $u; Write-AdminLog 'DISABLE' $u.SamAccountName; Write-Host "Account disabled." } }
        '5' { Enable-ADAccount -Identity $u; Write-AdminLog 'ENABLE' $u.SamAccountName; Write-Host "Account enabled." }
        '6' { $u.MemberOf | ForEach-Object { (Get-ADGroup $_).Name } }
        '0' { Write-Host "Goodbye." }
        default { Write-Warning "Invalid selection." }
    }
} while ($c -ne '0')
