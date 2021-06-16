#!/bin/bash

# get rabbit server name
kubectl get svc
# replace with host in logstash-cm

kubectl apply -f logstash_config/logstash-cm.yml
kubectl get cm

kubectl apply -f logstash_config/logstash-pod.yml

kubectl logs logstash