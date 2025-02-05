# Edge Central on  IBB

## Getting Started

1. Create a secret with your license included:

```
kubectl create secret generic \
  edgecentral-license --from-file=license.lic
```

2. Install the chart

```
helm upgrade --install my-ec ibb/edge-central
```

If using cns-dapr, add the following authorization to the end of the `helm upgrade --install` command:

```
--set cnsDapr.enabled=True --set cnsDapr.cnsContext="<CONTEXT>" --set cnsDapr.cnsToken="<TOKEN"
```

