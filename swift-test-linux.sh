#!/bin/sh
echo "Building testing container..."
docker build -t dokun1/afterparty-server-tests:local -f Dockerfile-testing .
echo "Running test container..."
docker run dokun1/afterparty-server-tests:local
