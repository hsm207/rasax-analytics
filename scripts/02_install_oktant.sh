#!/bin/bash

wget https://github.com/vmware-tanzu/octant/releases/download/v0.20.0/octant_0.20.0_Linux-64bit.deb && \
    sudo dpkg -i octant_0.20.0_Linux-64bit.deb

# run octant with:
# octant --kubeconfig /var/snap/microk8s/current/credentials/client.config