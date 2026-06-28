# Project Arete Helm Chart

This is the primary means of installing Arete on your IBB.

When changes are made to the depedent charts, update this chart with the following command:

```
$ cd charts/arete
$ helm dependency update
```

Save and commit the changes with the packaged dependencies

Use

```
helm upgrade --install --set arete-etcd.etcd.istioGateway.enabled=false my-arete arete/arete
```