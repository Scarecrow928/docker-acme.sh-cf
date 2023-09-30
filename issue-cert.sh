#!/bin/sh

acme.sh --set-default-ca --server letsencrypt || exit $?

acme.sh --issue --dns dns_cf -d "$DOMAIN" -d "*.$DOMAIN" "$@" || exit $?

acme.sh --install-cert \
    -d "$DOMAIN" -d "*.$DOMAIN" \
    --key-file /acme.sh/deploy/key.pem \
    --fullchain-file /acme.sh/deploy/cert.pem \
    || exit $?

echo "All Done."
