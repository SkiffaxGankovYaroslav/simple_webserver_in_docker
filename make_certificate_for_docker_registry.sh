#!/bin/bash
mkdir registry
mkdir -p registry/certs
mkdir -p registry/auth
cd registry/certs
openssl genrsa 1024 > domain.key
chmod 400 domain.key
#find out the external ip address
whiteIP=$(curl ifconfig.co)

echo "[req]" > san.cnf
echo "default_bits  = 2048" >> san.cnf
echo "distinguished_name = req_distinguished_name" >> san.cnf
echo "req_extensions = req_ext" >> san.cnf
echo "x509_extensions = v3_req" >> san.cnf
echo "prompt = no" >> san.cnf
echo "[req_distinguished_name]" >> san.cnf
echo "countryName = XX" >> san.cnf
echo "stateOrProvinceName = N/A" >> san.cnf
echo "localityName = N/A" >> san.cnf
echo "organizationName = Self-signed certificate" >> san.cnf
echo "commonName = 120.0.0.1: Self-signed certificate" >> san.cnf
echo "[req_ext]" >> san.cnf
echo "subjectAltName = @alt_names" >> san.cnf
echo "[v3_req]" >> san.cnf
echo "subjectAltName = @alt_names" >> san.cnf
echo "[alt_names]" >> san.cnf
echo "IP.1 = $whiteIP" >> san.cnf

openssl req -new -x509 -nodes -sha1 -days 365 -key domain.key -out domain.crt -config san.cnf

cd ../auth
#
docker run --rm --entrypoint htpasswd registry:2.7.0 -Bbn USERNAME Display-and-rotate-the-root-CA1 > htpasswd

#deploy registry server
cd ~/registry
docker run -d \
--restart=always \
--name registry \
-v `pwd`/auth:/auth \
-v `pwd`/certs:/certs \
-v `pwd`/certs:/certs \
-e REGISTRY_AUTH=htpasswd \
-e REGISTRY_AUTH_HTPASSWD_REALM="Registry Realm" \
-e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
-e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
-e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
-e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
-p 443:443 \
-p 5000:5000 \
registry:2.7.0