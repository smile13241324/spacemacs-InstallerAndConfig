# Run this script in cygwin on your windows box. Cigwin must have xinit and openssh installed.
# Be aware that docker on windows requires you to be admin to run it, however running X as admin is a bad idea.
# My recommendation is to execute the x related path as your local user in a cygwin shell and run the docker command in a separate admin shell.

# Part to run as admin cmd, will start the docker container passing the display
# as environment variable. Make sure that it is correctly set
docker run -d --rm -p "22:22" --mount type=volume,source=spacemacs-home-vol,target=/home/spacemacs smile13241324/spacemacs-installerandconfig sshd

# Interactive commands useful for troubleshooting
docker port spacemacs 22 # Test for the exact port docker used for the containers ssh port
cat ~/.ssh/id_rsa.pub | docker exec -i spacemacs /bin/bash -c "cat >> /spacemacs/.ssh/authorized_keys" # Copy your public key

# Run emacs and initiate x forwarding
ssh -X spacemacs@localhost -p 22 emacs
