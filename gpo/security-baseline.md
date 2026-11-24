# Security baseline (lab)
| Setting | Location |
|---|---|
| Screen lock after 600 s | Security Options > Interactive logon: Machine inactivity limit |
| Restrict Control Panel (test user) | User Config > Administrative Templates > Control Panel > Prohibit access to Control Panel and PC settings |
| Firewall on for all profiles | Computer Config > Windows Settings > Security Settings > Windows Defender Firewall with Advanced Security |
| Audit logon, account management, lockout | Advanced Audit Policy Configuration |

Verify each on CLIENT01 with `gpupdate /force` and `gpresult /r`, then capture screenshots.
