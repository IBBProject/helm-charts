# IBB Sidecar Injector

Creates a mutating webhook on a Kubernetes cluster to inject a sidecar.

## General Installation

The sidecar injector must be installed into it's own namespace. If installed in a shared namespace, pods will not be injected.

## Usage

```
helm dependency update
helm upgrade --install --namespace sidecar-injector injector .
```

Once the injector is running, annotate the pods you wish to add a sidecar to with the following annotation:

```
type: Deployment
spec:
  template:
    metadata:
      annotations:
        injector.ibbproject.com/inject: "my-awesome-sidecar"
```

Where `my-awesome-sidecar` is the name of the configmap containing the spec of the inject:

```
kind: ConfigMap
metadata:
  name: my-awesome-sidecar
data:
  sidecars.yaml: |
    - name: test-sidecar
      containers:
        - name: webserver
          image: nginx
```

Sidecar names `ibb-tunnel` and `test-sidecar` are included for you in this chart.
