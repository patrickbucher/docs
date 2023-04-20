# HOTP

HOTP: HMAC-Based One-Time Passwort

- hash method H (e.g. SHA-1)
- secret key K
- counter C
- length d (6-10)

# TOTP

- using UNIX timestamp as a counter
- interval (30 seconds)
- counter = (current time - start time) / interval time

## HMAC

HMAC: Hash Message Authentication Code

- provides authentication using a shared secret
- verifies integrity and authenticity
- two passes, derives two keys (inner/outer) before either pass
    - first pass: internal hash from message and inner key
    - second pass: final hmac from inner hash and outer key
- message sent alongside hmac hash
