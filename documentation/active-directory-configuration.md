# Active Directory configuration
Add members after creating users:
```powershell
Add-ADGroupMember HR_Group -Members rahul.k
Add-ADGroupMember Finance_Group -Members priya.s
Add-ADGroupMember IT_Admins, Helpdesk_Team -Members arjun.r
Get-ADGroupMember HR_Group
```
Move CLIENT01 into the Computers OU:
```powershell
Get-ADComputer CLIENT01 | Move-ADObject -TargetPath "OU=Computers,DC=techcorp,DC=local"
```
**Least privilege:** permissions go to groups, never to individual users. Test with a user outside the group and record the *Access denied* result as evidence.
