#!/usr/bin/env bash

#Run package installations in system global area when parm is non-nill using
#sudo -H
if [[ $1 ]]; then
    # Install external packages
    pacman -Syyu --noconfirm
    pacman -S base-devel --noconfirm
    pacman -S libgccjit git tcl tk ripgrep the_silver_searcher vim wget curl cmake \
           tree-sitter \
           extra-cmake-modules python autoconf automake gdb gdb-common lldb      \
           adobe-source-code-pro-fonts clang clang-tools-extra boost boost-libs llvm       \
           llvm-libs npm libpng zlib poppler-glib \
           nodejs npm-check-updates luarocks docker docker-compose             \
           docker-machine docker-buildx make ctags fish gradle maven visualvm openjdk-doc          \
           jdk-openjdk gnuplot go go-tools texlive-bin texlive-core texlive-fontsextra    \
           texlive-formatsextra texlive-games texlive-genericextra texlive-htmlxml         \
           texlive-humanities texlive-langchinese texlive-langcyrillic texlive-langextra   \
           texlive-langgreek texlive-langjapanese texlive-langkorean texlive-latexextra    \
           texlive-music texlive-pictures texlive-plainextra texlive-pstricks              \
           texlive-publishers texlive-science texlive-bibtexextra lua coq memcached        \
           ruby opam racket rustfmt rust cargo r gcc-fortran-multilib     \
           ansible ansible-lint puppet vagrant swi-prolog \
           elixir smlnj sbcl pass gradle \
           gradle-doc groovy groovy-docs geckodriver terraform graphviz cowsay \
           gsl lld mlocate firefox openssh sed \
           xorg-xauth pam rlwrap kotlin texlab pandoc pandoc-crossref --noconfirm

    # Fetch kubectl for kubernetes development
    curl -LO https://storage.googleapis.com/kubernetes-release/release/"$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)"/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    mv ./kubectl /usr/local/bin/kubectl

    # Install stack for haskell
    wget -qO- https://get.haskellstack.org/ | sh

    # Take care that locate is up-to-date for later searching
    updatedb

    # Install lua dependencies
    luarocks install luacheck
    luarocks install lanes

    # Install pip directly from python as the OS does it wrongly
    python -m ensurepip --upgrade
    python -m pip install --upgrade pip

    # Build emacs
    emacsBaseDir="${HOME}/emacsBuild"
    if [[ ! -d "${emacsBaseDir}" ]]; then
        git clone git://git.savannah.gnu.org/emacs.git "${emacsBaseDir}"
        cd "${emacsBaseDir}" || exit
        git checkout emacs-29
        ./autogen.sh
        ./configure --with-pgtk --with-json --with-mailutils --with-cairo --with-modules --with-native-compilation --without-compress-install --with-tree-sitter
        make -j8
        sudo make install
        make distclean
        cd ..
        rm "${emacsBaseDir}" -R
    fi
else
    # Set user specific actions which do not require sudo and should be run in
    # the local userspace
    localInstallDir="${HOME}/.local"
    localInstallBin="${localInstallDir}/bin"

    # Install Ruby dependencies
    mkdir "${localInstallBin}" -p
    gem install -n "${localInstallBin}" rdoc pry pry-doc ruby_parser rubocop ruby_test rVM rails \
        specific_install puppet-lint sqlint solargraph rubocop-performance

    # Install python packages
    python -m pip install --force-reinstall pyang jedi json-rpc service_factory ipython autoflake \
           wheel flake8 fabric python-binary-memcached sphinx \
           bashate yapf isort 'python-language-server[all]' pyls-isort \
           pyls-mypy pyls-black mypy importmagic epc autopep8 pycodestyle pydocstyle rope ptvsd pylint black \
           yamllint pyflakes mccabe autopep8 cython==3.0.0a11 cmake-language-server pytest mock setuptools pyls-flake8 \
           pylsp-mypy pyls-isort python-lsp-black pylsp-rope memestra pyls-memestra --user

    # Set current path
    SOURCE="${BASH_SOURCE[0]}"
    while [[ -h "$SOURCE" ]]; do # resolve $SOURCE until the file is no longer a symlink
        DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
        SOURCE="$(readlink "$SOURCE")"
        [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
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

    # Set base path
    installBaseDir="${HOME}/.spacemacsInstall"
    mkdir -p "${installBaseDir}"

    # Add .profile as default value for .bash_profile
    [[ ! -f "${HOME}/.profile" ]] && touch "${HOME}/.profile"
    if grep -Fxq "[[ -f ${HOME}/.profile ]] && . ${HOME}/.profile" "${HOME}"/.bash_profile
    then
        echo "nothing to do"
    else
        echo "[[ -f ${HOME}/.profile ]] && . ${HOME}/.profile" >> "${HOME}"/.bash_profile
    fi

    # Install fish terminal
    fishConfigDir="${HOME}/.config/fish"
    fishConfigFile="${fishConfigDir}/config.fish"
    mkdir -p "${fishConfigDir}"
    TERMINFO="$(locate eterm-color.ti)"
    tic -o "${HOME}"/.terminfo "${TERMINFO}"
    [[ ! -f "${fishConfigFile}" ]] && echo "# emacs ansi-term support
if test -n \"\$EMACS\"
set -x TERM eterm-color
end

# this function may be required
function fish_title
true
end" >> "${fishConfigFile}"

    # Prepare Go environment
    goPath="${HOME}/goWorkspace"
    goPathSrc="${goPath}/src"
    goPathBin="${goPath}/bin"
    goPathSrcExample="${goPathSrc}/example"
    goPathSrcExampleFile="${goPathSrcExample}/example.go"
    export GOPATH=${goPath}
    export PATH=$PATH:${goPathBin}
    if grep -Fxq "export GOPATH=${goPath}" "${HOME}"/.profile
    then
        echo "nothing to do"
    else
        echo "export GOPATH=${goPath}" >> "${HOME}"/.profile
    fi
    if grep -Fq "${goPathBin}" "${HOME}"/.profile
    then
        echo "nothing to do"
    else
        echo "export PATH=$PATH:${goPathBin}" >> "${HOME}"/.profile
    fi
    if grep -Fq "${localInstallBin}" "${HOME}"/.profile
    then
        echo "nothing to do"
    else
        echo "export PATH=$PATH:${localInstallBin}" >> "${HOME}"/.profile
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
    if grep -Fq "${localInstallBin}" "${fishConfigFile}"
    then
        echo "nothing to do"
    else
        echo "set -x PATH ${PATH//:/ } ${localInstallBin}" >> "${fishConfigFile}"
    fi
    [[ ! -d "${goPath}" ]] && mkdir "${goPath}"
    [[ ! -d "${goPathSrc}" ]] && mkdir "${goPathSrc}"
    [[ ! -d "${goPathSrcExample}" ]] && mkdir "${goPathSrcExample}"
    [[ ! -f "${goPathSrcExampleFile}" ]] && echo "package main

import \"fmt\"

func main() {
fmt.Printf(\"hello, world\\n\")
}" >> "${goPathSrcExampleFile}"

    GO111MODULE=on go install golang.org/x/tools/gopls@latest
    GO111MODULE=on CGO_ENABLED=0 go install -v -trimpath -ldflags '-s -w' github.com/golangci/golangci-lint/cmd/golangci-lint@latest
    go install github.com/mdempsky/gocode@latest
    go install github.com/zmb3/gogetdoc@latest
    go install golang.org/x/tools/cmd/godoc@latest
    go install golang.org/x/tools/cmd/goimports@latest
    go install golang.org/x/tools/cmd/gorename@latest
    go install golang.org/x/tools/cmd/guru@latest
    go install github.com/cweill/gotests/...@latest
    go install github.com/davidrjenni/reftools/cmd/fillstruct@latest
    go install github.com/fatih/gomodifytags@latest
    go install github.com/godoctor/godoctor@latest
    go install github.com/haya14busa/gopkgs/cmd/gopkgs@latest
    go install github.com/josharian/impl@latest
    go install github.com/rogpeppe/godef@latest

    # Install plantuml
    plantUmlInstallDir="${HOME}/.plantuml"
    if [[ ! -d "${plantUmlInstallDir}" ]]; then
        mkdir "${plantUmlInstallDir}"
        wget -O "${plantUmlInstallDir}/plantUml.jar" https://downloads.sourceforge.net/project/plantuml/plantuml.jar
    fi

    # Install nodejs dependencies
    npm config set prefix "${localInstallDir}"
    npm install -g tern babel-eslint eslint-plugin-react vmd elm \
        elm-oracle elm-format elm-test tslint typescript-formatter webpack pulp eslint bower   \
        grunt typescript yarn js-yaml prettier typescript-language-server js-beautify \
        import-js parcel bash-language-server yaml-language-server dockerfile-language-server-nodejs \
        flow-bin vscode-json-languageserver vscode-css-languageserver-bin vscode-html-languageserver-bin \
        vim-language-server @elm-tooling/elm-language-server elm-analyse less

    # Install sqlfmt
    wget -q -O - https://github.com/mjibson/sqlfmt/releases/latest/download/sqlfmt_0.4.0_linux_amd64.tar.gz | tar -xpvzf - --directory "${localInstallDir}/bin"
    chmod +x "${localInstallDir}/bin/sqlfmt"

    # Build groovy server - Does not longer build with java 16.
    groovyBaseDir="${installBaseDir}/groovy-lsp"
    groovyInstallDir="${HOME}/.groovy-lsp"
    if [[ ! -d "${groovyBaseDir}" ]]; then
        mkdir -p "${groovyInstallDir}"
        cd "${installBaseDir}" || exit
        git clone https://github.com/aw1cks-forks/groovy-language-server.git groovy-lsp
        cd "groovy-lsp" || exit
        ./gradlew build
        cp ./build/libs/groovy-lsp-all.jar "${groovyInstallDir}/groovy-lsp-all.jar"
        chmod +x "${groovyInstallDir}/groovy-lsp-all.jar"
    fi
    cd "${DIR}" || exit

    # Commit default spacemacs dotfile
    cp .spacemacs "${HOME}"/.spacemacs

    # Install haskell dependencies with stack, do it manually to avoid dynamic
    # linking in arch linux haskell packages
    # Avoid building too much packages as this exceed max build time
    # https://wiki.archlinux.org/index.php/Haskell
    stack setup
    stack upgrade

    # Install haskell dependencies with stack, do it manually to avoid dynamic linking
    stack install pandoc ShellCheck hoogle hlint hasktags happy alex apply-refact
    # stylish-haskell hindent

    # Get latest hadolint release
    wget -O "${localInstallDir}/bin/hadolint" https://github.com/hadolint/hadolint/releases/latest/download/hadolint-Linux-x86_64
    chmod +x "${localInstallDir}/bin/hadolint"
fi
