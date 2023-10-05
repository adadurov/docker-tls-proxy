#!/bin/bash


# assuming there are server.crt and server.key in the current directory

rm server.pem
openssl x509 -in server.crt -out server.pem -outform PEM

docker rmi -f docker-tls-proxy
docker build -t docker-tls-proxy .
docker run \
  -it \
  -e UPSTREAM_HOST=ya.ru \
  -e FORCE_HTTPS=true \
  -e ENABLE_HTTP2=true \
  -e ENABLE_WEBSOCKET=true \
  -e SELF_SIGNED=false \
  -p 80:80 \
  -p 443:443 \
  docker-tls-proxy
