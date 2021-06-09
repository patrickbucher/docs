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

Applications can be configured to use  specific cipher lists. Sticking to `HIGH`
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
