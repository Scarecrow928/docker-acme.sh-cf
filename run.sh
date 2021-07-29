#!/bin/bash

EMAIL='email@example.com'
DOMAIN='domain.com'

docker-compose up -d
docker exec acme.sh --register-account -m $EMAIL
docker exec acme.sh --issue --dns dns_cf -d $DOMAIN -d *.$DOMAIN
docker exec acme.sh --install-cert \
    -d $DOMAIN -d *.$DOMAIN \
    --key-file /acme.sh/deploy/key.pem \
    --fullchain-file /acme.sh/deploy/cert.pem