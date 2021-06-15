#!/bin/bash

# source: https://matthewpalmer.net/kubernetes-app-developer/articles/kubernetes-ingress-guide-nginx-example.html

kubectl apply -f ./apple.yml
kubectl apply -f ./banana.yml
kubectl apply -f ./ingress.yml

curl -kL http://localhost/apple
curl -kL http://localhost/banana
curl -kL http://localhost/notfound