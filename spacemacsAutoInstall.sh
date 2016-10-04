#!/bin/bash

# Set base path
installBaseDir="${HOME}/.spacemacsInstall"

# Install general dependencies
sudo apt-get install -y libncurses5-dev git silversearcher-ag silversearcher-ag-el curl wget vim build-essential cmake python-all python-all-dev libgtk-3-dev python- libwebkitgtk-3.0-dev libgtk-3-common libgtk-3-0 autoconf automake gdb

# Git config
git config --global user.name "smile13241324"
git config --global user.email "smile13241324@gmail.com"
git config --global credential.helper cache

# Build emacs package
emacsBaseDir="${installBaseDir}/emacs"
sudo apt-get build-dep -y emacs24
git clone git://git.savannah.gnu.org/emacs.git "${emacsBaseDir}"
"${emacsBaseDir}/configure --with-cairo --with-xwidgets --with-x-toolkit=gtk3 --with-modules"
"${emacsBaseDir}/make"
"${emacsBaseDir}/sudo make install"
"${emacsBaseDir}/make clean"

# Get adobe fonts 
fontsBaseDir="${installBaseDir}/fonts"
git clone https://github.com/adobe-fonts/source-code-pro.git "${fontsBaseDir}"
"${fontsBaseDir}/build.sh"
cp "${fontsBaseDir}/target/OTF/* ~/.fonts"
sudo fc-cache

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
sudo apt-get install -y clang clang-format clang-tidy libclang-dev libclang1 libc++1 libc++-dev libc++-helpers libc++abi1 libc++abi-dev libc++-test libc++abi-test libboost-all-dev lldb llvm llvm-dev llvm-runtime

# Install python layer dependencies
sudo apt-get install -y python-pytest python-pip python-mock python-setuptools-doc
pip install --upgrade pip
pip install jedi json-rpc service_factory autoflake hy

# Install cscope dependencies
sudo apt-get install -y cscope cscope-el
pip install pycscope

# Build gnu global
globalBaseDir="${installBaseDir}/global"
sudo apt-get install -y exuberant-ctags python-pygments
wget -O "${globalBaseDir}/global.tar.gz" http://tamacom.com/global/global-6.5.5.tar.gz
tar -zxvf global.tar.gz --directory "${globalBaseDir}"
"${globalBaseDir}/configure --with-exuberant-ctags=/usr/bin/ctags"
"${globalBaseDir}/make"
"${globalBaseDir}/sudo make install"
"${globalBaseDir}/make clean"
cp "${globalBaseDir}/gtags.conf ~/.globalrc"
echo export GTAGSLABEL=pygments >> .profile
