# Event Viewer and security logs
Auditing must be enabled (Advanced Audit Policy: Logon, Account Logon, Account Management, Account Lockout) or some events will not appear.

| ID | Meaning |
|---|---|
| 4624 / 4625 | Successful / failed logon |
| 4740 | Account locked out (logged on the DC) |
| 4720 / 4722 / 4725 | Account created / enabled / disabled |
| 4723 / 4724 | Password change / reset attempt |
| 4728 / 4732 | Member added to global / local security group |
| 4738 | Account changed |

```powershell
Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4625} -MaxEvents 10 | Format-List TimeCreated, Message
Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4740} -MaxEvents 5 | Format-List TimeCreated, Message
```
For lockouts, the 4740 message names the *Caller Computer Name* - the machine sending bad passwords.
