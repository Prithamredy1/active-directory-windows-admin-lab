# Password policy (example values for the lab)
Computer Configuration > Windows Settings > Security Settings > Account Policies > Password Policy
- Minimum length: 12 · Complexity: enabled · Maximum age: 90 days · History: 10

> Domain password and lockout settings only take effect from a GPO linked at the **domain root** (e.g. Default Domain Policy) or via a Fine-Grained Password Policy. Linking to an OU will not change domain-account rules.
