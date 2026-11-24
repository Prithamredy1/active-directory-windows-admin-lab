# Account lockout
**Checks:** `Search-ADAccount -LockedOut -UsersOnly`; Security log event **4740** on DC01 (Caller Computer Name); event 4625 on that machine.
**Causes:** repeated bad passwords, stale saved credentials, mapped drives or services using an old password.
**Fix:** `Unlock-ADAccount`, clear saved credentials on the source machine, update the stored password.
**Verify:** account stays unlocked after the user signs in; no new 4740.
