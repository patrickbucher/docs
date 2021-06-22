# Chapter 0: Introduction

OpenSSL CLI syntax:

    $ openssl [subcommand] [flags]

The flags use single dashes with long names: `-foo`, not `-f` or `--foo`.

Common flags:

- `-in`: define input (key file or the like)
- `-out`: define output
- `-text`: use textual rather than binary output

The `s_client` subcommand provides a TLS-aware netcat. It can be used to fetch
and output a certificate from a remote website:

    $ openssl s_client -showcerts -connect paedubucher.ch:443 </dev/null | openssl x509 -text -noout

There are two `openssl` commands:

1. Fetching the certificate using `s_client`:
    - `-showcerts`: show the TLS certificate
    - `-connect`: specify a `host:port` to connect to (`paedubucher.ch` on TLS port `443`)
    - `</dev/null`: do not provide any input, which is usually required from `openssl` commands
2. Parsing and displaying the certificate using `x509` (deals with X.509 certificates):
    - `-text`: output human-readable text instead of the binary representation
    - `-noout`: do not output the encoded certificate

Man pages are usually to be found with `openssl-[subcommand]`. Check `apropos openssl`.

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

There are two models of trust for publik key cryptography:

1. Web of Trust: the user decides whom to trust, used for PGP.
2. Certificate Authority: audited organizations are considered trustworthy, used for TLS.

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

    $ openssl s_client -verify_return_error -connect expired.badssl.com:443 </dev/null >/dev/null
    $ echo $?
    1

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

Various commands can be used within an interactive TLS-encrypted session:

- `Q`: quit (cleanly close the connection)
- `k`: update the key
- `K`: update the key and request a new key
- `R`: re-negotiate the terms of the connection

Use the flag `-ign_eof` to keep the connection alife after `EOF` was sent. This
also deactivates the commands above.

To only display a summary of the negotiated TLS characteristics, use the `-brief` flag:

    $ openssl s_client -connect paedubucher.ch:443 -brief </dev/null
    CONNECTION ESTABLISHED
    Protocol version: TLSv1.2
    Ciphersuite: ECDHE-RSA-AES256-GCM-SHA384
    Peer certificate: CN = paedubucher.ch
    Hash used: SHA256
    Signature type: RSA-PSS
    Verification: OK
    Supported Elliptic Curve Point Formats: uncompressed:ansiX962_compressed_prime:ansiX962_compressed_char2
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

By default, `s_client` uses the highest version of TLS offered. The protocol
version can be specified using the flags `-tls1_3`, `-tls1_2`, and the
indications for the obsolete versions `-tls1_1`, `-tls1`, `-ssl3`. It is also
possible to forbid certain protocol versions using the flags of the form
`-no_[version]`, such as `-no_tls1_1`, `-no_ssl3`, etc. Don't mix those two
kinds of flags. For example, this command can be used to check if a server still
offers obsolete TLS versions (< TLS 1.2):

    $ openssl s_client -brief -no_tls1_3 -no_tls1_2 -connect paedubucher.ch:443 -crlf </dev/null
    CONNECTION ESTABLISHED
    Protocol version: TLSv1.1
    Ciphersuite: ECDHE-RSA-AES256-SHA
    Peer certificate: CN = paedubucher.ch
    Hash used: MD5-SHA1
    Signature type: RSA
    Verification: OK
    Supported Elliptic Curve Point Formats: uncompressed:ansiX962_compressed_prime:ansiX962_compressed_char2
    Server Temp Key: X25519, 253 bits
    DONE

In the case above, TLS 1.1 is still offered.

TLS 1.2 ciphers and TLS 1.3 cipher suites can be defined using the `-cipher` and
`-ciphersuites`, respectively:

    $ openssl s_client -brief -cipher TLS_RSA_WITH_AES_128_CBC_SHA256 -connect paedubucher.ch:443 -crlf </dev/null
    Error with command: "-cipher TLS_RSA_WITH_AES_128_CBC_SHA256"
    140339066332544:error:1410D0B9:SSL routines:SSL_CTX_set_cipher_list:no cipher match:ssl/ssl_lib.c:2566:

    $ openssl s_client -brief -cipher ECDHE-RSA-AES256-GCM-SHA384 -connect paedubucher.ch:443 -crlf </dev/null
    CONNECTION ESTABLISHED
    Protocol version: TLSv1.2
    Ciphersuite: ECDHE-RSA-AES256-GCM-SHA384
    Peer certificate: CN = paedubucher.ch
    Hash used: SHA256
    Signature type: RSA-PSS
    Verification: OK
    Supported Elliptic Curve Point Formats: uncompressed:ansiX962_compressed_prime:ansiX962_compressed_char2
    Server Temp Key: X25519, 253 bits
    DONE

    $ openssl s_client -brief -tls1_3 -ciphersuites TLS_AES_128_GCM_SHA256 -connect mozilla.org:443 -crlf </dev/null
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

## Chapter 3: Certificates

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

All certificates are validated against those in the trust bundles. Additional
certificates can be added (and removed) by operating system or distribution
specific tools, such as `certctl`, `add-trusted-cert`, `update-ca-trust` etc.

Use the `-CAfile` flag to validate a certificate against a specific CA:

    # TODO: whole example
    $ openssl -CAfile /etc/ssl/certs/SwissSign_Gold_CA_-_G2.pem [...]

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

Certificates are usually delivered in the X.509 format, but can be stored in a
different formats.

_Distinguished Encoding Rules_ (DER) is an old binary format using a subset of
ASN.1, each information being stored with a tag, a length, and the actual data.
This format is very small and usually stored in files with the ending `.der` in
their name:

    $ openssl x509 -in certificate.der -inform der -text -noout

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
                    44:9F:81:5F:58:39:34:C1:0C:E1:A0:E1:3E:B0:BF:E2:61:12:C9:9C
                X509v3 Authority Key Identifier: 
                    keyid:14:2E:B3:17:B7:58:56:CB:AE:50:09:40:E6:1F:AF:9D:8B:14:C2:C6

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
                        Log ID    : 94:20:BC:1E:8E:D5:8D:6C:88:73:1F:82:8B:22:2C:0D:
                                    D1:DA:4D:5E:6C:4F:94:3D:61:DB:4E:2F:58:4D:A2:C2
                        Timestamp : Apr 26 09:25:39.415 2021 GMT
                        Extensions: none
                        Signature : ecdsa-with-SHA256
                                    30:44:02:20:0B:2F:D4:47:A0:86:F4:9E:F0:95:FF:EC:
                                    ...
                    Signed Certificate Timestamp:
                        Version   : v1 (0x0)
                        Log ID    : F6:5C:94:2F:D1:77:30:22:14:54:18:08:30:94:56:8E:
                                    E3:4D:13:19:33:BF:DF:0C:2F:20:0B:CC:4E:F1:64:E3
                        Timestamp : Apr 26 09:25:39.392 2021 GMT
                        Extensions: none
                        Signature : ecdsa-with-SHA256
                                    30:45:02:20:4D:7C:04:F4:F7:02:BC:3F:2B:7B:11:C0:
                                    ...
        Signature Algorithm: sha256WithRSAEncryption
             60:1a:51:cc:77:4c:5d:f7:31:9a:f3:93:31:5c:74:19:3e:70:
             ...

- `Version` (usually 3) is the X.509, _not_ the TLS version.
- `Serial Number` is a unique number, which is useful for certificate revocation.
- `Signature Algorithm` describes how the CA signed the certificate.
- `Issuer` identifies the CA that issued the certificate.
- `Validity` defines a time span in which a certificate can be used.
- `Subject` contains information about the entity being certified.
    - For Domain Validation (DV), only the common name (CN) is listed.
    - For Organization or Extended Validation (OV and EV), information about
      the organization, city, country are listed.
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
                44:9F:81:5F:58:39:34:C1:0C:E1:A0:E1:3E:B0:BF:E2:61:12:C9:9C
            X509v3 Authority Key Identifier:
                keyid:14:2E:B3:17:B7:58:56:CB:AE:50:09:40:E6:1F:AF:9D:8B:14:C2:C6

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
                    Log ID    : 94:20:BC:1E:8E:D5:8D:6C:88:73:1F:82:8B:22:2C:0D:
                                D1:DA:4D:5E:6C:4F:94:3D:61:DB:4E:2F:58:4D:A2:C2
                    Timestamp : Apr 26 09:25:39.415 2021 GMT
                    Extensions: none
                    Signature : ecdsa-with-SHA256
                                30:44:02:20:0B:2F:D4:47:A0:86:F4:9E:F0:95:FF:EC:
                                ...
                Signed Certificate Timestamp:
                    Version   : v1 (0x0)
                    Log ID    : F6:5C:94:2F:D1:77:30:22:14:54:18:08:30:94:56:8E:
                                E3:4D:13:19:33:BF:DF:0C:2F:20:0B:CC:4E:F1:64:E3
                    Timestamp : Apr 26 09:25:39.392 2021 GMT
                    Extensions: none
                    Signature : ecdsa-with-SHA256
                                30:45:02:20:4D:7C:04:F4:F7:02:BC:3F:2B:7B:11:C0:
                                ...

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

It's also possible to fetch and display remote certificates using the `s_client`
and `x509` subcommands combined with a pipe (same output as further above):

    $ openssl s_client -connect paedubucher.ch:443 </dev/null | \
      openssl x509 -text -noout -certopt no_pubkey,no_sigdump

Use the `-showcerts` option to display the whole certificate chain:

    $ openssl s_client -showcerts -connect paedubucher.ch:443 </dev/null

When buying a certificate, consider the reputation a CA has, and in which
jurisdication it is located. A CA must support Certificate Revocation Lists
(CRL), the Online Certificat Status Protocol (OCSP), and, optionally,
Certification Authority Authorization (CAA).
