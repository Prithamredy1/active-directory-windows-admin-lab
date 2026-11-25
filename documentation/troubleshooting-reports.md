# Troubleshooting reports

Lab incidents reproduced on `DC01` (Windows Server 2025, domain `techcorp.local`). Ticket numbers are lab labels. Every result below comes from commands I ran in this lab; screenshots are linked.

Not yet covered: client-side issues (domain join, GPO application, domain login), because `CLIENT01` has not been built. See `troubleshooting/README.md` for the remaining scenarios.

---

## INC-1001 - Account locked out (rahul.k)

**Reporter:** Rahul Kumar (HR). **Reported symptom:** cannot sign in after several failed password attempts.
**Business impact:** one HR user blocked from work until the account is unlocked.

**Environment:** domain lockout policy set to 5 invalid attempts, 15-minute lockout duration, 15-minute observation window (`Set-ADDefaultDomainPasswordPolicy`).
Evidence: `screenshots/06-group-policy/01-password-lockout-policy.png`

### Investigation
1. Reproduced the failure: five connection attempts to `\\DC01\HR` as `TECHCORP\rahul.k` with wrong passwords.
2. Listed locked accounts:
   ```powershell
   .\find-locked-users.ps1
   ```
   `rahul.k` appeared as locked out. Evidence: `screenshots/08-powershell/05-account-locked.png`
3. Checked the Security log on the domain controller:
   ```powershell
   Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4625} -MaxEvents 1 | Format-List TimeCreated, Id, Message
   Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4740} -MaxEvents 1 | Format-List TimeCreated, Id, Message
   ```
   - Event **4625** (failed logon) recorded the bad attempts. Evidence: `screenshots/09-event-viewer/01-failed-logon-4625.png`
   - Event **4740** (account lockout) was recorded at 11/23/2026 10:22:34 PM, with `Account Name: rahul.k` as the locked account. Evidence: `screenshots/09-event-viewer/02-account-lockout-4740.png`, `03-event-viewer-4740.png`

### Findings
The 4740 event lists `Caller Computer Name: DC01`. That is the machine the bad passwords came from. In this lab the attempts were made from the server itself. In a real incident, this field points to the computer or service that keeps sending the wrong password, which is where to look for stale saved credentials or mapped drives.

### Root cause
Repeated failed password attempts exceeded the lockout threshold of 5.

### Resolution
```powershell
.\unlock-account.ps1 -Username rahul.k
```
Output: `Before: Enabled=True LockedOut=True`, `After: Enabled=True LockedOut=False`. The action was written to the local admin log by the script.
Evidence: `screenshots/08-powershell/06-unlock-account.png`

### Verification
`LockedOut` returned to `False` after the unlock. A sign-in test from a client was not done (no client VM yet).

### Prevention
- Find the source in the 4740 `Caller Computer Name` and clear stale saved credentials there.
- Keep the lockout threshold, but pair it with user guidance on password changes and saved passwords.
- Restrict who can unlock accounts (delegation to the Helpdesk_Team group is a planned improvement).

---

## INC-1002 - Folder access: allowed vs denied (HR and Finance shares)

**Purpose:** verify that department shares follow least privilege. A user in the right group can open the folder; a user outside it cannot.

**Configuration**
- Folders `C:\CompanyData\HR`, `Finance`, `IT`, created by `create-shares.ps1`.
- NTFS: inheritance removed; each folder grants Modify to its own group, plus Administrators and SYSTEM. SMB share permission: Change for the same group only.
Evidence: `screenshots/05-security-groups/01-hr-folder-permissions.png`
- Membership: `rahul.k` in `HR_Group`; `priya.s` in `Finance_Group` (`screenshots/05-security-groups/01-group-members.png`).

### Test
| User | HR share | Finance share |
|---|---|---|
| rahul.k | Listed `hr-notes.txt` | **Access is denied** |
| priya.s | **Access is denied** | Listed `finance-notes.txt` |

Evidence: `screenshots/05-security-groups/02-rahul-allowed-denied.png`, `03-priya-allowed-denied.png`

### Findings
- `net use \\DC01\Finance /user:...` reported "The command completed successfully" even for the user who should be blocked. That command only opens an authenticated connection. It does not test folder access.
- The real test is reading the folder (`dir \\DC01\Finance`), which returned **Access is denied** for `rahul.k`.
- The SMB session list showed the connection under `TECHCORP\rahul.k`, so the result reflects his permissions and not an administrator's.

### Root cause (of the confusion, not a fault)
Share-level connection and folder-level access are separate checks. A successful `net use` does not mean the user can open the folder.

### Resolution
No change needed: permissions behaved as designed.

### Verification
Both users were tested in both directions. One limitation: the tests ran from the server rather than from a domain-joined client, so a client-side repeat is still to do.

### Prevention
Assign permissions to groups, never to individual users; test with a user outside the group; and test file access, not just the connection.
