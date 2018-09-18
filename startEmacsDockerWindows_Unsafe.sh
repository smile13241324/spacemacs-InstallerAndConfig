#!/bin/bash
# Run this script in cygwin on your windows box. Cigwin must have xinit and
# xorg-server installed.
IP="$( ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/' )"

# Run this as local user
export DISPLAY=${IP}:0.0
startxwin -- -listen tcp &
xhost + ${IP}

# Run this as admin
docker run -e DISPLAY="$DISPLAY" --mount type=volume,source=spacemacs-home-vol,target=/home/spacemacs smile13241324/spacemacs-InstallerAndConfig emacs