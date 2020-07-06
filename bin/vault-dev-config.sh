#!/bin/sh

# use secrets engine v1
vault secrets disable secret
vault secrets enable -version=1 -path=secret -description='local secrets' kv
