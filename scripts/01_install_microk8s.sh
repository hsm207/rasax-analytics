#!/bin/bash

# from: https://microk8s.io/docs
sudo snap install microk8s --classic --channel=1.21
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube

sudo microk8s enable dns storage

# alias for kubectl
sudo snap alias microk8s.kubectl kubectl


# install helm
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# add NGINX Ingress Controller
# install's into the default namespace
microk8s kubectl config view --raw >~/.kube/config
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx

# from: https://microk8s.io/docs/addon-ingress
sudo microk8s enable ingress

# To check the ingress controller version:
POD_NAME=$(microk8s kubectl get pods -l app.kubernetes.io/name=ingress-nginx -o jsonpath='{.items[0].metadata.name}')

microk8s kubectl exec -it $POD_NAME -- /nginx-ingress-controller --version


# official docs: https://kubernetes.github.io/ingress-nginx/