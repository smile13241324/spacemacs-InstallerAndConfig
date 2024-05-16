#!/bin/bash
set -e

docker buildx build ./ --tag smile13241324/spacemacs-installerandconfig
docker push smile13241324/spacemacs-installerandconfig
