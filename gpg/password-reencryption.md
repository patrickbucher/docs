# Password Reencryption

## Situation

A folder `passwords` contains a list of PGP/RSA encrypted password files. The
passwords have been encrypted using an old key. This old key is no longer
considered save, because it has been leaked or uses a key size no longer
considered good enough.

## Create a new Key

First, a new, secure key has to be created:

```bash
$ gpg --full-generate-key
```

Option 1 (RSA/RSA) with a key size of 2048 or 4096 is a sensible choice,
combined with a strong passphrase.

## Re-encrypt Passwords

The script `reencrypt.sh` decrypts the existing passwords and directly forwards
the cleartext to the encryption process, which puts the file into the target
dir `new_passwords`.

The variable `NEW_ID` needs to be set to the ID of the key that just has been
created. It can be find out as such:

```bash
$ gpg -k --keyid-format 0xshort
```

The whole script `reencrypt.sh`:

```bash
#!/bin/sh

NEW_ID='0x3C0C9D47'

FROM_DIR='passwords'
TO_DIR='new_passwords'

rm -rf "$TO_DIR" && mkdir "$TO_DIR"

for OLD_FILE in ${FROM_DIR}/*.gpg
do
    NEW_FILE="${TO_DIR}/$(basename "$OLD_FILE")"
    gpg -o - -d "$OLD_FILE" | gpg -e -r "$NEW_ID" -o "$NEW_FILE"
done
```
