#!/bin/bash

tagName=${1}
shortenedTag="$(echo $tagName | head -c 7)"
shaTag="sha-${shortenedTag}"

echo "Building Image Version: $shaTag"

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
        image: dokun1/afterparty-server-testing:'$shaTag'
        ports:
        - containerPort: 8080' > ./kube/afterparty-deployment.yaml

