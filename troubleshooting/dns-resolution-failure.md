# DNS resolution failure
**Checks:** `ipconfig /all` (DNS must be 192.168.10.10), `nslookup techcorp.local`, `Resolve-DnsName _ldap._tcp.dc._msdcs.techcorp.local -Type SRV`, `Get-Service DNS` on DC01.
**Causes:** client using a public/router DNS, DNS service stopped, wrong IP.
**Fix:** set client DNS to the DC, `ipconfig /flushdns`, start the DNS service.
**Verify:** `nslookup techcorp.local` returns 192.168.10.10.
