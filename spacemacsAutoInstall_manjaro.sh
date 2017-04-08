#!/bin/bash

# Install external packages
sudo pacman -Syyu
sudo pacman -S git tcl tk emacs the_silver_searcher vim wget curl cmake extra-cmake-modules python autoconf automake gdb gdb-common lldb shellcheck sbcl adobe-source-code-pro-fonts clang clang-tools-extra boost boost-libs llvm llvm-libs python-pytest python-pip python-mock python-setuptools cscope npm nodejs nodejs-less npm-check-updates luarocks docker ctags python-pygments fish fisherman maven eclipse-java visualvm openjdk8-doc jdk8-openjdk gnuplot go go-tools texlive-bin texlive-core texlive-fontsextra texlive-formatsextra texlive-games texlive-genericextra texlive-htmlxml texlive-humanities texlive-langchinese texlive-langcjk texlive-langcyrillic texlive-langextra texlive-langgreek texlive-langjapanese texlive-langkorean texlive-latexextra texlive-music texlive-pictures texlive-plainextra texlive-pstricks texlive-publishers texlive-science texlive-bibtexextra

# Install python packages
sudo -H pip install pip jedi json-rpc service_factory autoflake hy pycscope flake8
sudo -H pip install --upgrade pip jedi json-rpc service_factory autoflake hy pycscope flake8

# Install nodejs dependencies
sudo npm install -g tern js-beautify eslint babel-eslint eslint-plugin-react vmd

# Install lua dependencies
sudo luarocks install luacheck
sudo luarocks install lanes

# Set current path
SOURCE="${BASH_SOURCE[0]}"
while [[ -h "$SOURCE" ]]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

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

# Add .profile as default value for .bash_profile
if grep -Fxq "[[ -f ~/.profile ]] && . ~/.profile" ~/.bash_profile
then
    echo "nothing to do"
else
    echo "[[ -f ~/.profile ]] && . ~/.profile" >> ~/.bash_profile
fi

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

# Build gnu global
globalBaseDir="${installBaseDir}/global"
globalCurrentVersionExtractDir="${globalBaseDir}/global-6.5.6"
if [[ ! -d "${globalCurrentVersionExtractDir}" ]]; then
    mkdir "${globalBaseDir}"
    wget -O "${globalBaseDir}/global.tar.gz" http://tamacom.com/global/global-6.5.6.tar.gz
    tar -xpvf  "${globalBaseDir}/global.tar.gz" --directory "${globalBaseDir}"
    cd "${globalCurrentVersionExtractDir}" || exit
    ./configure --with-exuberant-ctags=/usr/bin/ctags
    make
    sudo make install
    make clean
    cp gtags.conf ~/.globalrc

    #Add gtags config string only if not already existing
    if grep -Fxq "export GTAGSLABEL=pygments" ~/.profile
    then
        echo "nothing to do"
    else
        echo "export GTAGSLABEL=pygments" >> ~/.profile
    fi

    if grep -Fxq "set -x GTAGSLABEL pygments" "${fishConfigFile}"
    then
        echo "nothing to do"
    else
        echo "set -x GTAGSLABEL pygments" >> "${fishConfigFile}"
    fi
fi
cd "${DIR}" || exit

# Install java interface server
#javaServerBaseDir="${installBaseDir}/eclim"
#javaServerCurrentVersionExtractDir="${javaServerBaseDir}/2.6.0"
#if [[ ! -d "${javaServerCurrentVersionExtractDir}" ]]; then
#    mkdir "${javaServerBaseDir}"
#    mkdir "${javaServerCurrentVersionExtractDir}"
#    wget -O "${javaServerCurrentVersionExtractDir}/eclim.jar" https://github.com/ervandew/eclim/releases/download/2.6.0/eclim_2.6.0.jar
#    java -Djava.net.useSystemProxies=true -jar "${javaServerCurrentVersionExtractDir}/eclim.jar"
#fi
#cd "${DIR}" || exit

# Prepare Go environment
goPath="${HOME}/goWorkspace"
goPathSrc="${goPath}/src"
goPathBin="${goPath}/bin"
goPathSrcExample="${goPathSrc}/example"
goPathSrcExampleFile="${goPathSrcExample}/example.go"
if grep -Fxq "export GOPATH=${goPath}" ~/.profile
then
    echo "nothing to do"
else
    echo "export GOPATH=${goPath}" >> ~/.profile
fi
if grep -Fq "${goPathBin}" ~/.profile
then
    echo "nothing to do"
else
    echo "export PATH=$PATH:${goPathBin}" >> ~/.profile
fi
if grep -Fxq "set -x GOPATH ${goPath}" "${fishConfigFile}"
then
    echo "nothing to do"
else
    echo "set -x GOPATH ${goPath}" >> "${fishConfigFile}"
fi
if grep -Fq "${goPathBin}" "${fishConfigFile}"
then
    echo "nothing to do"
else
    echo "set -x PATH ${PATH//:/ } ${goPathBin}" >> "${fishConfigFile}"
fi
[[ ! -d "${goPath}" ]] && mkdir "${goPath}"
[[ ! -d "${goPathSrc}" ]] && mkdir "${goPathSrc}"
[[ ! -d "${goPathSrcExample}" ]] && mkdir "${goPathSrcExample}"
[[ ! -f "${goPathSrcExampleFile}" ]] && echo "package main

import \"fmt\"

func main() {
fmt.Printf(\"hello, world\\n\")
}" >> "${goPathSrcExampleFile}"

go get -u -v github.com/nsf/gocode
go get -u -v github.com/rogpeppe/godef
go get -u -v golang.org/x/tools/cmd/guru
go get -u -v golang.org/x/tools/cmd/gorename
go get -u -v golang.org/x/tools/cmd/goimports
go get -u -v github.com/alecthomas/gometalinter
gometalinter --install --update
