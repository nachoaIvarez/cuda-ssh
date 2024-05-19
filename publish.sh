#!/bin/bash

# Check if VERSION is passed as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <VERSION>"
  exit 1
fi

VERSION=$1

# Build the docker image
docker build -t nachoaIvarez/cuda-ssh:${VERSION} .
if [ $? -ne 0 ]; then
  echo "Docker build failed"
  exit 1
fi

# Update the LABEL version in the Dockerfile
sed -i.bak -E "s/(LABEL version=\")[^\"]+(\")/\1${VERSION}\2/" Dockerfile

# Commit and push the LABEL change to git
git add Dockerfile
git commit -m "${VERSION}"
git push origin master

# Tag the image with the version and latest
docker tag nachoaIvarez/cuda-ssh:${VERSION} ghcr.io/nachoaivarez/cuda-ssh:${VERSION}
docker tag nachoaIvarez/cuda-ssh:${VERSION} ghcr.io/nachoaivarez/cuda-ssh:latest

# Push the tagged images
docker push ghcr.io/nachoaivarez/cuda-ssh:${VERSION}
docker push ghcr.io/nachoaivarez/cuda-ssh:latest

echo "Docker image successfully built, tagged, and pushed."
