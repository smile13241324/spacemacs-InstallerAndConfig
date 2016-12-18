#!/bin/bash

# Install external packages
sudo pacman -Syyu
sudo pacman -S git emacs the_silver_searcher vim cmake extra-cmake-modules python autoconf automake gdb gdb-common lldb shellcheck sbcl adobe-source-code-pro-fonts clang clang-tools-extra libc++ libc++abi boost boost-libs llvm llvm-libs python-pytest python-pip python-mock python-setuptools cscope npm nodejs nodejs-less npm-check-updates luarocks docker ctags python-pygments fish fisherman maven eclipse-java visualvm openjdk8-doc jdk8-openjdk gnuplot go go-tools
sudo pacman -S $(pacman -Ssq texlive*)

# Install python packages
sudo -H pip install pip jedi json-rpc service_factory autoflake hy pycscope
sudo -H pip install --upgrade pip jedi json-rpc service_factory autoflake hy pycscope

# Install nodejs dependencies
sudo npm install -g tern js-beautify eslint babel-eslint eslint-plugin-react vmd

# Install lua dependencies
sudo luarocks install luacheck
sudo luarocks install lanes

# Get newest spacemacs
spacemacsInstallationDir="${HOME}/.emacs.d"
[[ ! -d "${spacemacsInstallationDir}" ]] && git clone https://github.com/syl20bnr/spacemacs "${spacemacsInstallationDir}"
cd "${spacemacsInstallationDir}" || exit
git checkout origin/develop --track
git checkout develop
git pull
cd "${DIR}" || exit
cp .spacemacs ~/.spacemacs

# Set base path
installBaseDir="${HOME}/.spacemacsInstall"
mkdir "${installBaseDir}"

# Set current path
SOURCE="${BASH_SOURCE[0]}"
while [[ -h "$SOURCE" ]]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# Build gnu global
globalBaseDir="${installBaseDir}/global"
globalCurrentVersionExtractDir="${globalBaseDir}/global-6.5.5"
if [[ ! -d "${globalCurrentVersionExtractDir}" ]]; then
    mkdir "${globalBaseDir}"
    wget -O "${globalBaseDir}/global.tar.gz" http://tamacom.com/global/global-6.5.5.tar.gz
    tar -xpvf  "${globalBaseDir}/global.tar.gz" --directory "${globalBaseDir}"
    cd "${globalCurrentVersionExtractDir}" || exit
    ./configure --with-exuberant-ctags=/usr/bin/ctags
    make
    sudo make install
    make clean
    cp gtags.conf ~/.globalrc

    #Add gtags config string only if not already existing
    if grep -Fxq "GTAGSLABEL=pygments" ~/.profile
    then
        echo "nothing to do"
    else
        echo export GTAGSLABEL=pygments >> ~/.profile
    fi
fi
cd "${DIR}" || exit

# Install fish terminal
fishConfigDir="${HOME}/.config/fish"
fishConfigFile="${fishConfigDir}/config.fish"
mkdir "${fishConfigDir}"
TERMINFO="$(locate eterm-color.ti)"
tic -o ~/.terminfo ${TERMINFO}
[[ ! -f "${fishConfigFile}" ]] && echo "# emacs ansi-term support
if test -n \"\$EMACS\"
  set -x TERM eterm-color
end

# this function may be required
function fish_title
  true
end" >> "${fishConfigFile}"

# Install java interface server
javaServerBaseDir="${installBaseDir}/eclim"
javaServerCurrentVersionExtractDir="${javaServerBaseDir}/2.6.0"
if [[ ! -d "${javaServerCurrentVersionExtractDir}" ]]; then
    mkdir "${javaServerBaseDir}"
    mkdir "${javaServerCurrentVersionExtractDir}"
    wget -O "${javaServerCurrentVersionExtractDir}/eclim.jar" https://github.com/ervandew/eclim/releases/download/2.6.0/eclim_2.6.0.jar
    java -Djava.net.useSystemProxies=true -jar "${javaServerCurrentVersionExtractDir}/eclim.jar"
fi
cd "${DIR}" || exit
