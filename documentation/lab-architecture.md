# Lab architecture
- **Domain:** `techcorp.local` (NetBIOS `TECHCORP`). `.local` is fine for a closed lab; real networks should use a registered domain or subdomain.
- **Network:** VMware NAT network `192.168.72.0/24`. No internet exposure for the DC.
- **DC01:** 192.168.72.10, DNS = itself. **CLIENT01:** 192.168.72.20, DNS = 192.168.72.10.
- **OUs:** IT, HR, Finance, Sales, Workstations, Service Accounts.
- **Groups:** HR_Group, Finance_Group, IT_Admins, Helpdesk_Team.
- **Resource tip (8 GB laptop):** Server 2.5-3 GB RAM, client 2-2.5 GB. Build the server first, add the client later. Take a VMware snapshot before each major change.
