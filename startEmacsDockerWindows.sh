# Run this script in cygwin on your windows box. Cygwin must have xinit and openssh installed.
# Be aware that docker on windows requires you to be admin to run it, however running X as admin is a bad idea.
# My recommendation is to execute the X related commands as your local user in a cygwin shell and run the docker command in a separate admin shell.

# Part to run as local user in cygwin or any other linux shell
export DISPLAY=:0.0
startxwin&
sleep 360s # Wait till the server is ready

# Part to run as local user in cygwin or any other linux shell
# Check that you have a public key. If you don't, generate one preferably with a new algorithm i.e. ssh-keygen -t ecdsa -b 521.

# Part to run as admin in powershell, will start the docker container's sshd service and expose it on port 22 using default server keys in /etc/ssh
# these keys should be overwritten in a root session in the container by means of the docker deamon or by adding a customised version of host certs by means of a lokal bind
# To regenerate the server keys do rm /etc/ssh/ssh_host_* && ssh-keygen -A on the container connected via "docker exec -it -u root spacemacsBox fish".
# In addition you also need to put your public key in "/home/spacemacs/.ssh/authorized_keys" during your root session.
# Make sure that the folder and all files within are owned by spacemacs.

# It is also possible to give the container access to your docker deamon
# allowing to control docker on the host from within this container.
# To do so use the alternative command:
# docker run -u root -d --rm -p "22:22" --hostname spacemacsBox --name spacemacsBox --mount type=volume,source=spacemacs-home-vol,target=/home/spacemacs --mount type=volume,source=spacemacs-hostCert-vol,target=/etc/ssh -v /var/run/docker.sock:/var/run/docker.sock smile13241324/spacemacs-installerandconfig /usr/bin/sshd -D
# To start the container and connect with "docker exec -it -u spacemacs spacemacsBox fish"
docker run -u root -d --rm -p "22:22" --hostname spacemacsBox --name spacemacsBox --mount type=volume,source=spacemacs-home-vol,target=/home/spacemacs --mount type=volume,source=spacemacs-hostCert-vol,target=/etc/ssh smile13241324/spacemacs-installerandconfig /usr/bin/sshd -D

# Part to run in cygwin or any other linux shell
# ssh into the server enabling X forwarding and replacing insecure X based authentification with ssh X authentification spoofing
nohup ssh -Y spacemacs@localhost -p 22 emacs&
