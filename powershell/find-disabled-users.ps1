#Requires -Modules ActiveDirectory
Search-ADAccount -AccountDisabled -UsersOnly | Select-Object Name, SamAccountName, DistinguishedName | Format-Table -AutoSize
