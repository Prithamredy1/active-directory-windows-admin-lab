# Active Directory & Windows Administration Lab

A hands-on enterprise IT support simulation: a Windows Server domain controller for a fictional company (**TechCorp**, `techcorp.local`), a domain-joined Windows client, Group Policy, PowerShell automation, and documented help desk troubleshooting.

> **Status:** scripts and documentation are written. Lab results and screenshots are added as each phase is completed in my own VMware lab. See the checklist below for what is done.

## Architecture
| VM | Name | IP | Role |
|---|---|---|---|
| Windows Server 2022/2025 (evaluation) | DC01 | 192.168.10.10 | AD DS, DNS, Group Policy |
| Windows 10/11 (evaluation) | CLIENT01 | 192.168.10.20 | Domain-joined client, GPO testing |

Private VMware network (host-only). Details: [documentation/lab-architecture.md](documentation/lab-architecture.md).

## Contents
| Folder | What is inside |
|---|---|
| `documentation/` | Install guide, AD configuration, Group Policy, Event Viewer guide, lessons learned |
| `powershell/` | User, group, share and help desk automation scripts (no passwords stored) |
| `gpo/` | Password, lockout and security baseline policy notes |
| `troubleshooting/` | Runbooks for login, lockout, DNS, domain join and folder permission issues |
| `screenshots/` | Evidence from the lab, grouped by phase |

## PowerShell scripts
`create-groups.ps1` OUs and groups Â· `create-users.ps1` bulk users from CSV Â· `create-shares.ps1` least-privilege folders Â· `reset-password.ps1` Â· `unlock-account.ps1` Â· `disable-user.ps1` Â· `enable-user.ps1` Â· `find-locked-users.ps1` Â· `find-disabled-users.ps1` Â· `get-domain-users.ps1` Â· `helpdesk-tool.ps1` menu tool. Admin actions are written to a local log.

## Progress checklist
- [x] Server VM and DC01 static IP
- [x] AD DS + DNS, forest `techcorp.local`
- [x] OUs, users, security groups
- [x] Folder permissions tested (allowed and denied)
- [ ] GPOs created, linked and verified with `gpresult`
- [ ] CLIENT01 joined, domain login tested
- [x] PowerShell scripts tested
- [ ] Troubleshooting scenarios executed and written up
- [x] Event Viewer investigation (4624, 4625, 4740)

## Security notes
Lab only. Never commit passwords, recovery keys or real employee data. Scripts ask for passwords at run time. In production, restrict these actions with delegated permissions.

## Limitations / future work
Single domain controller, no DHCP, no replication. Next: DHCP, a second DC, fine-grained password policies.
