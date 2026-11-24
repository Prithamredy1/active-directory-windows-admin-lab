#Requires -Modules ActiveDirectory
Search-ADAccount -LockedOut -UsersOnly | Select-Object Name, SamAccountName, LockedOut | Format-Table -AutoSize
