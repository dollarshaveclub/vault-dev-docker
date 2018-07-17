# Vault Development Docker Image

Docker image based on upstream official Vault image which allows pre-populating with
secrets for local development/testing. DO NOT USE FOR PRODUCTION PURPOSES.

Secrets
-------

The JSON file at `/opt/secrets.json` (override with
`$VAULT_SECRETS_FILE`) will be read and written into the generic
secret backend on startup.

The format is an object associating a path with value, as follows:

```json
{
  "secret/foo/bar": "baz",
  "secret/something/else": {
    "someKey": "someValue",
    "anotherKey": "anotherValue"
  }
}
```

If you see errors in your Vault client about `Invalid path for a versioned K/V secrets engine`, set the `vault-dev` container `VAULT_USE_V1_API` environment variable to `secret`. This [recreates](https://stackoverflow.com/a/49903604/223225) the `/secret` engine using v1 of the Vault API.

Backends
--------

The following backends can be enabled by setting the appropriate
environment variable to `1`:
- App ID: `$VAULT_USE_APP_ID`

App ID
------

If the app ID backend is enabled, app ID profiles can be created by
setting the file at `/opt/app-id.json` (override with
`$VAULT_APP_ID_FILE`) as follows:

```json
[
  {
    "name": "app-id-1",
    "policy": "root",
    "user_ids": [
      "asdf",
      "qwerty"
    ]
  },
  {
    "name": "app-id-2",
    "policy": "root",
    "user_ids": [
      "mary",
      "fred"
    ]
  }
]
```

Policies
--------

Policies can be created by specifying the file at `/opt/policies.json`
(override with `$VAULT_POLICIES_FILE`) as follows:

```json
{
  "policy1": "path \"secret/*\" { policy = \"write\" }"
}
```

Healthcheck
-----------
The native Docker healthcheck will return healthy when all configured secrets have been
written.

Authentication
--------------

The upstream vault image is mostly unmodified so it runs Vault in development by
default (no auth necessary) and also respects the environment variable ``VAULT_DEV_ROOT_TOKEN_ID``.

See https://hub.docker.com/_/vault/ for details.

Docker Registry
---------------

https://quay.io/dollarshaveclub/vault-dev
