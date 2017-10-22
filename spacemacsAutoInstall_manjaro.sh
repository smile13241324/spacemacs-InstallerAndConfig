#!/bin/bash

# Install external packages
sudo pacman -Syyu
sudo pacman -S git tcl tk emacs ripgrep the_silver_searcher vim wget curl cmake \
     extra-cmake-modules python autoconf automake gdb gdb-common lldb shellcheck     \
     adobe-source-code-pro-fonts clang clang-tools-extra boost boost-libs llvm       \
     llvm-libs python-pytest python-pip python-mock python-setuptools cscope npm     \
     nodejs nodejs-less npm-check-updates luarocks docker docker-compose             \
     docker-machine ctags fish fisherman gradle maven visualvm openjdk8-doc          \
     jdk8-openjdk gnuplot go go-tools texlive-bin texlive-core texlive-fontsextra    \
     texlive-formatsextra texlive-games texlive-genericextra texlive-htmlxml         \
     texlive-humanities texlive-langchinese texlive-langcyrillic texlive-langextra   \
     texlive-langgreek texlive-langjapanese texlive-langkorean texlive-latexextra    \
     texlive-music texlive-pictures texlive-plainextra texlive-pstricks              \
     texlive-publishers texlive-science texlive-bibtexextra lua coq memcached        \
     ttf-symbola pandoc ruby opam llvm-ocaml ocaml-compiler-libs ocaml-ctypes        \
     ocaml-findlib ocamlbuild racket rust-racer rustfmt rust cargo r gcc-fortran-multilib     \
     ansible ansible-lint puppet vagrant vagrant-substrate agda           \
     agda-stdlib elixir clojure nim nimble chicken smlnj sbcl pass idris gradle \
     gradle-doc groovy groovy-docs geckodriver
sudo pacman -S cabal-install alex ghc ghc-static happy haskell-abstract-deque                \
     haskell-abstract-par haskell-adjunctions haskell-aeson                            \
     haskell-aeson-better-errors haskell-aeson-compat haskell-aeson-pretty             \
     haskell-annotated-wl-pprint haskell-ansi-terminal haskell-ansi-wl-pprint          \
     haskell-appar haskell-asn1-encoding haskell-asn1-parse haskell-asn1-types         \
     haskell-async haskell-attoparsec haskell-attoparsec-iso8601 haskell-authenticate  \
     haskell-auto-update haskell-aws haskell-base-compat haskell-base-orphans          \
     haskell-base-prelude haskell-base-unicode-symbols haskell-base16-bytestring       \
     haskell-base64-bytestring haskell-bencode haskell-bifunctors                      \
     haskell-binary-conduit haskell-binary-parser haskell-binary-tagged                \
     haskell-bitarray haskell-blaze-builder haskell-blaze-html haskell-blaze-markup    \
     haskell-bloomfilter haskell-bower-json haskell-boxes haskell-brick                \
     haskell-byteable haskell-byteorder haskell-bytestring-show                        \
     haskell-bytestring-strict-builder haskell-bytestring-tree-builder haskell-bzlib   \
     haskell-cairo haskell-call-stack haskell-case-insensitive haskell-cassava         \
     haskell-cereal haskell-charset haskell-cheapskate haskell-chunked-data            \
     haskell-cipher-aes haskell-clientsession haskell-clock haskell-cmark              \
     haskell-cmdargs haskell-code-page haskell-colour haskell-comonad                  \
     haskell-concurrent-output haskell-conduit haskell-conduit-combinators             \
     haskell-conduit-extra haskell-configurator haskell-configurator-ng                \
     haskell-connection haskell-constraints haskell-contravariant                      \
     haskell-contravariant-extras haskell-control-monad-free haskell-cookie            \
     haskell-cpphs haskell-cprng-aes haskell-critbit haskell-criterion                 \
     haskell-crypto-api haskell-crypto-cipher-types haskell-crypto-numbers             \
     haskell-crypto-pubkey haskell-crypto-pubkey-types haskell-crypto-random           \
     haskell-cryptohash haskell-cryptohash-conduit haskell-cryptohash-md5              \
     haskell-cryptohash-sha1 haskell-cryptohash-sha256 haskell-cryptonite              \
     haskell-cryptonite-conduit haskell-css-text haskell-csv haskell-data-accessor     \
     haskell-data-accessor-template haskell-data-accessor-transformers                 \
     haskell-data-bword haskell-data-checked haskell-data-clist haskell-data-default   \
     haskell-data-default-class haskell-data-default-instances-base                    \
     haskell-data-default-instances-containers                                         \
     haskell-data-default-instances-dlist haskell-data-default-instances-old-locale    \
     haskell-data-dword haskell-data-endian haskell-data-hash haskell-data-ordlist     \
     haskell-data-serializer haskell-data-textual haskell-dataenc haskell-dav          \
     haskell-dbus haskell-decimal haskell-deepseq-generics haskell-descriptive         \
     haskell-digest haskell-disk-free-space haskell-distributive haskell-djinn-ghc     \
     haskell-djinn-lib haskell-dlist haskell-dns haskell-docopt haskell-doctemplates   \
     haskell-easy-file haskell-ed25519 haskell-edisonapi haskell-edisoncore            \
     haskell-edit-distance haskell-either haskell-email-validate                       \
     haskell-enclosed-exceptions haskell-entropy haskell-equivalence haskell-erf       \
     haskell-errors haskell-esqueleto haskell-exceptions haskell-expiring-cache-map    \
     haskell-extensible-exceptions haskell-extra haskell-fast-logger haskell-fclabels  \
     haskell-fdo-notify haskell-feed haskell-fgl haskell-file-embed haskell-filelock   \
     haskell-filemanip haskell-fingertree haskell-fmlist haskell-foldl                 \
     haskell-foundation haskell-free haskell-fsnotify haskell-generic-deriving         \
     haskell-generic-trie haskell-generics-sop haskell-geniplate-mirror                \
     haskell-ghc-paths haskell-ghc-syb-utils haskell-gitrev haskell-glib haskell-glob  \
     haskell-gnuidn haskell-gnutls haskell-graphscc haskell-graphviz haskell-gsasl     \
     haskell-gtk haskell-gtk2hs-buildtools haskell-hackage-security                    \
     haskell-haddock-library haskell-hakyll haskell-hashable       \
     haskell-hashtables haskell-hasql haskell-hasql-pool haskell-hasql-transaction     \
     haskell-hastache haskell-here haskell-heredoc haskell-hex haskell-hinotify        \
     haskell-hit haskell-hjsmin haskell-hledger-lib haskell-hopenpgp haskell-hostname  \
     haskell-hourglass haskell-hpack haskell-hs-bibutils haskell-hscolour              \
     haskell-hslogger haskell-hslua haskell-hspec haskell-hspec-core                   \
     haskell-hspec-discover haskell-hspec-expectations haskell-hspec-smallcheck        \
     haskell-html haskell-http haskell-http-api-data haskell-http-client               \
     haskell-http-client-tls haskell-http-conduit haskell-http-date                    \
     haskell-http-media haskell-http-types haskell-http2 haskell-hunit haskell-hxt     \
     haskell-hxt-charproperties haskell-hxt-regex-xmlschema haskell-hxt-unicode        \
     haskell-ieee754 haskell-ifelse haskell-incremental-parser                         \
     haskell-insert-ordered-containers                                                 \
     haskell-integer-logarithms haskell-interpolatedstring-perl6 haskell-iproute       \
     haskell-ixset-typed haskell-js-flot haskell-js-jquery haskell-json                \
     haskell-juicypixels haskell-jwt haskell-kan-extensions haskell-keys               \
     haskell-language-c haskell-language-javascript haskell-language-python            \
     haskell-lens haskell-lens-aeson haskell-lexer haskell-libffi haskell-libxml-sax   \
     haskell-lifted-async haskell-lifted-base haskell-listlike haskell-loch-th         \
     haskell-logict haskell-lrucache haskell-magic haskell-managed                     \
     haskell-math-functions haskell-megaparsec haskell-memory haskell-microlens        \
     haskell-microlens-aeson haskell-microlens-ghc haskell-microlens-mtl               \
     haskell-microlens-platform haskell-microlens-th haskell-microstache               \
     haskell-mime-mail haskell-mime-types haskell-missingh haskell-mmap                \
     haskell-mmorph haskell-monad-control haskell-monad-journal haskell-monad-logger   \
     haskell-monad-loops haskell-monad-par haskell-monad-par-extras                    \
     haskell-monad-unlift haskell-monadplus haskell-monadrandom haskell-monads-tf      \
     haskell-mono-traversable haskell-monoid-subclasses haskell-mountpoints            \
     haskell-mtl haskell-murmur-hash haskell-mwc-random                                \
     haskell-natural-transformation haskell-nettle haskell-network                     \
     haskell-network-info haskell-network-ip haskell-network-multicast                 \
     haskell-network-protocol-xmpp haskell-network-uri haskell-newtype haskell-nonce   \
     haskell-old-locale haskell-old-time haskell-only haskell-open-browser             \
     haskell-openpgp-asciiarmor haskell-optional-args haskell-optparse-applicative     \
     haskell-optparse-simple haskell-pandoc-types haskell-pango haskell-parallel       \
     haskell-parsec haskell-parsers haskell-path haskell-path-io haskell-path-pieces   \
     haskell-patience haskell-pattern-arrows haskell-pcre-light haskell-pem            \
     haskell-persistent haskell-persistent-sqlite haskell-persistent-template          \
     haskell-pid1 haskell-pipes haskell-pipes-http haskell-placeholders                \
     haskell-pointed haskell-polyparse haskell-postgresql-binary                       \
     haskell-postgresql-libpq haskell-prelude-extras haskell-pretty-show               \
     haskell-primes haskell-primitive haskell-process-extras haskell-profunctors       \
     haskell-project-template haskell-protolude haskell-psqueues haskell-puremd5       \
     haskell-quickcheck haskell-quickcheck-io haskell-random haskell-ranged-sets       \
     haskell-reducers haskell-refact haskell-reflection haskell-regex-applicative      \
     haskell-regex-applicative-text haskell-regex-base haskell-regex-compat            \
     haskell-regex-compat-tdfa haskell-regex-pcre haskell-regex-posix                  \
     haskell-regex-tdfa haskell-resource-pool haskell-resourcet haskell-retry          \
     haskell-rfc5051 haskell-roman-numerals haskell-safe haskell-safe-exceptions       \
     haskell-safecopy haskell-safesemaphore haskell-sandi haskell-scientific           \
     haskell-securemem haskell-semigroupoids haskell-semigroups haskell-servant        \
     haskell-servant-server haskell-servant-swagger haskell-setenv haskell-setlocale   \
     haskell-sha haskell-shake haskell-shakespeare haskell-silently                    \
     haskell-simple-sendfile haskell-skein haskell-skylighting haskell-smallcheck      \
     haskell-socks haskell-sourcemap haskell-spdx haskell-split haskell-src-exts       \
     haskell-src-meta haskell-statevar haskell-statistics haskell-stm                  \
     haskell-stm-chans haskell-stmonadtrans haskell-store haskell-store-core           \
     haskell-streaming-commons haskell-strict haskell-string-conversions               \
     haskell-stringsearch haskell-success haskell-swagger2 haskell-syb                 \
     haskell-system-fileio haskell-system-filepath haskell-tabular haskell-tagged      \
     haskell-tagsoup haskell-tagstream-conduit haskell-tar haskell-tasty               \
     haskell-tasty-hunit haskell-tasty-quickcheck haskell-tasty-rerun                  \
     haskell-temporary haskell-terminal-size haskell-test-framework                    \
     haskell-test-framework-hunit haskell-texmath haskell-text haskell-text-binary     \
     haskell-text-icu haskell-text-latin1 haskell-text-metrics haskell-text-printer    \
     haskell-text-short haskell-text-zipper haskell-tf-random haskell-th-abstraction   \
     haskell-th-expand-syns haskell-th-lift haskell-th-lift-instances                  \
     haskell-th-orphans haskell-th-reify-many haskell-th-utilities                     \
     haskell-time-locale-compat haskell-tls haskell-tls-session-manager                \
     haskell-torrent haskell-transformers-base haskell-transformers-compat             \
     haskell-trifecta haskell-tuple-th haskell-turtle haskell-type-hint                \
     haskell-uglymemo haskell-unbounded-delays haskell-unexceptionalio                 \
     haskell-unicode-show haskell-unicode-transforms haskell-uniplate                  \
     haskell-unix-compat haskell-unix-time haskell-unixutils                           \
     haskell-unordered-containers haskell-uri-bytestring haskell-utf8-string           \
     haskell-utility-ht haskell-uuid haskell-uuid-types haskell-vault haskell-vector   \
     haskell-vector-algorithms haskell-vector-binary-instances haskell-vector-builder  \
     haskell-vector-instances haskell-vector-th-unbox haskell-void haskell-vty         \
     haskell-wai haskell-wai-app-static haskell-wai-cors haskell-wai-extra             \
     haskell-wai-handler-launch haskell-wai-logger haskell-wai-websockets              \
     haskell-warp haskell-warp-tls haskell-websockets haskell-wizards                  \
     haskell-wl-pprint-extras haskell-wl-pprint-terminfo haskell-wl-pprint-text        \
     haskell-word8 haskell-x11 haskell-x11-xft haskell-x509 haskell-x509-store         \
     haskell-x509-system haskell-x509-validation haskell-xcb-types haskell-xcffib      \
     haskell-xml haskell-xml-conduit haskell-xml-hamlet haskell-xml-types              \
     haskell-xss-sanitize haskell-yaml haskell-yesod haskell-yesod-auth                \
     haskell-yesod-core haskell-yesod-default haskell-yesod-form                       \
     haskell-yesod-persistent haskell-yesod-static haskell-zip-archive haskell-zlib    \
     haskell-zlib-bindings hasktags hindent hoogle stylish-haskell

# Install haskell dependencies with cabal
sudo cabal update
sudo cabal install ghc-mod haddock

# Install python packages
sudo -H pip install pip jedi json-rpc service_factory autoflake hy pycscope \
     flake8 robot Django fabric python-binary-memcached Pygments sphinx \
     pycscope bashate yapf isort
sudo -H pip install --upgrade pip jedi json-rpc service_factory autoflake hy  \
     pycscope flake8 robot Django fabric python-binary-memcached Pygments sphinx   \
     pycscope bashate yapf isort
sudo -H pip install --pre --upgrade robotframework-seleniumlibrary

# Install nodejs dependencies
sudo npm config set unsafe-perm true
sudo npm install -g npm tern js-beautify babel-eslint eslint-plugin-react vmd elm \
     elm-oracle elm-format tslint typescript-formatter webpack pulp eslint bower   \
     grunt typescript yarn js-yaml purescript

# Install lua dependencies
sudo luarocks install luacheck
sudo luarocks install lanes

# Install Ruby dependencies
sudo gem install pry pry-doc ruby_parser rubocop ruby_test rVM rails  \
     specific_install
sudo gem specific_install https://github.com/brigade/scss-lint.git
sudo gem specific_install                                       \
     https://github.com/Sweetchuck/scss_lint_reporter_checkstyle.git

# Install Ocam dependencies
sudo opam init
sudo opam config setup -a
sudo opam install merlin utop ocp-indent

# Install nim dependecies
sudo nimble install nimsuggest

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
globalCurrentVersionExtractDir="${globalBaseDir}/global-6.5.7"
if [[ ! -d "${globalCurrentVersionExtractDir}" ]]; then
    mkdir "${globalBaseDir}"
    wget -O "${globalBaseDir}/global.tar.gz" http://tamacom.com/global/global-6.5.7.tar.gz
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
go get -u -v github.com/godoctor/godoctor
go install github.com/godoctor/godoctor

# Install plantuml
plantUmlInstallDir="${HOME}/.plantuml"
if [[ ! -d "${plantUmlInstallDir}" ]]; then
    mkdir "${plantUmlInstallDir}"
    wget -O "${plantUmlInstallDir}/plantUml.jar" https://10gbps-io.dl.sourceforge.net/project/plantuml/plantuml.jar
fi

# Install Rust environment
rustBasePath="$(rustc --print sysroot)/lib/rustlib/src"
rustSourcePath="${rustBasePath}"/rust/src
sudo mkdir "${rustBasePath}" -p
sudo chown "${USER}":"${USER}" "${rustBasePath}" -R
[[ ! -d "${rustSourcePath}" ]] && git clone https://github.com/rust-lang/rust.git "${rustBasePath}"/rust
cd "${rustSourcePath}" || exit
git pull
cd "${DIR}" || exit
if grep -Fxq "export RUST_SRC_PATH=${rustSourcePath}" ~/.profile
then
    echo "nothing to do"
else
    echo "export RUST_SRC_PATH=${rustSourcePath}" >> ~/.profile
fi
if grep -Fxq "set -x RUST_SRC_PATH ${rustSourcePath}" "${fishConfigFile}"
then
    echo "nothing to do"
else
    echo "set -x RUST_SRC_PATH ${rustSourcePath}" >> "${fishConfigFile}"
fi

# Setup chicken properly
sudo chicken-install -s apropos chicken-doc
cd `csi -p '(chicken-home)'`
sudo curl https://3e8.org/pub/chicken-doc/chicken-doc-repo.tgz | sudo tar zx
cd "${DIR}" || exit
