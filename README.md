# my own (almost) secure registry

## create a self-signed certificate

    openssl req -newkey rsa:4096 -nodes -sha256 -keyout certs/domain.key -x509 -days 365 -out certs/domain.crt

## create http auth credentials

> Note: That will be used to populate the default credentials (in the image).

    docker-compose run --entrypoint htpasswd registry -Bbn $REGISTRY_USER "$REGISTRY_PASS" >> auth/htpasswd

> Note: If you want to add credentials at runtime, try:

    docker-compose exec registry sh -c 'htpasswd -Bbn test testpass >> /auth/htpasswd'
    docker-compose restart registry

## run it

    docker-compose build
    docker-compose up -d

## configure your daemon to authorize this registry

> Note: Only if you used a self-signed certificate, you need to tell docker daemon to trust it:

### with systemd

    sudo -E systemctl edit docker.service

Then paste (and adapt) the following content:

```
[Service]
ExecStart=
ExecStart=/usr/bin/docker daemon -H fd:// --insecure-registry=<ip-of-my-registry>:5000
```

    sudo systemctl restart docker

### with rancheros

    sudo ros config set rancher.docker.extra_args "['--insecure-registry','<ip-of-my-registry>:5000']"
    sudo system-docker restart docker


