# docker-acme.sh-cf
A script for issuing and installing certificates by [acme.sh](https://github.com/acmesh-official/acme.sh), using the Cloudflare's DNS API. These steps will run acme.sh container as a daemon, and automatically refresh a wildcard domain certificate located at `deploy` folder. Finally adding some configs in crontab to monthly refresh other applications.

1. Requires docker, docker-compose, cron
2. Edit Cloudflare API Token, Account ID, Zone ID in `docker-compose.yml`
3. Edit EMAIL and DOMAIN in `run.sh`
4. Edit nginx config:
```
server {
    ...
    ssl_certificate /path/to/deploy/cert.pem; // public key
    ssl_certificate_key /path/to/deploy/key.pem; // private key
    ...
}

```
5. Run `./run.sh`
6. `crontab -e`, add:
```
0 0 1 * * docker exec nginx nginx -s reload >/dev/null 2>&1
```