# docker-acme.sh-cf
A script for issuing and installing certificates by [acme.sh](https://github.com/acmesh-official/acme.sh) and Cloudflare DNS API.

1. Install docker, docker-compose
2. Copy `config.env.template` to `config.env` and edit the environment variables.
3. Edit nginx config:
```
server {
    ...
    ssl_certificate /path/to/deploy/cert.pem; // public key
    ssl_certificate_key /path/to/deploy/key.pem; // private key
    ...
}
```
4. Run `docker compose up -d`
5. Run `docker exec -it acme.sh /issue-cert.sh`. The key files will be generated to `./depoly` folder
6. `crontab -e`, add:
```
0 0 * * 1 /path/to/cronjob.sh
```