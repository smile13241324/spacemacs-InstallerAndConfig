# Run this script in cygwin on your windows box. Cigwin must have xinit, xhost, xauth and xorg-server installed.
# Be aware that docker on windows requires you to be admin to run it, however running X as admin is a bad idea.
# My recommendation is to execute the x related path as your local user in a cygwin shell and run the docker command in a separate admin shell.
IP="Your local ip goes here"
export DISPLAY=$IP:0.0

# Part to run as local user
startxwin -- -listen tcp& # Start the actual X server in the background.
xhost $IP # Allow connection to your local pc. Does only work when DISPLAY is set!

# Part to run as admin cmd, will start the docker container passing the display
# as environment variable. Make sure that it is correctly set
docker run -e DISPLAY=$DISPLAY --mount type=volume,source=spacemacs-home-vol,target=/home/spacemacs smile13241324/spacemacs-installerandconfig emacs
