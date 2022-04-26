#!/bin/bash

DOMAIN='domain.com'

function error_exit {
    docker compose down
    exit $1
}

docker compose up -d
exit_code=$?
if [ $exit_code -ne 0 ]; then
    error_exit $exit_code
fi

docker exec acme.sh --set-default-ca --server letsencrypt
exit_code=$?
if [ $exit_code -ne 0 ]; then
    error_exit $exit_code
fi

docker exec acme.sh --issue --dns dns_cf -d $DOMAIN -d *.$DOMAIN "$@"
exit_code=$?
if [ $exit_code -ne 0 ]; then
    error_exit $exit_code
fi

docker exec acme.sh --install-cert \
    -d $DOMAIN -d *.$DOMAIN \
    --key-file /acme.sh/deploy/key.pem \
    --fullchain-file /acme.sh/deploy/cert.pem
exit_code=$?
if [ $exit_code -ne 0 ]; then
    error_exit $exit_code
fi

echo "All Done."
