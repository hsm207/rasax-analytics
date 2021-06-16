#!/bin/bash

helm repo add rasa-x https://rasahq.github.io/rasa-x-helm

helm install \
    --generate-name \
    --namespace default \
    --values rasax_values.yml \
    rasa-x/rasa-x

rasa-x-1623858303

helm upgrade rasa-x-1623858303 \
    --values rasax_values.yml \
    rasa-x/rasa-x