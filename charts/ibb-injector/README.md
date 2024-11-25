# IBB Sidecar Injector

Creates a mutating webhook on a Kubernetes cluster to inject a sidecar.

## Config

### Generating Certificates & Keys

The injector needs a valid certificate and keys in order to mutate incoming deployments. Generate these off the cluster and set them via values.yaml:

```
# Filename: csr.conf

[ req ]
default_bits        = 2048
default_keyfile     = sidecar-injector.key
distinguished_name  = req_distinguished_name
req_extensions      = req_ext # The extentions to add to the self signed cert

[ req_distinguished_name ]
countryName                 = Country Name (2 letter code)
countryName_default         = US
stateOrProvinceName         = State or Province Name (full name)
stateOrProvinceName_default = NC
localityName                = Locality Name (eg, city)
localityName_default        = Ashville
organizationName            = Organization Name (eg, company)
organizationName_default    = IBB
commonName                  = Common Name (eg, YOUR name)
commonName_default          = ibb-injector
commonName_max              = 64

[ req_ext ]
subjectAltName          = @alt_names

[alt_names]
DNS.1   = ibb-injector
DNS.2   = ibb-injector.kube-system
DNS.3   = ibb-injector.kube-system.svc
```

```bash
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
```


## General Installation

```
helm upgrade \
  --install ibb-tunnel-injector \
  ibb/ibb-injector \
  --namespace kube-system \
  --set-file injector.caCrt=ca.crt \
  --set-file injector.sidecarInjectorCrt=sidecar-injector.crt \
  --set-file injector.sidecarInjectorKey=sidecar-injector.key \
  --wait
```

## Usage

After installing, check that the injector is working:

```
$ ks get deploy -n kube-system ibb-injector
```

Once the injector is running, annotate the pods you wish to add a sidecar to with the following annotation:

```
type: Deployment
spec:
  template:
    metadata:
      annotations:
        injector.ktunnel.ibbproject.com/request: [REQUEST]
```

Where `[REQEUST]` is the configuration `name` in the `injection-configs` configmap.

Example:

```
kind: ConfigMap
data:
  foo.conf: |
    name: do-something-sidecar
    containers:
    - name: [ ... ]
      image: [ ... ]
```

The annotation would be:

```
type: Deployment
spec:
  template:
    metadata:
      annotations:
        injector.ktunnel.ibbproject.com/request: do-something-sidecar
```
