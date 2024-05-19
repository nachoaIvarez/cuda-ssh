#!/bin/bash

# Check if VERSION is passed as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <VERSION>"
  exit 1
fi

VERSION=$1

# Update the LABEL version in the Dockerfile
sed -i.bak -E "s/(LABEL version=\")[^\"]+(\")/\1${VERSION}\2/" Dockerfile

# Build and push the multi-platform docker image
docker buildx build --platform linux/amd64,linux/arm64 -t ghcr.io/nachoaivarez/cuda-ssh:${VERSION} -t ghcr.io/nachoaivarez/cuda-ssh:latest --push .
if [ $? -ne 0 ]; then
  echo "Docker build failed"
  exit 1
fi

# Commit and push the LABEL change to git
git add Dockerfile
git commit -m "${VERSION}"
git push origin master

echo "Docker image successfully built, tagged, and pushed."
