#!/bin/bash

cat <<EOF | microk8s kubectl apply -f -
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: kibana-http-ingress
spec:
  rules:
  - http:
      paths:
      - path: /
        backend:
          serviceName: quickstart-kb-http
          servicePort: 5601

EOF