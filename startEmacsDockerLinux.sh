#!/bin/bash
set -e

# Run this script on your linux box, it will use your local X server port, no need to expose any ports.
docker run -ti --rm -e DISPLAY="unix$DISPLAY" --network=host --mount type=volume,source=spacemacs-home-vol,target=/home/spacemacs smile13241324/spacemacs-installerandconfig emacs
