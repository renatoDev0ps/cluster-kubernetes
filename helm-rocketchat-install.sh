#!/bin/bash

helm install --set mongodb.mongodbUsername=rocketchat,mongodb.mongodbPassword=rocketchat123,mongodb.mongodbDatabase=rocketchat,mongodb.mongodbRootPassword=root --name rocketchat stable/rocketchat

helm install --name rocketchat -f values.yaml stable/rocketchat

kubectl port-forward --namespace default $(kubectl get pods --namespace default -l "app.kubernetes.io/name=rocketchat,app.kubernetes.io/instance=rocketchat" -o jsonpath='{ .items[0].metadata.name }') 8888:3000