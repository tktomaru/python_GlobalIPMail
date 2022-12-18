#!/bin/sh
kubectl get pods -o wide  --show-labels
kubectl get nodes --show-labels

