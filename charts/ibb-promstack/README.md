# IBB Promstack

Installs Prometheus and Grafana onto an IBB. Includes a tunnel to padi for remote access. It uses the community [kube-prometheus-stack](https://artifacthub.io/packages/helm/prometheus-community/kube-prometheus-stack) as a base chart with custom values.yaml to let it run on an IBB.

## Updating this Chart

```
$ cd ibb-promstack

[Edit Chart.yaml to bump subchart version]

$ helm dependency update
$ helm template --debug .

[ Verify that chart still works ]
```