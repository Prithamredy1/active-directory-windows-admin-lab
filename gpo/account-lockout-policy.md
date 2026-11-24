# Account lockout policy (example values)
Account Policies > Account Lockout Policy
- Threshold: 5 invalid attempts Â· Duration: 15 minutes Â· Reset counter after: 15 minutes

Same rule as the password policy: link at the domain root. Test by entering a wrong password 5 times on CLIENT01, then confirm event 4740 on DC01 and recover with `unlock-account.ps1`.
