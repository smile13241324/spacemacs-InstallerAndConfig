# Run this script in cygwin on your windows box. Cigwin must have xinit and openssh installed.
# Be aware that docker on windows requires you to be admin to run it, however running X as admin is a bad idea.
# My recommendation is to execute the X related commands as your local user in a cygwin shell and run the docker command in a separate admin shell.

# Part to run as local user in cygwin
export DISPLAY=localhost:0.0
startxwin&
sleep 360s # Wait till the server is ready

# Part to run as admin in powershell, will start the docker container's sshd service and expose it on port 22
docker run -u root -d --rm -p "22:22" --mount type=volume,source=spacemacs-home-vol,target=/home/spacemacs smile13241324/spacemacs-installerandconfig /usr/bin/sshd -D

# Second part to run as local user in cygwin
# Command to transfer your public key to the container, need only be done once per volume
# ssh-copy-id -p 22 spacemacs@localhost

# ssh into the server enabling X forwarding and replacing insecure X based authentification with ssh X authentification spoofing
ssh -Y spacemacs@localhost -p 22 emacs