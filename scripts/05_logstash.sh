#!/bin/bash

# get rabbit service name
kubectl -n $RASAX_NS get  svc
# replace with host in logstash-cm

kubectl -n $RASAX_NS apply -f logstash_config/logstash-cm.yml
kubectl get cm

kubectl -n $RASAX_NS apply -f logstash_config/logstash-pod.yml

kubectl logs logstash