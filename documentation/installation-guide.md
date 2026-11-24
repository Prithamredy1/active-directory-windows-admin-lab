# Installation guide
Run in an elevated PowerShell on **DC01**. Replace the adapter name (`Get-NetAdapter`).

## 1. Name and IP
```powershell
New-NetIPAddress -InterfaceAlias "Ethernet0" -IPAddress 192.168.72.10 -PrefixLength 24
Set-DnsClientServerAddress -InterfaceAlias "Ethernet0" -ServerAddresses 192.168.72.10
Rename-Computer -NewName DC01 -Restart
```
## 2. Install AD DS and promote
```powershell
Install-WindowsFeature AD-Domain-Services, DNS -IncludeManagementTools
Install-ADDSForest -DomainName techcorp.local -DomainNetbiosName TECHCORP `
  -SafeModeAdministratorPassword (Read-Host "DSRM password" -AsSecureString)
```
The server restarts. Verify: `Get-ADDomain`, `dcdiag /q`.
## 3. Populate the directory
```powershell
.\powershell\create-groups.ps1
.\powershell\create-users.ps1
.\powershell\create-shares.ps1
```
## 4. Client
On CLIENT01 set IP 192.168.72.20, DNS 192.168.72.10, then:
```powershell
Test-NetConnection 192.168.72.10
nslookup techcorp.local
Add-Computer -DomainName techcorp.local -Credential TECHCORP\Administrator -Restart
```
Log in as `TECHCORP\rahul.k`. Save screenshots in `screenshots/` as you go.
