---
title: TLS Mastery
subtitle: Notes on TLS
author: Patrick Bucher
---

Notes from [TLS Mastery](https://www.tiltedwindmillpress.com/product/tls/) by
Michael W. Lucas.

# Chapter 0: Introduction

OpenSSL commands have the following syntax:

    $ openssl [subcommand] [flags]

The flags use single dashes with long names: `-foo`, not `-f` or `--foo`.

Common flags:

- `-in`: define input (key file or the like)
- `-out`: define output
- `-text`: use textual rather than binary output

## TLS Client

The `s_client` subcommand provides a TLS-aware netcat. It can be used to fetch
and output a certificate from a remote website:

    $ openssl s_client -showcerts -connect paedubucher.ch:443 </dev/null | \
      openssl x509 -text -noout

There are two `openssl` commands:

1. Fetching the certificate using `s_client`:
    - `-showcerts`: show the TLS certificate
    - `-connect`: specify a `host:port` to connect to (`paedubucher.ch` on TLS
      port `443`)
    - `</dev/null`: do not provide any input, which is usually required from
      `openssl` commands
2. Parsing and displaying the certificate using `x509` (deals with X.509
   certificates):
    - `-text`: output human-readable text instead of the binary representation
    - `-noout`: do not output the encoded certificate

Man pages are usually to be found with `openssl-[subcommand]`. Check `apropos openssl`.

## Regulation

The FIPS (Federal Information Processing Standards) regulates which TLS
algorithms can be used. For organizations operating under FIPS regulation, those
guidelines are mandatory, even though the FIPS lacks a bit behind (e.g. `SHA-1`
is still considered safe).

TLS is used for TCP, DTLS for UDP protocols; they work mostly the same.

# Chapter 1: TLS Cryptography

RSA (Rivest, Shamir Adelman) and ECDSA (Elliptic Curve Digital Signature
Algorithm) are the most important algorithms for private/public key pairs.

TLS uses public key cryptography to negotiate a temporary, symmetric key that is
actually used to encrypt the data being transferred.

A public key infrastructure (PKI) encompasses the entire system providing
cryptography (e.g. TLS, PGP).

(H)MAC: (Hashed) Message Authentication Code is a symmetrically encrypted hash
(e.g. HMAC-256). A message is first hashed, then the hash is encrypted using the
private key. The encrypted hash then can be decrypted against the public key.

See [keylength.com](https://www.keylength.com/) for recommendations concerning
secure key lengths.

## Ciphers

A cipher suite is a combination of asymmetric, symmetric, and checksum
algorithms and parameters for end-to-end communication (but unrelated to the
signature algorithm).

TLS 1.2 indicates cipher suites as follows: `TLS_[Kx]_[Au]_WITH_[Enc]_[MAC]`:

- `Kx`: key exchange method (e.g. ECDHE, RSA)
- `Au`: authentication method (e.g. ECDSA, RSA)
- `Enc`: symmetric encryption and mode of operation (e.g. AES, CBC, CCM, GCM)
- `MAC`: message authentication code (e.g. SHA, SHA256, SHA384)

If `Kx` and `Au` are the same, the indication is only listed once.

TLS 1.3 indicates cipher suites using a shorter form: `TLS_[Enc]_[MAC]` (`Kx`,
`Au`, and `WITH` are omitted). No public key algorithm is indicated, because it
is negotiated between client and server.

Different implementations use different syntaxes, use
[ciphersuite.info](https://ciphersuite.info/) to check.

Use the `ciphers` subcommand to list supported cipher suites:

    $ openssl ciphers -v -stdname -s -tls1_3

- `-v`: list one cipher per line
- `-V`: display hex values (official "names")
- `-stdname`: display standard names
- `-s`: only display supported ciphers

Example (`cut` off all but the first column):

    $ openssl ciphers -stdname -s -v -tls1_3 | cut -f1 | sort
    TLS_AES_128_GCM_SHA256
    TLS_AES_256_GCM_SHA384
    TLS_CHACHA20_POLY1305_SHA256

Ciphers are grouped in cipher lists, see `openssl-ciphers(1)` for details (e.g.
`HIGH`, `MEDIUM`, `RSA`, `ECDHE` etc.). They can be listed using the `ciphers`
subcommand:

    $ openssl ciphers HIGH

Applications can be configured to use specific cipher lists. Sticking to `HIGH`
is a good idea in general. Check
[ssl-config.mozilla.org](https://ssl-config.mozilla.org/) for application
specific configurations.

## Security Model

There are two models of trust for publik key cryptography:

1. Web of Trust: the user decides whom to trust, used for PGP.
2. Certificate Authority: audited organizations are considered trustworthy, used
   for TLS.

Private keys, which are enough to pretend being its identity, should only be
readable/writable by the `root` user (`chmod 0600`). All certificates based on a
private key have to be revoked immediately if that private key has been leaked.

Protecting private key with passphrases is usually not viable, because the
passphrase needs to be entered as a service using TLS is started.

TLS resumption is a mechanism to speed up subsequent communication after TLS
validation has been performed with the first request. TLS 1.2 uses session
tickets (client) and server caches (server). TLS 1.3 uses pre-shared keys (PKS)
and (restricted) session tickets. Resumption could be a privacy threat, because
browsers can be identified by pre-shared keys and session tickets. Therefore,
TLS resumption is deactivated where privacy is of high concern.

Secure renegotiation is the idea to use different levels of encryption
within the same context (e.g. a web application with higher encryption for the
login process than for just browsing). It was discarded, hence is missing in TLS
1.3, due to security flaws.

DHE and ECDHE (based on RSA and ECD, respectively) do not use the private key to
negotiate a symmetric key used for the actual data transfer (PFS: perfect
forward secrecy). Therefore, captured encrypted packets can't be decrypted using
a leaked private key.

Since multiple web sites can be hosted under the same IP address, the first
request must indicate a domain, so that the right TLS certificate can be picked
for it (SNI: server name indication). This is done in cleartext.

# Chapter 2: TLS Connections

The `openssl s_client` subcommand is useful for debugging daemons that offer
TLS-encrypted connections. Different implementations of Netcat (`nc(1)`) can
deal with TLS more or less well, so better stick to `openssl`.

`s_client` was made for debugging and, therefore, also accepts invalid
certificates:

    $ openssl s_client -connect expired.badssl.com:443 </dev/null >/dev/null
    $ echo $?
    0

Specify `-verify_return_error` to fail if the certificate offered is invalid:

    $ openssl s_client -verify_return_error -connect expired.badssl.com:443 \
      </dev/null >/dev/null
    $ echo $?
    1

## Interactive TLS Sessions

Some protocols, like HTTP, require CR+LF (carriage return and line feed: `\r\n`)
to end commands, while pressing `[Enter]` on Unix terminals only sends the new
line character `\n`. Add the `-crlf` option to translate a line feed into CR+LF:

    $ openssl s_client -connect paedubucher.ch:443 -crlf
    GET / HTTP/1.1
    Host: paedubucher.ch

Press `[Enter]` twice to terminate HTTP commands; the `index.html` page will be
listed.

If server name indication (SNI) is used, specify the server name so using the
`-servername` flag.

Servers that offer _opportunistic TLS_ (STARTTLS) allow the client to connect
without TLS first and then allow the client to switch to a TLS-encrypted
connection, if it wants so. The `-starttls [protocol]` can be defined to
indicate that the switch to TLS is desired for the given protocol:

    $ openssl s_client -connect mail.company.com:25 -starttls smtp

### Helpful Commands and Flags

Various commands can be used within an interactive TLS-encrypted session:

- `Q`: quit (cleanly close the connection)
- `k`: update the key
- `K`: update the key and request a new key
- `R`: re-negotiate the terms of the connection

Use the flag `-ign_eof` to keep the connection alife after `EOF` was sent. This
also deactivates the commands above.

To only display a summary of the negotiated TLS characteristics, use the
`-brief` flag:

    $ openssl s_client -connect paedubucher.ch:443 -brief </dev/null
    CONNECTION ESTABLISHED
    Protocol version: TLSv1.2
    Ciphersuite: ECDHE-RSA-AES256-GCM-SHA384
    Peer certificate: CN = paedubucher.ch
    Hash used: SHA256
    Signature type: RSA-PSS
    Verification: OK
    Supported Elliptic Curve Point Formats: uncompressed:ansiX962_compressed_...
    Server Temp Key: X25519, 253 bits
    DONE

To only display a summary of the certificate chain, use the `-quiet` flag:

    $ openssl s_client -connect paedubucher.ch:443 -quiet </dev/null
    depth=2 O = Digital Signature Trust Co., CN = DST Root CA X3
    verify return:1
    depth=1 C = US, O = Let's Encrypt, CN = R3
    verify return:1
    depth=0 CN = paedubucher.ch
    verify return:1

## Constraining TLS Versions and Ciphers

By default, `s_client` uses the highest version of TLS offered. The protocol
version can be specified using the flags `-tls1_3`, `-tls1_2`, and the
indications for the obsolete versions `-tls1_1`, `-tls1`, `-ssl3`. It is also
possible to forbid certain protocol versions using the flags of the form
`-no_[version]`, such as `-no_tls1_1`, `-no_ssl3`, etc. Don't mix those two
kinds of flags. For example, this command can be used to check if a server still
offers obsolete TLS versions (< TLS 1.2):

    $ openssl s_client -brief -no_tls1_3 -no_tls1_2 \
      -connect paedubucher.ch:443 -crlf </dev/null
    CONNECTION ESTABLISHED
    Protocol version: TLSv1.1
    Ciphersuite: ECDHE-RSA-AES256-SHA
    Peer certificate: CN = paedubucher.ch
    Hash used: MD5-SHA1
    Signature type: RSA
    Verification: OK
    Supported Elliptic Curve Point Formats: uncompressed:ansiX962_compressed_...
    Server Temp Key: X25519, 253 bits
    DONE

In the case above, TLS 1.1 is still offered.

TLS 1.2 ciphers and TLS 1.3 cipher suites can be defined using the `-cipher` and
`-ciphersuites`, respectively:

    $ openssl s_client -brief -cipher TLS_RSA_WITH_AES_128_CBC_SHA256 \
      -connect paedubucher.ch:443 -crlf </dev/null
    Error with command: "-cipher TLS_RSA_WITH_AES_128_CBC_SHA256"
    140339066332544:error:1410D0B9:SSL routines:SSL_CTX_set_cipher_list:...

    $ openssl s_client -brief -cipher ECDHE-RSA-AES256-GCM-SHA384 \
      -connect paedubucher.ch:443 -crlf </dev/null
    CONNECTION ESTABLISHED
    Protocol version: TLSv1.2
    Ciphersuite: ECDHE-RSA-AES256-GCM-SHA384
    Peer certificate: CN = paedubucher.ch
    Hash used: SHA256
    Signature type: RSA-PSS
    Verification: OK
    Supported Elliptic Curve Point Formats: uncompressed:ansiX962_compressed_...
    Server Temp Key: X25519, 253 bits
    DONE

    $ openssl s_client -brief -tls1_3 -ciphersuites TLS_AES_128_GCM_SHA256 \
      -connect mozilla.org:443 -crlf </dev/null
    CONNECTION ESTABLISHED
    Protocol version: TLSv1.3
    Ciphersuite: TLS_AES_128_GCM_SHA256
    Peer certificate: CN = mozilla.org
    Hash used: SHA256
    Signature type: RSA-PSS
    Verification: OK
    Server Temp Key: X25519, 253 bits
    DONE

Use `openssl ciphers` or [ciphersuite.info](https://ciphersuite.info/) to find
proper ciphersuite indications.

# Chapter 3: Certificates

TLS uses X.509 certificates, which is an ITU standard for digital certificates
built on ASN.1 (Abstract Syntax Notation One), a cross-platform tree-like data
structure with object identifiers (OID).

The X.500 directory standard is used to specify informations about the
certificate holder (organization unit `OU=`, organization `O=`, common name
`CN=`, etc.) The common name used to be the host name, but can be any
identification (uid, email, first and last name).

A _trust anchor_ or _root certificate_ is an ultimately trusted certificate,
often self-signed by some big organization that runs its own Certificate
Authority (CA). Those certificates are included in operating systems (usually
Mozilla's bundle in Unix-like systems, or Microsoft's bundle in Windows). Those
bundles can be curated manually, which causes a lot of work and trouble.

On Unix-like systems, certificates are usually stored under `/etc/ssl/certs`.
Use `openssl` to figure out the real and optional additional paths:

    $ openssl version -a
    OpenSSL 1.1.1k  25 Mar 2021
    [...]
    OPENSSLDIR: "/etc/ssl"
    ENGINESDIR: "/usr/lib/engines-1.1"
    [...]

## Certificate Validation and Verification

All certificates are validated against those in the trust bundles. Additional
certificates can be added (and removed) by operating system or distribution
specific tools, such as `certctl`, `add-trusted-cert`, `update-ca-trust` etc.

Use the `-CAfile` flag to validate a certificate against a specific CA:

    $ openssl s_client -verify_return_error -connect www.srf.ch:443 \
      -CAfile /etc/ssl/certs/DigiCert_Global_Root_CA.pem </dev/null >/dev/null
    Global_Root_CA.pem </dev/null >/dev/null
    depth=2 C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert ...
    verify return:1
    depth=1 C = US, O = DigiCert Inc, CN = DigiCert SHA2 Secure Server CA
    verify return:1
    depth=0 C = CH, ST = Z\C3\BCrich, L = Z\C3\BCrich,
            O = Schweizer Radio & Fernsehen, CN = *.srf.ch
    verify return:1
    DONE
    $ echo $?
    0

A certificate contains two main pieces:

1. information about the entity being certified
2. the digital signature of that information

The signed organization information is put together with a public key into a
Certificate Signing Request (CSR). The CSR, which is a certificate without a
digital signature, is then submitted to the Certificate Auhtority, which
verifies the submitted information more or less thoroughly, and then signs the
certificate with its private key for a duration of usually 3 to 12 months.
(Modern browsers impose a limit of 398 days.)

Certificates can be constrained:

- Some can be used to sign other certificates within the same domain name.
- The cryptographic algorithms to be used can be constrained.
- The certificate is valid only for a certain domain (`foobar.com`) or, in case
  of a wildcard certificate, all subdomains thereof (`*.foobar.com`).

Those constraints can be extended beyond the standard. There are critical and
non-critical extensions. Critical extensions must be processed and validated by
all clients. Non-critical extensions can be processed if the client wants to and
is available to.

There are different levels of validation for a certificate:

1. _Domain Validation_ (DV): The CA checked that the domain is under control of
   the requesting entity (usually done via DNS).
2. _Organization Validation_ (OV): The CA verified that the requesting
   organization exists and is located at the address indicated.
3. _Extended Validation_ (EV): The CA verifies the business registration. This
   is expensive; the CA will charge for the certificate accordingly.

Domain Validation is usually enough. Extended Validation is mostly used for
regulatory compliance, say, in the finance sector. The requesting entity has to
prove its identity in all cases, only the mechanisms differ.

## Chain of Trust

The verification process of a certificate is based on a _Chain of Trust_, which
nowadays is rather a _Tree of Trust_. Root CAs protect their private keys very
well and don't want to use it for every certificate to be signed. Instead, they
sign certificates of intermediate CAs (with lower lifetimes and limited rights),
which in turn sign certificates using their private key.

The validation is performed bottom-up: domain owner, intermediate CA, root CA.
This requires the whole chain of certificates being available to the client,
which only knows the public keys of some well-known root CAs. Therefore, the
certififaces and public keys of the intermedia CA must also be delivered in a
_CA bundle_.

Certificates can be _cross signed_, i.e. be signed using signatures of different
CAs (both intermediate and root). Only one single path from the domain
certificate up to the root certificate must be found for a successful
validation. This makes a certificate more robust in case an intermediary/root
certificate is revoked (see [RFC
5280](https://datatracker.ietf.org/doc/html/rfc5280) for details on certificate
revocation).

## Certificate Formats

Certificates are usually delivered in the X.509 format, but can be stored in a
different formats.

### DER: Distinguished Encoding Rules

_Distinguished Encoding Rules_ (DER) is an old binary format using a subset of
ASN.1, each information being stored with a tag, a length, and the actual data.
This format is very small and usually stored in files with the ending `.der` in
their name:

    $ openssl x509 -in certificate.der -inform der -text -noout

### PEM: Privacy-Enhanced Mail

_Privacy-Enhanced Mail_ (PEM) is a standard for sending encrypted email, which is
nowadays less popular than PGP. It is still in common use to encode keys and
certificates. PEM is basically base64-encoded DER with human friendly headers
and footers separating multiple certificates or keys:

    -----BEGIN CERTIFICATE-----
    ...
    -----END CERTIFICATE-----

    -----BEGIN CERTIFICATE-----
    ...
    -----END CERTIFICATE-----

Usually, `.pem` is used for the file name ending, byt `.crt` or `.key` is also
common, often for backwards compatibility (i.e. when still relying on the old
name, even though the transition to a new format has been made). The PEM format
is assumed by default, so no `-inform` option needs to be passed in order to
read PEM Files:

    $ openssl x509 -in chain.pem -noout -text

Certificates can be re-encoded by combining the the `-in`, `-out`, `-inform`,
and `-outform` options. Here, a DER-encoded certificate is converted to the PEM
format:

    $ openssl x509 -in part.pem -inform pem -outform der -out part.der

### PKCS#12: Public Key Cryptography Standard 12

_Public Key Cryptography Standard 12_ (PKCS#12) can store multiple related
encryption files in a single archive, which can be signed and/or encrypted (e.g.
a certificate chain combined with a private key). Each piece of information is
stored in its own SafeBox, which are combined to archives, usually stored with
the ending `.p12` or the older `.pfx`. The `pkcs12` subcommand is used to
process such archives. A private key can be combined with a (PEM) certificate as
follows:

    $ openssl pkcs12 -export -out archive.p12 -inkey private.key -in cert.pem

Additional certificates can be provided using the `-certfile` option. A password
is prompted to encrypt the archive. A PKCS#12 file can be viewed as follows:

    $ openssl pkcs12 -info -in archive.p12

Pass the `-nodes` option to omit encryption for the private key in cleartext,
`-nokeys` to omit any keys in the output, and `-nocerts` to omit the
certificates. Those options can be combined to split up a PKCS#12 archive into
certificate and private key files:

    $ openssl pkcs12 -in archive.p12 -out all.crt -nodes
    $ openssl pkcs12 -in archive.p12 -out certs.crt -nokeys
    $ openssl pkcs12 -in archive.p12 -out private.key -nocerts -nodes

Notice that the output file `private.key` in the last example is exported in the
PKCS#8 format, i.e. without an algorithm mentioned in the header:

    -----BEGIN PRIVATE KEY-----
    ...
    -----END PRIVATE KEY-----

Pipe the output through `openssl rsa` or `openssl ec` in order to transform it
to the PKCS#1 format with an algorithm indication:

    $ openssl pkcs12 -in archive.p12 -nocerts -nodes | openssl rsa -out key.pem

Notice that the common endings `.pem`, `.der`, and `.crt` do not necessarily
imply the format used; better rely on the output of `file(1)` and the validation
of `openssl-x509(1ssl)` instead.

## Certificate Contents

A certificate contains various fields, which can be viewed as follows (output of
public keys and signatures shortened):

    $ openssl x509 -in cert.der -inform der -text -noout
    Certificate:
        Data:
            Version: 3 (0x2)
            Serial Number:
                04:a9:5c:4e:9c:51:cd:df:b3:ef:00:78:5b:97:b5:7f:79:39
            Signature Algorithm: sha256WithRSAEncryption
            Issuer: C = US, O = Let's Encrypt, CN = R3
            Validity
                Not Before: Apr 26 08:25:39 2021 GMT
                Not After : Jul 25 08:25:39 2021 GMT
            Subject: CN = paedubucher.ch
            Subject Public Key Info:
                Public Key Algorithm: rsaEncryption
                    RSA Public-Key: (2048 bit)
                    Modulus:
                        00:a0:98:97:a0:9d:41:4d:3a:27:2d:c3:86:12:ce:
                        ...
                    Exponent: 65537 (0x10001)
            X509v3 extensions:
                X509v3 Key Usage: critical
                    Digital Signature, Key Encipherment
                X509v3 Extended Key Usage: 
                    TLS Web Server Authentication, TLS Web Client Authentication
                X509v3 Basic Constraints: critical
                    CA:FALSE
                X509v3 Subject Key Identifier: 
                    44:9F:81:5F:58:39:34:C1:0C:E1:A0:E1:3E:B0:BF:E2:61:12:...
                X509v3 Authority Key Identifier: 
                    keyid:14:2E:B3:17:B7:58:56:CB:AE:50:09:40:E6:1F:AF:9D:...

                Authority Information Access: 
                    OCSP - URI:http://r3.o.lencr.org
                    CA Issuers - URI:http://r3.i.lencr.org/

                X509v3 Subject Alternative Name: 
                    DNS:paedubucher.ch, DNS:www.paedubucher.ch
                X509v3 Certificate Policies: 
                    Policy: 2.23.140.1.2.1
                    Policy: 1.3.6.1.4.1.44947.1.1.1
                      CPS: http://cps.letsencrypt.org

                CT Precertificate SCTs: 
                    Signed Certificate Timestamp:
                        Version   : v1 (0x0)
                        Log ID    : 94:20:BC:1E:8E:D5:8D:6C:88:73:1F:82:8B:...
                                    D1:DA:4D:5E:6C:4F:94:3D:61:DB:4E:2F:58:...
                        Timestamp : Apr 26 09:25:39.415 2021 GMT
                        Extensions: none
                        Signature : ecdsa-with-SHA256
                                    30:44:02:20:0B:2F:D4:47:A0:86:F4:9E:F0:...
                                    ...
                    Signed Certificate Timestamp:
                        Version   : v1 (0x0)
                        Log ID    : F6:5C:94:2F:D1:77:30:22:14:54:18:08:30:...
                                    E3:4D:13:19:33:BF:DF:0C:2F:20:0B:CC:4E:...
                        Timestamp : Apr 26 09:25:39.392 2021 GMT
                        Extensions: none
                        Signature : ecdsa-with-SHA256
                                    30:45:02:20:4D:7C:04:F4:F7:02:BC:3F:2B:...
                                    ...
        Signature Algorithm: sha256WithRSAEncryption
             60:1a:51:cc:77:4c:5d:f7:31:9a:f3:93:31:5c:74:19:3e:70:
             ...

- `Version` (usually 3) is the X.509, _not_ the TLS version.
- `Serial Number` is a unique number, which is useful for certificate
  revocation.
- `Signature Algorithm` describes how the CA signed the certificate.
- `Issuer` identifies the CA that issued the certificate.
- `Validity` defines a time span in which a certificate can be used.
- `Subject` contains information about the entity being certified.
    - For Domain Validation (DV), only the common name (CN) is listed.
    - For Organization or Extended Validation (OV and EV), information about the
      organization, city, country are listed.
- `Subject Public Key` is the public part of the key that has been used to
  create the Certificate Signing Request (CSR).
- `X509v3 extensions` lists critical and non-critical extensions (mandatory and
  optional for certificate verification):
    - `X509v3 Key Usage` (critical) describes how a key can be used.
    - `X509v3 Extended Key Usage` (non-critical) describes additional purposes
      the key can be used for.
    - `X509v3 Basic Constraints` (critical) lists if the certificate's key can
      be used to sign other certificates (`CA:TRUE`) or not (`CA:FALSE`)
    - `X509v3 Subject Key Identifier` and `X509v3 Authority Key Identifier` is
      the identifier for the subject's and the CA authority's key.
    - `Authority Information Access` shows how to get more information about the
      CA.
    - `X509v3 Subject Alternative Name` shows the hostnames covered by the
      certificate.
    - `X509v3 Certificate Policies` describes the CA.
- `CT Precertificate SCTs` contains the Signed Certificate Timestamp (SCT) with
  the signatures used, which is a cryptographic proof that the certificate was
  submitted to a certificate log (Certificat Transparency).
- There's a digital signature of the CA at the very end of the certificate with
  the indicated `Signature Algorithm`.

### Narrowing Down the Output

Additional information to X.509 extensions can be queried using the `-ext`
option with comma-separated extensions to be listed (`x509v3_config(3)`):

    $ openssl x509 -in cert.pem -noout -ext keyUsage,extendedKeyUsage
    X509v3 Key Usage: critical
        Digital Signature, Key Encipherment
    X509v3 Extended Key Usage:
        TLS Web Server Authentication, TLS Web Client Authentication

Extensions not understood by the `openssl` client in use are displayed as raw
binary data (consider updating `openssl` or look up the respective OID).

The output can be further shortened using the `-certopt` option, which accepts
comma-separated values (here: neither display public keys nor signature dumps):

    $ openssl x509 -in first.pem -text -noout -certopt no_pubkey,no_sigdump
    Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            04:a9:5c:4e:9c:51:cd:df:b3:ef:00:78:5b:97:b5:7f:79:39
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: C = US, O = Let's Encrypt, CN = R3
        Validity
            Not Before: Apr 26 08:25:39 2021 GMT
            Not After : Jul 25 08:25:39 2021 GMT
        Subject: CN = paedubucher.ch
        X509v3 extensions:
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment
            X509v3 Extended Key Usage:
                TLS Web Server Authentication, TLS Web Client Authentication
            X509v3 Basic Constraints: critical
                CA:FALSE
            X509v3 Subject Key Identifier:
                44:9F:81:5F:58:39:34:C1:0C:E1:A0:E1:3E:B0:BF:E2:61:12:...
            X509v3 Authority Key Identifier:
                keyid:14:2E:B3:17:B7:58:56:CB:AE:50:09:40:E6:1F:AF:9D:...

            Authority Information Access:
                OCSP - URI:http://r3.o.lencr.org
                CA Issuers - URI:http://r3.i.lencr.org/

            X509v3 Subject Alternative Name:
                DNS:paedubucher.ch, DNS:www.paedubucher.ch
            X509v3 Certificate Policies:
                Policy: 2.23.140.1.2.1
                Policy: 1.3.6.1.4.1.44947.1.1.1
                  CPS: http://cps.letsencrypt.org

            CT Precertificate SCTs:
                Signed Certificate Timestamp:
                    Version   : v1 (0x0)
                    Log ID    : 94:20:BC:1E:8E:D5:8D:6C:88:73:1F:82:8B:...
                                D1:DA:4D:5E:6C:4F:94:3D:61:DB:4E:2F:58:...
                    Timestamp : Apr 26 09:25:39.415 2021 GMT
                    Extensions: none
                    Signature : ecdsa-with-SHA256
                                30:44:02:20:0B:2F:D4:47:A0:86:F4:9E:F0:...
                                ...
                Signed Certificate Timestamp:
                    Version   : v1 (0x0)
                    Log ID    : F6:5C:94:2F:D1:77:30:22:14:54:18:08:30:...
                                E3:4D:13:19:33:BF:DF:0C:2F:20:0B:CC:4E:...
                    Timestamp : Apr 26 09:25:39.392 2021 GMT
                    Extensions: none
                    Signature : ecdsa-with-SHA256
                                30:45:02:20:4D:7C:04:F4:F7:02:BC:3F:2B:...
                                ...

## Multiple Hostnames

A site can be reachable under different names, such as `paedubucher.ch` and
`www.paedubucher.ch`. Subject Alternative Names (SAN) identify all the hostnames
a certificate is good for and can be displayed as follows:

    $ openssl x509 -in first.pem -noout -ext subjectAltName
    X509v3 Subject Alternative Name: 
        DNS:paedubucher.ch, DNS:www.paedubucher.ch

A wildcard certificate is good for any subdomain of a hostname
(`*.paedubucher.ch`), which can be dangerous, because a successful attacker can
offer services with subdomains made up for the purpose (such as
`www2.paedubucher.ch`).

## Fetching Certificates

It's also possible to fetch and display remote certificates using the `s_client`
and `x509` subcommands combined with a pipe (same output as further above):

    $ openssl s_client -connect paedubucher.ch:443 </dev/null | \
      openssl x509 -text -noout -certopt no_pubkey,no_sigdump

Use the `-showcerts` option to display the whole certificate chain:

    $ openssl s_client -showcerts -connect paedubucher.ch:443 </dev/null

## Some CA Considerations

When buying a certificate, consider the reputation a CA has, and in which
jurisdication it is located. A CA must support Certificate Revocation Lists
(CRL), the Online Certificat Status Protocol (OCSP), and, optionally,
Certification Authority Authorization (CAA).

# Chapter 4: Revocation and Invalidation

When  private key gets stolen, the certificates based on it can no longer be
trusted. However, the certificate itself still looks trustworthy, and cannot be
revoked by the owner of the private key that has been used to sign the
certificate. Since trust comes from above, only the signing CA can revoke a
certificate.

CAs offer web interfaces or automated tools and interfaces for this purpose.
Usually, a replacement certificate is ordered in this purpose, which of course
needs to be requested with a new private key. It's a good idea to test this
process, which gives you an idea how well the CA can handle the certificate
invalidation and replacement process.

TLS offers multiple mechanisms for certificate revocation:

## Certificate Revocation Lists (CRL)

_Certificate Revocation Lists_ (CRL) are lists of revoked (but not yet expired)
certificates offered by the CA. An endpoint to this list is linked as the `CRL
Endpoint` (`Distribution Point`) in the CA's intermediary certificate. The
client downloads this list and makes sure the respective certificate is not on
that list by comparing the certificate's serial number to those on the list.

CRLs become big quite fast and don't scale very well nowadays, even though they
can be cached. Caching, however, slows down the revocation process. Use the
`crl` subcommand on your CA's root certificate to show the CRL:

    $ curl http://crl.identrust.com/DSTROOTCAX3CRL.crl | \
      openssl crl -text -inform der -noout

CRLs are usually served in DER format to keep the files small, but other formats
can be used, too.

## Online Certificate Status Protocol (OCSP)

With the _Online Certificate Status Protocol_ (OCSP), the client no longer needs
to fetch a CA's complete list of rekoved certificates, but can query the status
of a single certificate via an HTTP endpoint. A result (`good`, `revoked`,
`unknown`) and a cache time to live are returned. The CA signs the response, so
raw HTTP (without TLS) is used here. The endpoint for OCSP can be extracted from
the certificate chain:

    $ openssl s_client -showcerts -connect paedubucher.ch:443 \
      </dev/null 2>/dev/null | openssl x509 -noout -ocsp_uri
    http://r3.o.lencr.org

Given the certificate chain and the OCSP URL, the revocation status can be
tested using the `ocsp` subcommand (`openssl-ocsp(1ssl)`):

    $ openssl s_client -connect github.com:443 </dev/null | \
      openssl x509 >cert.pem
    $ openssl s_client -showcerts -connect github.com:443 \
      </dev/null >chain.pem
    $ openssl x509 -in chain.pem -noout -ocsp_uri
    http://ocsp.digicert.com
    $ openssl ocsp -issuer chain.pem -cert cert.pem -text \
      -url http://ocsp.digicert.com
    OCSP Response Data:
    OCSP Response Status: successful (0x0)
    Response Type: Basic OCSP Response
    Version: 1 (0x0)
    Responder Id: 5061A6A0D235C4112A208D1F0FAC42F0CD29CF4B
    Produced At: Jun 24 03:36:53 2021 GMT
    Responses:
    Certificate ID:
      Hash Algorithm: sha1
      Issuer Name Hash: C6325AEE2FA3FD33D07789FD6B4CCEF0CA3FD029
      Issuer Key Hash: 5061A6A0D235C4112A208D1F0FAC42F0CD29CF4B
      Serial Number: 0E8BF3770D92D196F0BB61F93C4166BE
    Cert Status: good
    This Update: Jun 24 03:21:02 2021 GMT
    Next Update: Jul  1 02:36:02 2021 GMT

Check the `Cert Status`; "good" means that the certificate  hasn't been revoked.

This process consumes less bandwith than CRLs, but more processing power on the
client side. The CA also gets to know the clients accessing particular domains,
which is a privay issue.

## OCSP Stapling

The OCSP query response (see above) contains a field `Next Update`, which is the
expiration date of that query. A server can make this request on behalf of the
client, and attach ("staple") the OCSP response to the TLS session with the
client, and digitally sign it. Doing so, the server can save the clients a lot
of OCSP queries—and better protect their privacy—but also needs to perform the
OCSP lookups periodically (according to the `Next Update` indication). Most
modern web browsers and servers support OCSP nowadays.

## Revocation Issues

Not all CAs offer all the revocation mechanisms described, or they implement
them in a non-standard or bad way (say, offering just empty CRLs for technical
compatibility). Client software failing to perform OCSP checks are often hidden
from the user for the sake of convenience. Some modern browsers rely on their own
curated list of CRLs, which are shipped with their software updates, instead of
fetching CRLs in real-time.

How a client deals with revocation can be tested with sites like
[revoked-rsa-dv.ssl.com](https://revoked-rsa-dv.ssl.com). Using short-lived
certificates with heavy automation mitigates revocation issues. Unfortunately,
Chrome ignores the OCSP Must Staple server setting, which would be a way to
emulate short-lived certificates.

# Chapter 5: TLS Negotiation

Clients and servers may have different software and configurations for TLS
deployed, which support different protocol versions, algorithms, and options.
Therefore, the parameters to be uses for a connection are not known in advance,
but need to be negotiated between client and server.

A TLS connection, which can be initiated using the `s_client` subcommand,
consists of three parts: certificate validation, protocol settings, and
session resumption.

## Certificate Validation

The TLS client attempts to find a way from the served certificate up to a
trusted root certificate. The process is finished as soon as one such valid path
is discovered. The `openssl` client then then outputs this path to standard
error:

    $ openssl s_client -connect paedubucher.ch:443 </dev/null >/dev/null
    depth=2 C = US, O = Internet Security Research Group, CN = ISRG Root X1
    verify return:1
    depth=1 C = US, O = Let's Encrypt, CN = R3
    verify return:1
    depth=0 CN = paedubucher.ch
    verify return:1
    DONE

The certificates are listed from top (root certificate) to bottom (domain
certificate), with a `depth` field indicating the distance from the domain
certificate. The field `verify return:1` signifies successful validation of the
certificate.

The certificate chain is displayed in reverse order (from domain to root) in the
standard output, followed by the server certificate, details about the
algorithms and keys being used (here: `SHA256`, `RSA-PSS`, and `X25519` with 253
bits), and, finally, the result of the SSL handshake (`Verification: OK`):

    $ openssl s_client -connect paedubucher.ch:443 </dev/null 2>/dev/null
    ...
    Certificate chain
     0 s:CN = paedubucher.ch
       i:C = US, O = Let's Encrypt, CN = R3
     1 s:C = US, O = Let's Encrypt, CN = R3
       i:C = US, O = Internet Security Research Group, CN = ISRG Root X1
     2 s:C = US, O = Internet Security Research Group, CN = ISRG Root X1
       i:O = Digital Signature Trust Co., CN = DST Root CA X3
    ...
    -----BEGIN CERTIFICATE-----
    MIIFNjCCBB6gAwIBAgISBJa0Pa3QlqD/TEZHmLlZtqQnMA0GCSqGSIb3DQEBCwUA
    ...
    wnvurz8wdWtXilw61qAJJwivHeU+/FfF1Lt+wRN6mDZ/bQoU3dFubw1n
    -----END CERTIFICATE-----
    subject=CN = paedubucher.ch

    issuer=C = US, O = Let's Encrypt, CN = R3
    ---
    No client certificate CA names sent
    Peer signing digest: SHA256
    Peer signature type: RSA-PSS
    Server Temp Key: X25519, 253 bits
    ---
    SSL handshake has read 4691 bytes and written 409 bytes
    Verification: OK
    ---


## Protocol Settings

Parameters such as key length, TLS version and cipher, and the like are
negotiated between the parties involved. Compression, being deactivated by
default, can be activated using the `-comp` flag.

Application Layer Protocol Negotiation (ALPN) is a way to integrate TLS setup
into the protocol setup, which is mostly used in HTTP/2, and can be activated
using the `-alpn` flag.

Application data can be bundled with a TLS connection using the `-early_data`
flag. All those informations are displayed in the subsequent sections of the
output:

    $ openssl s_client -connect paedubucher.ch:443 </dev/null 2>/dev/null
    ...
    New, TLSv1.2, Cipher is ECDHE-RSA-AES256-GCM-SHA384
    Server public key is 2048 bit
    Secure Renegotiation IS supported
    Compression: NONE
    Expansion: NONE
    No ALPN negotiated

## Session Resumption

The TLS session and resumption details vary strongly between TLS versions being
used:

### TLS 1.2

The session information starts with the protocol version (`TLSv1.2`) and the
cipher being used. Every session has its ID (`Session-ID`) and Context ID
(`Session-ID-ctx`), which could refer to some server-internal context such as an
application (database server, web server) and is often used for load balancing.

The `Master Key` is the result of the key agreement between client and server.
Additional fields (prefixes: `PSK` and `SRP`) are only set if pre-shared keys
and the Secure Remote Password (SRP) protocol are being used.

The actual _session ticket_ follows, which is then used for a subsequent request
within the same TLS session (_resumption_).

The ticket is accompanied by TTL information indicating the timespan in which
the ticket is valid. `Verify return code: 0 (ok)` signifies success, all other
codes point to a verification error.

    $ openssl s_client -tls1_2 -connect paedubucher.ch:443 </dev/null 2>/dev/null
    ...
    SSL-Session:
        Protocol  : TLSv1.2
        Cipher    : ECDHE-RSA-AES256-GCM-SHA384
        Session-ID: 3E09DF7A7C7C90B577C12254ED7ACA74CCCB5BDBE5B5B2AF44B...
        Session-ID-ctx:
        Master-Key: BB1EA0160136226FEB81B5849161EA9C87BAE06EAFAF649722A...
        PSK identity: None
        PSK identity hint: None
        SRP username: None
        TLS session ticket lifetime hint: 300 (seconds)
        TLS session ticket:
        0000 - 5d 43 c4 64 d9 18 b1 bd-c7 42 cc e9 49 44 2a fd   ]C.d...
        ...
        00b0 - 77 9f 38 b6 a2 cf bd 03-e6 7f 31 e1 f7 5f 58 b0   w.8...

        Start Time: 1624727116
        Timeout   : 7200 (sec)
        Verify return code: 0 (ok)
        Extended master secret: yes

### TLS 1.3

TLS 1.3 supports many fields of TLS 1.2 just for the sake of backward
compatibility, which is important for network devices and tools that perform
deep packet inspection on network traffic.

In TLS 1.3, sessions are only established _after_ the main handshake has been
completed. Therefore, no `SSL-Session` section can be found when dealing with
TLS 1.3.

## TLS Failures

A TLS connection usually fails for two reasons:

1. The client won't accept a certificate.
2. Client and server cannot agree on TLS options, algorithms, and protocols.

If the client uses a current software version and certificate bundle together
with a default configuration, then usually the server is to blame for a failed
TLS connection.

One common error is a server only serving its own domain certificate instead of
providing the whole certificate chain. This usually results in an error message
like "unable to get local issuer certificate". Searching for an OpenSSL error
message usually yields quick and accurate results.

The website [badssl.com](https://badssl.com) provides many subdomains with
different TLS and SSL (mis)configurations. Try them out with the `s_client`
subcommand, and make sure to pass the `-verify_return_error`, so that you'll
learn which TLS issues cause which OpenSSL error messages.

    $ openssl s_client -connect untrusted-root.badssl.com:443 \
      -verify_return_error </dev/null 2>/dev/null | grep 'Verification error'
    Verification error: self signed certificate in certificate chain

    $ openssl s_client -connect superfish.badssl.com:443 \
      -verify_return_error </dev/null 2>/dev/null | grep 'Verification error'
    Verification error: unable to get local issuer certificate
