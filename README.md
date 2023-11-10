# IBB Helm Charts

A repository for helm charts.  Uses [chart-releaser](https://github.com/helm/chart-releaser) to automagically build and release charts using Github Actions.

## Howto

Create your chart, add it to the `charts/` directory:

Add, then push your chart to `main` branch. From there the [chart-releaser Action](./.github/workflows/release.yml) will then run to package your chart. It will then use Github pages to "deploy" or "host" the repository.

### Add this repository to helm

```
$ helm repo add ibb https://ibbproject.github.io/helm-charts/

$ helm repo update

$ helm search repo | grep ibb

ibbproject/app-1                                  0.1.0           1.16.0          A Helm chart for Kubernetes
ibbproject/app-2                                  0.1.0           1.16.0          A Helm chart for Kubernetes
```

