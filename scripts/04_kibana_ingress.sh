#!/bin/bash

# access the Kibana UI with /kibana because / is for Rasa X UI
cat <<EOF | microk8s kubectl -n $RASAX_NS apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: kibana-http-ingress
spec:
  rules:
  - http:
      paths:
      - path: /kibana
        pathType: Prefix
        backend:
          service:
            name: quickstart-kb-http
            port:
              number: 5601

EOF