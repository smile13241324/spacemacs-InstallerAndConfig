rem Run this script in cygwin on your windows box. Cigwin must have xinit and xorg-server installed.
rem if you cannot find xinit in cygwin, best install all x11 packages its hidden somewhere in there.
for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set IP=%%a
SET DISPLAY=%IP%:0.0
startxwin -- -listen tcp &
xhost + %IP%
docker run -e DISPLAY=%DISPLAY% --mount type=volume,source=spacemacs-home-vol,target=/home/spacemacs smile13241324/spacemacs-installerandconfig emacs