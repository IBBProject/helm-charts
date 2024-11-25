#!/bin/bash

helm upgrade \
  --install ibb-injector \
  .. \
  --namespace kube-system \
  --set-file injector.caCrt=ca.crt \
  --set-file injector.sidecarInjectorCrt=sidecar-injector.crt \
  --set-file injector.sidecarInjectorKey=sidecar-injector.key \
  --wait

