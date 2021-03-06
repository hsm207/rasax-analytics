#!/bin/bash

# from: https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-quickstart.html


# The operator
# install custom resource and RBAC rules:
# creates a namespace called elastic-system
microk8s kubectl apply -f https://download.elastic.co/downloads/eck/1.6.0/all-in-one.yaml


# The Elasticsearch cluster
# creates in the in the same Rasa X namespace
cat <<EOF | microk8s kubectl --namespace $RASAX_NS apply -f -
apiVersion: elasticsearch.k8s.elastic.co/v1
kind: Elasticsearch
metadata:
  name: quickstart
spec:
  version: 7.13.2
  nodeSets:
  - name: default
    count: 1
    config:
      node.store.allow_mmap: false
EOF

# Test that you can access the endpoint (ClusterIP)
# get password 
PASSWORD=$(microk8s kubectl get secret quickstart-es-elastic-user -o go-template='{{.data.elastic | base64decode}}') && \
    echo $PASSWORD

# inside a pod in the same namespace as the elasticsearch cluster, run
# curl -u "elastic:$PASSWORD" -k "https://quickstart-es-http:9200"


# The Kibana instance
# also creates it in the same Rasa X namespace
# adjust from quickstart guide to make it reachable from /kibana path
# ref:
# * https://discuss.elastic.co/t/expose-kibana-behind-a-subpath-using-gce-ingress/267987
# * https://github.com/elastic/cloud-on-k8s/issues/2118
cat <<EOF | microk8s kubectl -n $RASAX_NS apply -f -
apiVersion: kibana.k8s.elastic.co/v1
kind: Kibana
metadata:
  name: quickstart
spec:
  version: 7.13.2
  count: 1
  config:
    server:
      basePath: "/kibana"
      rewriteBasePath: true
  elasticsearchRef:
    name: quickstart
  http:
    tls:
      selfSignedCertificate:
        disabled: true
  podTemplate:
    spec:
      containers:
      - name: kibana
        readinessProbe:
          httpGet:
            path: /kibana/login
            port: 5601
EOF

# display the kibana UI password (username is elastic)
microk8s kubectl get secret quickstart-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode; echo
# to login to the UI...
microk8s kubectl port-forward service/quickstart-kb-http 5601

