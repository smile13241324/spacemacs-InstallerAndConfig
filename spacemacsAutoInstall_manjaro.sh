#!/bin/bash

#Run package installations in system global area when parm is non-nill using
#sudo -H
if [[ $1 ]]; then
    # Install external packages
    pacman -Syyu --noconfirm
    pacman -S base-devel --noconfirm
    pacman -S git tcl tk emacs ripgrep the_silver_searcher vim wget curl cmake \
           extra-cmake-modules python autoconf automake gdb gdb-common lldb      \
           adobe-source-code-pro-fonts clang clang-tools-extra boost boost-libs llvm       \
           llvm-libs python-pytest python-pip python-mock python-setuptools cscope npm     \
           nodejs nodejs-less npm-check-updates luarocks docker docker-compose             \
           docker-machine ctags fish fisherman gradle maven visualvm openjdk-doc          \
           jdk-openjdk gnuplot go go-tools texlive-bin texlive-core texlive-fontsextra    \
           texlive-formatsextra texlive-games texlive-genericextra texlive-htmlxml         \
           texlive-humanities texlive-langchinese texlive-langcyrillic texlive-langextra   \
           texlive-langgreek texlive-langjapanese texlive-langkorean texlive-latexextra    \
           texlive-music texlive-pictures texlive-plainextra texlive-pstricks              \
           texlive-publishers texlive-science texlive-bibtexextra lua coq memcached        \
           ruby opam llvm-ocaml ocaml-compiler-libs ocaml-ctypes        \
           ocaml-findlib ocamlbuild racket rust-racer rustfmt rust cargo r gcc-fortran-multilib     \
           ansible ansible-lint puppet vagrant swi-prolog \
           elixir clojure nim nimble smlnj sbcl pass gradle \
           gradle-doc groovy groovy-docs geckodriver terraform zeal graphviz cowsay \
           gsl lld mlocate firefox openssh sed xorg-xauth pam rlwrap --noconfirm

    # Install lua dependencies
    luarocks install luacheck
    luarocks install lanes

    # Fetch kubectl for kubernetes development
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    mv ./kubectl /usr/local/bin/kubectl

    # Install stack for haskell
    wget -qO- https://get.haskellstack.org/ | sh

    # Take care that locate is up-to-date for later searching
    updatedb
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
    pip install --force-reinstall pyang jedi json-rpc service_factory ipython autoflake hy \
        flake8 fabric python-binary-memcached Pygments sphinx \
        pycscope bashate yapf isort python-language-server[all] pyls-isort \
        pyls-mypy pyls-black mypy importmagic epc autopep8 pydocstyle rope ptvsd pylint black \
        yamllint --user

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
    cp .spacemacs ${HOME}/.spacemacs

    # Set base path
    installBaseDir="${HOME}/.spacemacsInstall"
    mkdir -p "${installBaseDir}"

    # Add .profile as default value for .bash_profile
    [[ ! -f "${HOME}/.profile" ]] && touch "${HOME}/.profile"
    if grep -Fxq "[[ -f ${HOME}/.profile ]] && . ${HOME}/.profile" ${HOME}/.bash_profile
    then
        echo "nothing to do"
    else
        echo "[[ -f ${HOME}/.profile ]] && . ${HOME}/.profile" >> ${HOME}/.bash_profile
    fi

    # Install fish terminal
    fishConfigDir="${HOME}/.config/fish"
    fishConfigFile="${fishConfigDir}/config.fish"
    mkdir -p "${fishConfigDir}"
    TERMINFO="$(locate eterm-color.ti)"
    tic -o ${HOME}/.terminfo ${TERMINFO}
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
    globalCurrentVersionExtractDir="${globalBaseDir}/global-6.6.3"
    if [[ ! -d "${globalCurrentVersionExtractDir}" ]]; then
        mkdir "${globalBaseDir}"
        wget -O "${globalBaseDir}/global.tar.gz" http://tamacom.com/global/global-6.6.3.tar.gz
        tar -xpvf  "${globalBaseDir}/global.tar.gz" --directory "${globalBaseDir}"
        cd "${globalCurrentVersionExtractDir}" || exit
        ./configure --with-exuberant-ctags=/usr/bin/ctags
        make
        sudo make install
        make clean
        cp gtags.conf ${HOME}/.globalrc

        #Add gtags config string only if not already existing
        if grep -Fxq "export GTAGSLABEL=pygments" ${HOME}/.profile
        then
            echo "nothing to do"
        else
            echo "export GTAGSLABEL=pygments" >> ${HOME}/.profile
        fi

        if grep -Fxq "set -x GTAGSLABEL pygments" "${fishConfigFile}"
        then
            echo "nothing to do"
        else
            echo "set -x GTAGSLABEL pygments" >> "${fishConfigFile}"
        fi
    fi
    cd "${DIR}" || exit

    # Prepare Go environment
    goPath="${HOME}/goWorkspace"
    goPathSrc="${goPath}/src"
    goPathBin="${goPath}/bin"
    goPathSrcExample="${goPathSrc}/example"
    goPathSrcExampleFile="${goPathSrcExample}/example.go"
    export GOPATH=${goPath}
    export PATH=$PATH:${goPathBin}
    if grep -Fxq "export GOPATH=${goPath}" ${HOME}/.profile
    then
        echo "nothing to do"
    else
        echo "export GOPATH=${goPath}" >> ${HOME}/.profile
    fi
    if grep -Fq "${goPathBin}" ${HOME}/.profile
    then
        echo "nothing to do"
    else
        echo "export PATH=$PATH:${goPathBin}" >> ${HOME}/.profile
    fi
    if grep -Fq "${localInstallBin}" ${HOME}/.profile
    then
        echo "nothing to do"
    else
        echo "export PATH=$PATH:${localInstallBin}" >> ${HOME}/.profile
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

    GO111MODULE=on go get -v golang.org/x/tools/gopls@latest
    go get -u -v golang.org/x/tools/cmd/godoc
    go get -u -v golang.org/x/tools/cmd/goimports
    go get -u -v golang.org/x/tools/cmd/gorename
    go get -u -v golang.org/x/tools/cmd/guru
    go get -u -v github.com/cweill/gotests/...
    go get -u -v github.com/davidrjenni/reftools/cmd/fillstruct
    go get -u -v github.com/fatih/gomodifytags
    go get -u -v github.com/godoctor/godoctor
    go get -u -v github.com/golangci/golangci-lint/cmd/golangci-lint
    go get -u -v github.com/haya14busa/gopkgs/cmd/gopkgs
    go get -u -v github.com/josharian/impl
    go get -u -v github.com/mdempsky/gocode
    go get -u -v github.com/rogpeppe/godef
    go get -u -v github.com/zmb3/gogetdoc

    # Install plantuml
    plantUmlInstallDir="${HOME}/.plantuml"
    if [[ ! -d "${plantUmlInstallDir}" ]]; then
        mkdir "${plantUmlInstallDir}"
        wget -O "${plantUmlInstallDir}/plantUml.jar" https://downloads.sourceforge.net/project/plantuml/plantuml.jar
    fi

    # Install nodejs dependencies
    npm config set prefix "${localInstallDir}"
    npm install -g tern babel-eslint eslint-plugin-react vmd elm \
        elm-oracle elm-format tslint typescript-formatter webpack pulp eslint bower   \
        grunt typescript yarn js-yaml prettier typescript-language-server js-beautify \
        import-js parcel bash-language-server yaml-language-server dockerfile-language-server-nodejs \
        flow-bin

    # Install leiningen and boot for clojure builds
    wget -O "${localInstallDir}/bin/lein" https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
    chmod +x "${localInstallDir}/bin/lein"
    "${localInstallDir}/bin/lein" version
    wget -O "${localInstallDir}/bin/boot" https://github.com/boot-clj/boot-bin/releases/download/latest/boot.sh
    chmod +x "${localInstallDir}/bin/boot"
    "${localInstallDir}/bin/boot" -u

    # Install additional linters for clojure
    go get -d github.com/candid82/joker
    cd ${GOPATH}/src/github.com/candid82/joker
    ./run.sh --version && go install

    # Install haskell dependencies with stack, do it manually to avoid dynamic
    # linking in arch linux haskell packages
    # Avoid building too much packages as this exceed max build time
    # https://wiki.archlinux.org/index.php/Haskell
    stack setup
    stack upgrade
    stack install pandoc
    stack install ShellCheck
    stack install hadolint
    # stack install hoogle
    # stack install hlint
    # stack install hindent
    # stack install hasktags
    # stack install happy
    # stack install alex
    # stack install apply-refact
    # stack install stylish-haskell

    # # Install haskell lsp from source
    # lspHaskelBaseDir="${installBaseDir}/hie"
    # if [[ ! -d "${lspHaskelBaseDir}" ]]; then
    #     mkdir "${lspHaskelBaseDir}"
    #     cd "${lspHaskelBaseDir}"
    #     git clone https://github.com/haskell/haskell-ide-engine --recurse-submodules
    #     cd haskell-ide-engine
    #     stack ./install.hs hie-8.6.5
    #     stack ./install.hs build-doc-8.6.5
    # fi
    # cd "${DIR}" || exit
fi
