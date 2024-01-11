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