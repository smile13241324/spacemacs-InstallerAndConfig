#!/bin/bash

set -e

localInstallDir="${HOME}/.local"
localInstallBin="${localInstallDir}/bin"

# Set current path
SOURCE="${BASH_SOURCE[0]}"
while [[ -h "$SOURCE" ]]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# Set base path
installBaseDir="${HOME}/.spacemacsInstall"
mkdir -p "${installBaseDir}"

# Config your git identity
read -p "Enter Your Name: "  username
git config --global user.name "$username"

read -p "Enter Your Email: "  email
git config --global user.email "$email"

read -p "Enter Your Default Editor: "  editor
git config --global core.editor "$editor"

read -p "Enter Your GPG Signing key (the identifier not the key itself use gpg -k to see it): "  gpgkey
git config --global user.signingkey "$gpgkey"
git config --global commit.gpgsign true
git config --global pull.rebase false

# This is mostly deprecated due to the new haskell lsp
# Install haskell dependencies with stack, do it manually to avoid dynamic linking
# stack install hoogle hlint hindent hasktags happy alex apply-refact stylish-haskell-0.9.4.4

# # Build haskell lsp server
# lspHaskelBaseDir="${installBaseDir}/hie"
# if [[ ! -d "${lspHaskelBaseDir}" ]]; then
#     mkdir "${lspHaskelBaseDir}" -p
#     cd "${lspHaskelBaseDir}"
#     git clone https://github.com/haskell/haskell-ide-engine --recurse-submodules
#     cd haskell-ide-engine
#     stack ./install.hs hie-8.6.5
# fi
