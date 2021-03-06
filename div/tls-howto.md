# Glossary

- CSR: Certificate Signing Request
    - public key of a key pair
    - additional information
        - DN: distinguished name
        - CN: common name
        - FQDN: fully qualified domain name
        - CN should be the same as the FQDN
        - details about the organization (can be added using `-subj` parameter)
- PEM: Privacy Enhanced Mail (container format)
    - may include public certificate, CA certificate files, entire certificate
      chain wit public/private key and root certificates, even a CSR

- the private key can be generated together the certificate signing request, or
  re-used for later CSRs
    - how do I know if my CSR matches the private key?

.pem/.crt can be used interchangeably

# Commands

add `-nodes` so that no PEM passphrase is asked for:

    openssl pkcs12 -in mydomain.org_200911.pfx -nodes -nocerts -out mydomain.org.key

    openssl pkcs12 -in in.pfx -out out.pem -nodes

# Tutorial (https://wiki.cac.washington.edu/display/infra/Extracting+Certificate+and+Private+Key+Files+from+a+.pfx+File)

Run the following command to export the private key:

    openssl pkcs12 -in mydomain.org.pfx -nocerts -out mydomain.org.key -nodes # mydomain.org.key is with password

Run the following command to export the certificate:

    openssl pkcs12 -in mydomain.org.pfx -nokeys -out mydomain.org.crt

Run the following command to remove the passphrase from the private key

    openssl rsa -in mydomain.org.key -out mydomain.org.key # mydomain.org.key is without password

## Check Match

    openssl x509 -noout -modulus -in mydomain.org.crt | openssl md5
    openssl rsa -noout -modulus -in mydomain.org.key | openssl md5
    # must give same checksum

on server, mydomain.org.key matches mydomain.org.crt (key without org is passphrase protected)

    openssl req -noout -modulus -in mydomain.org.csr | openssl md5

## Check Dates

    openssl x509 -noout -in mydomain.org.crt -dates

# Self-Signed Certificates

```bash
$ openssl ecparam -genkey -name secp384r1 -out server.key
$ openssl req -new -x509 -sha256 -key server.key -out server.crt -days 365 -subj "/C=CH/ST=Luzern/L=Luzern/O=private/OU=home"
$ openssl pkcs12 -export -in server.crt -inkey server.key -out server.p12 -passout pass:
$ openssl pkcs12 -in server.p12 -nodes -out server.pem -passin pass:
```
