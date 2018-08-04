#!/bin/bash
# Run this script on your linux box, make sure that the container is allowed to
# connect to your X server.

docker run -ti -e DISPLAY="unix$DISPLAY" --network=host --mount type=volume,source=spacemacs-home-vol,target=/home/spacemacs smile13241324/spacemacs-InstallerAndConfig emacs
