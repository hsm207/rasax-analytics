#!/bin/bash

# from: https://microk8s.io/docs
sudo snap install microk8s --classic --channel=1.21
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube

sudo microk8s enable dns storage

# alias for kubectl
sudo snap alias microk8s.kubectl kubectl


# add NGINX Ingress Controller
# from: https://microk8s.io/docs/addon-ingress
sudo microk8s enable ingress
# official docs: https://kubernetes.github.io/ingress-nginx/