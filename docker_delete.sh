#!/bin/sh
# kubectl delete deployment,pods,rs,services --all --grace-period=0 --force
sudo kubectl apply --prune -f ./deployment/server-deployment.yaml --record