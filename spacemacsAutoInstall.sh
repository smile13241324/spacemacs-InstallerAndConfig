#!/bin/bash

#Check whether the current repo has changed
hasCurrentRepoChanged(){
    git remote update > /dev/null
    local UPSTREAM
    local LOCAL
    local REMOTE
    UPSTREAM=${1:-'@{u}'}
    LOCAL=$(git rev-parse @)
    REMOTE=$(git rev-parse "$UPSTREAM")
    if [ "${LOCAL}" = "${REMOTE}" ]; then
        echo 0
    else
        echo 1
    fi
}

# Set base path
installBaseDir="${HOME}/.spacemacsInstall"

# Set current path
SOURCE="${BASH_SOURCE[0]}"
while [[ -h "$SOURCE" ]]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# Install general dependencies
sudo apt update
sudo apt dist-upgrade -y
sudo apt install -y libncurses5-dev git silversearcher-ag silversearcher-ag-el curl wget vim build-essential cmake python python-dev python-all python-all-dev libgtk-3-dev libwebkitgtk-3.0-dev libgtk-3-common libgtk-3-0 autoconf automake gdb shellcheck python3-dev cmake-qt-gui cmake-doc git-flow lxd criu lxd-tools

# Build emacs package
emacsBaseDir="${installBaseDir}/emacs"
cloned=0
hasChanged=0
if [[ ! -d "${emacsBaseDir}" ]]; then
    git clone git://git.savannah.gnu.org/emacs.git "${emacsBaseDir}"
    cloned=1
fi
cd "${emacsBaseDir}" || exit
if [[ cloned -eq 0 ]]; then
    hasChanged="$(hasCurrentRepoChanged)";
fi
git checkout origin/emacs-25 --track
git checkout emacs-25
if [[ hasChanged -eq 1 || cloned -eq 1 ]]; then
    git pull
    sudo apt build-dep -y emacs24
    sudo apt purge -y postfix #Remove stupid dependency on mail server.
    sudo apt autoremove -y
    ./autogen.sh
    ./configure --with-xwidgets --with-x-toolkit=gtk3 --with-modules
    make
    sudo make install
    make clean
fi
cd "${DIR}" || exit

# Get adobe fonts
fontsBaseDir="${installBaseDir}/fonts"
fontsCurrentVersionExtractDir="${fontsBaseDir}/source-code-pro-2.030R-ro-1.050R-it"
fontsTargetDir="${HOME}/.fonts"
if [[ ! -d "${fontsCurrentVersionExtractDir}" ]]; then
    mkdir "${fontsBaseDir}"
    mkdir "${fontsTargetDir}"
    wget -O "${fontsBaseDir}/fonts.tar.gz" https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.tar.gz
    tar -zxvf "${fontsBaseDir}/fonts.tar.gz" --directory "${fontsBaseDir}"
    cd "${fontsCurrentVersionExtractDir}/OTF" || exit
    cp ./* "${fontsTargetDir}"
    sudo fc-cache
fi
cd "${DIR}" || exit

# Get newest spacemacs
spacemacsInstallationDir="${HOME}/.emacs.d"
[[ ! -d "${spacemacsInstallationDir}" ]] && git clone https://github.com/syl20bnr/spacemacs "${spacemacsInstallationDir}"
cd "${spacemacsInstallationDir}" || exit
git checkout origin/develop --track
git checkout develop
git pull
cd "${DIR}" || exit
cp spacemacs ~/.spacemacs

# Make spacemacs unity icon
spacemacsUnityDesktopFile="${HOME}/.local/share/applications/spacemacs.desktop"
[[ ! -f "${spacemacsUnityDesktopFile}" ]] && echo "[Desktop Entry]
Name=Spacemacs
GenericName=Text Editor
Comment=Edit text
MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;
Exec=emacs %F
Icon=${HOME}/.emacs.d/core/banners/img/spacemacs.png
Type=Application
Terminal=false
Categories=Development;TextEditor;
StartupWMClass=Emacs" >> "${spacemacsUnityDesktopFile}"

# Install c++ layer dependencies
sudo apt install -y clang clang-format clang-tidy libclang-dev libclang1 libc++1 libc++-dev libc++-helpers libc++abi1 libc++abi-dev libboost-all-dev lldb llvm llvm-dev llvm-runtime

# Install python layer dependencies
sudo apt install -y python-pytest python-pip python-mock python-setuptools-doc
sudo -H pip install pip jedi json-rpc service_factory autoflake hy
sudo -H pip install --upgrade pip jedi json-rpc service_factory autoflake hy

# Install cscope dependencies
sudo apt install -y cscope cscope-el
sudo -H pip install pycscope
sudo -H pip install --upgrade pycscope

# Install java dependencies
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt update
sudo apt install -y oracle-java8-installer ubuntu-make maven
umake ide eclipse

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

# Install node-js dependencies
sudo apt install -y npm nodejs nodejs-dbg nodejs-dev npm2deb node-npmlog nodejs-legacy
sudo npm install -g tern js-beautify eslint

# Install latex dependencies
sudo apt install -y latexmk texlive-full fonts-freefont
sudo npm install -g vmd

# Install lua dependencies
sudo apt install -y luarocks readline-doc
sudo luarocks install luacheck
sudo luarocks install lanes

# Install docker dependencies
sudo apt install -y docker docker.io

# Build gnu global
globalBaseDir="${installBaseDir}/global"
globalCurrentVersionExtractDir="${globalBaseDir}/global-6.5.5"
if [[ ! -d "${globalCurrentVersionExtractDir}" ]]; then
    mkdir "${globalBaseDir}"
    sudo apt install -y exuberant-ctags python-pygments
    wget -O "${globalBaseDir}/global.tar.gz" http://tamacom.com/global/global-6.5.5.tar.gz
    tar -zxvf "${globalBaseDir}/global.tar.gz" --directory "${globalBaseDir}"
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

# Build ycmd server
ycmdBaseDir="${installBaseDir}/ycmd"
ycmdCppDir="${ycmdBaseDir}/cpp"
ycmdClangDir="${ycmdBaseDir}/libClang"
cloned=0
hasChanged=0
if [[ ! -d "${ycmdBaseDir}" ]]; then
    git clone https://github.com/Valloric/ycmd.git "${ycmdBaseDir}"
    cloned=1
fi
cd "${ycmdBaseDir}" || exit
if [[ cloned -eq 0 ]]; then
    hasChanged="$(hasCurrentRepoChanged)";
fi
git checkout origin/auto --track
git checkout auto
if [[ hasChanged -eq 1 || cloned -eq 1 ]]; then
    git pull
    git submodule update --init --recursive
    if [[ ! -d ${ycmdClangDir} ]]; then
        wget -O "${ycmdBaseDir}/libClang.tar.xz" http://llvm.org/releases/3.9.0/clang+llvm-3.9.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz
        tar -zxvf "${ycmdBaseDir}/libClang.tar.xz" --directory "${ycmdClangDir}"
    fi
    cd "${ycmdCppDir}" || exit
    cmake -G "Unix Makefiles" . -DPATH_TO_LLVM_ROOT="${ycmdClangDir}"
    cmake --build . --target ycm_core --config Release
fi
cd "${DIR}" || exit

# Install fish terminal
fishConfigFile="${HOME}/.config/fish/config.fish"
sudo apt install -y fish
TERMINFO="$(find /usr/local -name eterm-color.ti)"
tic -o ~/.terminfo ${TERMINFO}/e/eterm-color.ti
[[ ! -f "${fishConfigFile}" ]] && echo "# emacs ansi-term support
if test -n \"$EMACS\"
  set -x TERM eterm-color
end

# this function may be required
function fish_title
  true
end" >> "${fishConfigFile}"
