#!/usr/bin/env bash
set -e

# This script is for running spacemacs in wsl2 from docker transfering the screen via wayland.
# For this wsl2 needs to be updated to the latest version as well as your system must be
# ready to pass gpus to containers.
#
# In theory this works with all distros in wsl2 but has only been tested with Ubuntu as it is
# the default from Microsoft and in general has the best support by WSL2.
#
# Some details of how to do this can be found below:
https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html
https://github.com/microsoft/wslg/blob/main/samples/container/Containers.md
https://wiki.archlinux.org/title/Hardware_video_acceleration
https://learn.microsoft.com/en-us/windows/wsl/tutorials/gui-apps

# Make sure that the shared files are accessible from your container.
sudo chmod 777 /mnt/wslg
sudo chmod 777 /mnt/wslg/runtime-dir/ -R
sudo chmod 777 /var/run/docker.sock

# Make sure that emacs knows that his directory is safe.
sudo chmod 700 /mnt/wslg/runtime-dir/emacs -R

# Start spacemacs in your container using the host network and pass in all devices and mounts from your wsl2 environment
# this should open a wayland window if it does not or fallback to X something is wrong.
docker run -it --rm --network=host --name spacemacsBox --mount type=volume,source=spacemacs-home-vol,target=/home/spacemacs -v /var/run/docker.sock:/var/run/docker.sock -v /tmp/.X11-unix:/tmp/.X11-unix -v /mnt/wslg:/mnt/wslg -v /usr/lib/wsl:/usr/lib/wsl -v /etc/localtime:/etc/localtime:ro --device=/dev/dxg --device /dev/dri/card0 --device /dev/dri/renderD128 -e DISPLAY -e WAYLAND_DISPLAY -e XDG_RUNTIME_DIR -e PULSE_SERVER -e LIBVA_DRIVER_NAME=d3d12 -e LD_LIBRARY_PATH=/usr/lib/wsl/lib --gpus all smile13241324/spacemacs-installerandconfig emacs&

# For some config like importing lokal certs you can login as root
# do this everytime you start emacs as it will change system files
# which are not persisted.
# docker exec -it -u root spacemacsBox bash
# trust anchor /home/spacemacs/certs.pem
# update-ca-trust
# exit
