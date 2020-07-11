#!/bin/bash

tagName=${1}
shortenedTag="$(echo $tagName | head -c 7)"
shaTag="sha-${shortenedTag}"

echo "Building image version for staging: $shaTag"

rm -f ./kube/afterparty-staging-deployment.yaml

echo 'apiVersion: apps/v1
kind: Deployment
metadata:
  name: afterparty
spec:
  selector:
    matchLabels:
      app: afterparty-staging
  replicas: 1
  template:
    metadata:
      labels:
        app: afterparty-staging
    spec:
      containers:
      - name: afterparty-staging
        image: dokun1/afterparty-server:'$shaTag'
        ports:
        - containerPort: 8080' > ./kube/afterparty-staging-deployment.yaml

