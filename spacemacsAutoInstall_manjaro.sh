#!/usr/bin/env bash
set -e

#Run package installations in system global area when parm is non-nill using
#sudo -H
if [[ $1 ]]; then
    # Install external packages
    pacman -Syyu --noconfirm
    pacman -S base-devel --noconfirm
    pacman -S libgccjit git tcl tk ripgrep the_silver_searcher vim wget curl cmake \
           virt-manager qemu-full vde2 ebtables dnsmasq bridge-utils openbsd-netcat \
           tree-sitter clojure android-tools android-udev \
           extra-cmake-modules python autoconf automake gdb gdb-common lldb      \
           adobe-source-code-pro-fonts clang clang-tools-extra boost boost-libs llvm       \
           llvm-libs npm libpng zlib poppler-glib \
           libva-utils libva-mesa-driver \
           nodejs npm-check-updates luarocks docker docker-compose             \
           docker-machine docker-buildx make ctags fish gradle maven openjdk-doc          \
           jdk-openjdk gnuplot go go-tools texlive-bin texlive-core texlive-fontsextra    \
           texlive-formatsextra texlive-games  \
           texlive-humanities texlive-langchinese texlive-langcyrillic texlive-langextra   \
           texlive-langgreek texlive-langjapanese texlive-langkorean texlive-latexextra    \
           texlive-music texlive-pictures texlive-pstricks              \
           emacs-wayland \
           texlive-publishers texlive-science texlive-bibtexextra lua coq memcached        \
           ruby opam racket rustfmt rust cargo r gcc-fortran-multilib     \
           puppet vagrant swi-prolog \
           elixir smlnj sbcl pass gradle \
           gradle-doc groovy groovy-docs geckodriver terraform graphviz cowsay \
           gsl lld mlocate firefox openssh sed \
           xorg-xauth pam rlwrap kotlin texlab pandoc pandoc-crossref --noconfirm

    # Fetch kubectl for kubernetes development
    curl -LO https://storage.googleapis.com/kubernetes-release/release/"$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)"/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    mv ./kubectl /usr/local/bin/kubectl

    # Install helm
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod +x get_helm.sh
    ./get_helm.sh

    # Take care that locate is up-to-date for later searching
    updatedb

    # Install lua dependencies
    luarocks install luacheck
    luarocks install lanes

    # Install pip directly from python as the OS does it wrongly
    rm /usr/lib/python3.12/EXTERNALLY-MANAGED -f
    python -m ensurepip --upgrade
    python -m pip install --upgrade pip

    # Manually create a standard pip link
    ln /usr/bin/pip3 pip --symbolic
    mv ./pip /usr/bin/
else
    # Set user specific actions which do not require sudo and should be run in
    # the local userspace
    localInstallDir="${HOME}/.local"
    localInstallBin="${localInstallDir}/bin"

    # Install Ruby dependencies
    mkdir "${localInstallBin}" -p
    gem install -n "${localInstallBin}" pry
    set +e
    gem install -n "${localInstallBin}" pry-doc
    set -e
    gem install -n "${localInstallBin}" pry-doc
    gem install -n "${localInstallBin}" rdoc ruby_parser rubocop ruby_test rVM rails \
        specific_install puppet-lint sqlint solargraph rubocop-performance

    # Install python packages
    python -m pip install --force-reinstall pyang jedi json-rpc service_factory ipython autoflake \
           ansible wheel flake8 fabric python-binary-memcached sphinx \
           bashate yapf isort 'python-lsp-server[all]' \
           pylsp-mypy mypy isort Black rope ruff python-lsp-black \
           python-lsp-isort pyls-memestra python-lsp-ruff pylsp-rope memestra --user

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
    git checkout develop
    git pull
    cd "${DIR}" || exit

    # Set base path
    installBaseDir="${HOME}/.spacemacsInstall"
    mkdir -p "${installBaseDir}"

    # Add .profile as default value for .bash_profile
    echo "Setting profile settings"
    [[ ! -f "${HOME}/.profile" ]] && touch "${HOME}/.profile"
    if grep -Fxq "[[ -f ${HOME}/.profile ]] && . ${HOME}/.profile" "${HOME}"/.bash_profile
    then
        echo "nothing to do"
    else
        echo "[[ -f ${HOME}/.profile ]] && . ${HOME}/.profile" >> "${HOME}"/.bash_profile
    fi

    # Install fish terminal
    echo "Setting fish settings"
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
    echo "prepare go env"
    goPath="${HOME}/goWorkspace"
    goPathSrc="${goPath}/src"
    goPathBin="${goPath}/bin"
    goPathSrcExample="${goPathSrc}/example"
    goPathSrcExampleFile="${goPathSrcExample}/example.go"
    haskellPath="${HOME}/.ghcup/bin"
    cabalPath="${HOME}/.cabal/bin"
    JAVA_HOME="/usr/lib/jvm/default-runtime"
    export GOPATH=${goPath}
    export PATH=$PATH:${goPathBin}:${localInstallBin}:${haskellPath}:${cabalPath}
    export JAVA_HOME

    # Prepare .profile with paths
    if grep -Fxq "export JAVA_HOME=${JAVA_HOME}" "${HOME}"/.profile
    then
        echo "nothing to do"
    else
        echo "export JAVA_HOME=${JAVA_HOME}" >> "${HOME}"/.profile
    fi
    if grep -Fxq "export GOPATH=${goPath}" "${HOME}"/.profile
    then
        echo "nothing to do"
    else
        echo "export GOPATH=${goPath}" >> "${HOME}"/.profile
    fi
    if grep -Fxq "export PATH=${PATH}" "${HOME}"/.profile
    then
        echo "nothing to do"
    else
        echo "export PATH=${PATH}" >> "${HOME}"/.profile
    fi

    # Prepare fish config with paths
    if grep -Fxq "set -x JAVA_HOME ${JAVA_HOME}" "${fishConfigFile}"
    then
        echo "nothing to do"
    else
        echo "set -x JAVA_HOME ${JAVA_HOME}" >> "${fishConfigFile}"
    fi
    if grep -Fxq "set -x GOPATH ${goPath}" "${fishConfigFile}"
    then
        echo "nothing to do"
    else
        echo "set -x GOPATH ${goPath}" >> "${fishConfigFile}"
    fi
    if grep -Fxq "set -x PATH ${PATH//:/ }" "${fishConfigFile}"
    then
        echo "nothing to do"
    else
        echo "set -x PATH ${PATH//:/ }" >> "${fishConfigFile}"
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
    echo "prepare plantuml"
    plantUmlInstallDir="${HOME}/.plantuml"
    if [[ ! -d "${plantUmlInstallDir}" ]]; then
        mkdir "${plantUmlInstallDir}"
        wget -O "${plantUmlInstallDir}/plantUml.jar" https://downloads.sourceforge.net/project/plantuml/plantuml.jar
    fi

    # Install nodejs dependencies
    echo "prepare npm"
    npm config set prefix "${localInstallDir}"
    npm install -g tern babel-eslint eslint-plugin-react vmd elm volar \
        elm-oracle elm-format elm-test typescript-formatter webpack pulp eslint bower   \
        grunt typescript yarn js-yaml prettier typescript-language-server js-beautify \
        import-js parcel bash-language-server yaml-language-server dockerfile-language-server-nodejs \
        flow-bin vscode-json-languageserver vscode-css-languageserver-bin vscode-html-languageserver-bin \
        vim-language-server @elm-tooling/elm-language-server elm-analyse less typescript

    # Install sqlfmt
    echo "prepare sqlfmt"
    wget -q -O - https://github.com/maddyblue/sqlfmt/releases/download/v0.5.0/sqlfmt_Linux_x86_64.tar.gz | tar -xpvzf - --directory "${localInstallDir}/bin"
    chmod +x "${localInstallDir}/bin/sqlfmt"

    # Build groovy lsp is not compatible with java 20
    echo "prepare groovy lsp"
    groovyBaseDir="${installBaseDir}/groovy-lsp"
    groovyInstallDir="${HOME}/.groovy-lsp"
    if [[ ! -d "${groovyBaseDir}" ]]; then
        mkdir -p "${groovyInstallDir}"
        cd "${installBaseDir}" || exit
        git clone https://github.com/GroovyLanguageServer/groovy-language-server groovy-lsp
        cd "groovy-lsp" || exit
        ./gradlew build
        cp ./build/libs/groovy-lsp-all.jar "${groovyInstallDir}/groovy-lsp-all.jar"
        chmod +x "${groovyInstallDir}/groovy-lsp-all.jar"
    fi
    cd "${DIR}" || exit

    # Install leiningen and boot for clojure builds as well as lsp
    echo "prepare leiningen"
    wget -O "${localInstallDir}/bin/lein" https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
    chmod +x "${localInstallDir}/bin/lein"
    "${localInstallDir}/bin/lein" version

    echo "prepare boot"
    wget -O "${localInstallDir}/bin/boot" https://github.com/boot-clj/boot-bin/releases/download/latest/boot.sh
    chmod +x "${localInstallDir}/bin/boot"
    "${localInstallDir}/bin/boot" -u

    echo "clojure lsp"
    wget -O "${localInstallDir}/bin/clojure-lsp" https://github.com/clojure-lsp/clojure-lsp/releases/latest/download/clojure-lsp
    chmod +x "${localInstallDir}/bin/clojure-lsp"

    # Install additional linters for clojure
    echo "clojure jocker"
    cd "${localInstallDir}" || exit
    wget -O "${localInstallDir}/joker-linux-amd64.zip" https://github.com/candid82/joker/releases/latest/download/joker-linux-amd64.zip
    unzip "${localInstallDir}/joker-linux-amd64.zip"
    mv "${localInstallDir}/joker" "${localInstallDir}/bin/joker"
    chmod +x "${localInstallDir}/bin/joker"
    rm "${localInstallDir}/joker-linux-amd64.zip"
    cd "${DIR}" || exit

    # Commit default spacemacs dotfile
    echo "copy dotfile"
    cp .spacemacs "${HOME}"/.spacemacs

    # Install Haskell package manager
    echo "install haskell tools"
    export BOOTSTRAP_HASKELL_NONINTERACTIVE="True"
    export BOOTSTRAP_HASKELL_INSTALL_HLS="True"
    curl --proto '=https' --tlsv1.3 -sSf https://get-ghcup.haskell.org | sh

    # Install haskell dependencies with stack, do it manually to avoid dynamic linking
    echo "install stack additional packages"
    stack install pandoc ShellCheck hoogle hlint hasktags happy alex apply-refact

    # Get latest hadolint release
    echo "install hadolint"
    wget -O "${localInstallDir}/bin/hadolint" https://github.com/hadolint/hadolint/releases/latest/download/hadolint-Linux-x86_64
    chmod +x "${localInstallDir}/bin/hadolint"

    # Obtain android studio
    wget https://r4---sn-h0jelnes.gvt1.com/edgedl/android/studio/ide-zips/2024.3.1.14/android-studio-2024.3.1.14-linux.tar.gz
    tar -xf android-studio-2024.3.1.14-linux.tar.gz -C "${HOME}/Documents/"
fi
