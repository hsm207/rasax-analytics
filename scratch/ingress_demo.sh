#!/bin/bash
echo `pwd`
microk8s kubectl apply -f ./apple.yml
microk8s kubectl apply -f ./banana.yml
microk8s kubectl apply -f ./ingress.yml

curl -kL http://localhost/apple
curl -kL http://localhost/banana
curl -kL http://localhost/notfound