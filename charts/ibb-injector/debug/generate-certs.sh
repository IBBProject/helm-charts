#!/bin/bash

echo "Creating ca.key"
openssl genrsa -out ./ca.key 4096

echo "Creating ca.crt"
openssl req -x509 -new -nodes \
  -subj "/C=US/ST=NC/O=IBB/CN=ibb-injector" \
  -config "./csr.conf" \
  -key ./ca.key \
  -sha256 -days 9999 \
  -out ./ca.crt


echo "Creating sidecar-injector.key"
openssl genrsa -out ./sidecar-injector.key 2048

echo "Creating sidecar-injector.csr"
openssl req -new -key ./sidecar-injector.key \
  -out ./sidecar-injector.csr \
  -config "./csr.conf" \
  -subj "/C=US/ST=NC/O=IBB/CN=ibb-injector"

echo "Creating the certificate"
openssl x509 -req -in ./sidecar-injector.csr \
  -CA ./ca.crt \
  -CAkey ./ca.key \
  -CAcreateserial \
  -out ./sidecar-injector.crt \
  -extensions req_ext \
  -extfile ./csr.conf \
  -days 9999 -sha256
