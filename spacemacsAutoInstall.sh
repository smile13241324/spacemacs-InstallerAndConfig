#!/bin/bash

# Set base path
installBaseDir="${HOME}/.spacemacsInstall"

# Set current path
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# Install general dependencies
sudo apt-get install -y libncurses5-dev git silversearcher-ag silversearcher-ag-el curl wget vim build-essential cmake python python-dev python-all python-all-dev libgtk-3-dev libwebkitgtk-3.0-dev libgtk-3-common libgtk-3-0 autoconf automake gdb unzip

# Git config
git config --global user.name "smile13241324"
git config --global user.email "smile13241324@gmail.com"
git config --global credential.helper cache

# Build emacs package
emacsBaseDir="${installBaseDir}/emacs"
sudo apt-get build-dep -y emacs24
sudo apt-get purge -y postfix #Remove stupid dependency on mail server.
sudo apt-get autoremove -y
git clone git://git.savannah.gnu.org/emacs.git "${emacsBaseDir}"
cd "${emacsBaseDir}" || exit
git checkout origin/emacs-25 --track
./autogen.sh
./configure --with-cairo --with-xwidgets --with-x-toolkit=gtk3 --with-modules
make
sudo make install
make clean
cd "${DIR}" || exit

# Get adobe fonts
fontsBaseDir="${installBaseDir}/fonts"
fontsTargetDir="${HOME}/.fonts"
mkdir "${fontsBaseDir}"
mkdir "${fontsTargetDir}"
wget -O "${fontsBaseDir}/fonts.tar.gz" https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.tar.gz
tar -zxvf "${fontsBaseDir}/fonts.tar.gz" --directory "${fontsBaseDir}"
cd "${fontsBaseDir}/source-code-pro-2.030R-ro-1.050R-it/OTF" || exit
cp ./* "${fontsTargetDir}"
sudo fc-cache
cd "${DIR}" || exit

# Get newest spacemacs
rm ~/.emacs.d -R
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
cp spacemacs ~/.spacemacs

# Make spacemacs unity icon
echo "[Desktop Entry] 
Name=Spacemacs
GenericName=Text Editor
Comment=Edit text
MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;
Exec=emacs %F
Icon=${HOME}/.emacs.d/core/banners/img/spacemacs.png
Type=Application
Terminal=false
Categories=Development;TextEditor;
StartupWMClass=Emacs" >> ~/.local/share/applications/spacemacs.desktop

# Install c++ layer dependencies
sudo apt-get install -y clang clang-format clang-tidy libclang-dev libclang1 libc++1 libc++-dev libc++-helpers libc++abi1 libc++abi-dev libboost-all-dev lldb llvm llvm-dev llvm-runtime

# Install python layer dependencies
sudo apt-get install -y python-pytest python-pip python-mock python-setuptools-doc
pip install pip jedi json-rpc service_factory autoflake hy
pip install --upgrade pip jedi json-rpc service_factory autoflake hy

# Install cscope dependencies
sudo apt-get install -y cscope cscope-el
pip install pycscope
pip install --upgrade pycscope

# Build gnu global
globalBaseDir="${installBaseDir}/global"
mkdir "${globalBaseDir}"
sudo apt-get install -y exuberant-ctags python-pygments
wget -O "${globalBaseDir}/global.tar.gz" http://tamacom.com/global/global-6.5.5.tar.gz
tar -zxvf "${globalBaseDir}/global.tar.gz" --directory "${globalBaseDir}"
cd "${globalBaseDir}/global-6.5.5" || exit
./configure --with-exuberant-ctags=/usr/bin/ctags
make
sudo make install
make clean
cp gtags.conf ~/.globalrc
echo export GTAGSLABEL=pygments >> ~/.profile
cd "${DIR}" || exit
