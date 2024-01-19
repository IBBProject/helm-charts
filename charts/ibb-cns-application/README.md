# IBB CNS Dapr Application

A helm chart for installing a CNS Dapr Client application onto an IBB Cluster

You'll probably want to set the following values at a minimum:

```
image.repository
image.tag

ktunnel.enabled
service.port

cnsContext
cnsToken
```

## Using this chart locally

Being connected to a cluster, with this helm repository already installed to your local machine, to use this chart you can simply do the following:

```
helm repo update

helm upgrade --install \
  [ --namespace=NAMESPACE ] \
  --set image.repository=CONTAINER_IMAGE \
  --set image.tag=CONTAINER_TAG \
  --set service.port=PORT \
  --set ktunnel.enabled=True \
  --set ktunnel.id=ID \
  --set cnsDapr.context=CONTEXT \
  --set cnsDapr.token=TOKEN \
  ibb/ibb-application \
  my-application
```

This will install this chart with your CONTAINER_IMAGE:TAG to your cluster and set up a ktunnel back to the upstream cluster, proxying `service.port` to the upstream cluster.

