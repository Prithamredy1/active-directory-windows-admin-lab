# Group Policy guide
Create `TechCorp-Security-Policy` in Group Policy Management and link it to the OUs. See `gpo/` for settings.
```
gpupdate /force
gpresult /r
gpresult /h C:\Temp\gp-report.html
```
**Verify, don't assume:** run these on CLIENT01 as the test user, then save the HTML report in `gpo/gpresult-sample.html` (check it contains no sensitive data first).
**Not applying?** Check the OU the object is in, the GPO link and whether it is enabled, security filtering, and replication/DNS.
