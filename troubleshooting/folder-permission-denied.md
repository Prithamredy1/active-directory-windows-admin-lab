# Folder permission denied
**Checks:** `Get-ADPrincipalGroupMembership priya.s | Select Name`; `icacls C:\CompanyData\Finance`; `Get-SmbShareAccess Finance`. Both the **share** and **NTFS** permissions must allow access.
**Causes:** not in the right group, group change not yet in the token (user must sign out and in), NTFS denies.
**Fix:** `Add-ADGroupMember`, ask user to re-sign in. Do not grant access to individuals.
**Verify:** user opens `\\DC01\Finance`; a non-member still gets *Access denied*.
