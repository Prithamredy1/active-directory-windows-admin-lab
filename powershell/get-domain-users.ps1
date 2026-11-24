#Requires -Modules ActiveDirectory
Get-ADUser -Filter * -Properties Department, LastLogonDate |
    Select-Object Name, SamAccountName, Department, Enabled, LastLogonDate | Sort-Object Department | Format-Table -AutoSize
