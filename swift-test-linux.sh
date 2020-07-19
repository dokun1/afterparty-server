#!/bin/sh
docker build -t dokun1/afterparty-server-tests:local -f Dockerfile-testing .
docker run dokun1/afterparty-server-tests:local
