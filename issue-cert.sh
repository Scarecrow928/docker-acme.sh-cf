#!/bin/sh

set -ex

acme.sh --set-default-ca --server letsencrypt

acme.sh --issue --dns dns_cf -d "$DOMAIN" -d "*.$DOMAIN" "$@"

acme.sh --install-cert \
    -d "$DOMAIN" -d "*.$DOMAIN" \
    --key-file /acme.sh/deploy/key.pem \
    --fullchain-file /acme.sh/deploy/cert.pem

echo "All Done."
