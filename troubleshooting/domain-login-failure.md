# Domain login failure
**Symptoms:** user cannot sign in to CLIENT01.
**Checks**
```powershell
Test-NetConnection 192.168.10.10
nslookup techcorp.local
Get-ADUser rahul.k -Properties Enabled, LockedOut, PasswordExpired, PasswordLastSet
```
**Causes:** wrong password, locked, disabled, expired password, DNS pointing elsewhere, time skew over 5 minutes.
**Fix:** unlock (`unlock-account.ps1`), reset password, correct client DNS, run `w32tm /resync`.
**Verify:** `Get-ADUser` shows enabled and not locked; user signs in. Log the ticket.
