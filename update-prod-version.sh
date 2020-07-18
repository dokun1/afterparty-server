#!/bin/bash

tagName=${1}

echo "Building Image Version: $tagName"

rm -f ./kube/afterparty-deployment.yaml

echo 'apiVersion: apps/v1
kind: Deployment
metadata:
  name: afterparty
spec:
  selector:
    matchLabels:
      app: afterparty
  replicas: 1
  template:
    metadata:
      labels:
        app: afterparty
    spec:
      containers:
      - name: afterparty
        image: dokun1/afterparty-server:'$tagName'
        ports:
        - containerPort: 8080' > ./kube/afterparty-deployment.yaml

