#!/bin/bash

# Set base path
installBaseDir="~/.spacemacsInstall"

# Install general depencies
sudo apt-get install libncurses5-dev git silversearcher-ag silversearcher-ag-el curl wget vim build-essential cmake

# Git config
git config --global user.name "smile13241324"
git config --global user.email "smile13241324@gmail.com"
git config --global credential.helper cache

# Build emacs package
emacsBaseDir=${installBaseDir}/emacs
sudo apt-get build-dep emacs24
git clone git://git.savannah.gnu.org/emacs.git ${emacsBaseDir}
${emacsBaseDir}/configure
${emacsBaseDir}/make
${emacsBaseDir}/sudo make install
${emacsBaseDir}/make clean

# Get adobe fonts 
fontsBaseDir=${installBaseDir}/fonts
https://github.com/adobe-fonts/source-code-pro.git ${fontsBaseDir}
${fontsBaseDir}/build.sh
cp ${fontsBaseDir}/target/OTF/* ~/.fonts
sudo fc-cache

# Get newest spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
cp spacemacs ~/.spacemacs

# Install c++ layer dependencies
sudo apt-get install clang clang-format clang-tidy libclang libclang-dev libc++ libc++-dev libc++-helpers libc++abi libc++abi-dev clang-modernize libclang-common-dev libclang-common libboost-all-dev libboost-all

# Install python layer dependencies
sudo apt-get install python-dev pytest
pip install jedi json-rpc service_factory autoflake hy

# Install cscope dependencies
sudo apt-get install cscope
pip install pycscope

# Build gnu global
globalBaseDir=${installBaseDir}/global
sudo apt-get install exuberant-ctags python-pygments
wget -O ${globalBaseDir}/global.tar.gz http://tamacom.com/global/global-6.5.5.tar.gz
tar -zxvf global.tar.gz --directory ${globalBaseDir}
${globalBaseDir}/configure --with-exuberant-ctags=/usr/bin/ctags
${globalBaseDir}/make
${globalBaseDir}/sudo make install
${globalBaseDir}/make clean
cp ${globalBaseDir}/gtags.conf ~/.globalrc
echo export GTAGSLABEL=pygments >> .profile