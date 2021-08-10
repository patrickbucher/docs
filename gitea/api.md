# Gitea API Usage

For the domain [code.frickelbude.ch](https://code.frickelbude.ch/), find the
Swagger API doc under
[code.frickelbude.ch/api/swagger](https://code.frickelbude.ch/api/swagger).

## Authentication

Create a token (using `pass` to fetch the password):

```bash
#!/usr/bin/bash

curl -X POST -H 'Content-Type: application/json' -d '{"name": "some-token"}' \
    -u patrick:`pass show gitea-patrick` \
    https://code.frickelbude.ch/api/v1/users/patrick/tokens
```

Output (token abbreviated):

```json
{"id":1,"name":"some-token","sha1":"bff...","token_last_eight":"...2cda"}
```

The `sha1` value is the token to be used for further interaction. Pipe it
through `jq` to extract it as follows:

```bash
curl ... | jq -r '.sha1'
```

Use the token as the `Authorizaton` header as follows:

```bash
#!/usr/bin/bash

token=$(cat .token) # consider that sha1 was saved there

curl -X GET -H "Accept: application/json" \
    -H "Authorization: token ${token}" \
    https://code.frickelbude.ch/api/v1/user | jq
```

Output:

```json
{
  "id": 1,
  "login": "patrick",
  "full_name": "Patrick Bucher",
  "email": "patrick.bucher@mailbox.org",
  "avatar_url": "https://code.frickelbude.ch/user/avatar/patrick/-1",
  "language": "en-US",
  "is_admin": true,
  "last_login": "2021-08-07T09:11:49Z",
  "created": "2021-06-22T19:22:32Z",
  "restricted": false,
  "username": "patrick"
}
```
