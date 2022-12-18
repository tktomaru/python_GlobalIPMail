#!/bin/sh

sudo docker image tag gipmail/app:latest 192.168.100.152:5000/gipmail/gipmail:latest
sudo docker push 192.168.100.152:5000/gipmail/gipmail:latest
kubectl apply -f ./deployment/server-deployment.yaml --record


