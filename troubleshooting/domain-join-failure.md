# Domain join failure
**Checks:** ping the DC, `nslookup techcorp.local`, system time on both VMs, both VMs on the same VMware network, credentials of an account allowed to join.
**Causes:** DNS not set to the DC, network mismatch, time skew, firewall, wrong credentials.
**Fix:** correct DNS/network, sync time, retry `Add-Computer`.
**Verify:** CLIENT01 appears in ADUC (Computers) and a domain user can sign in.
