#!/usr/bin/env bash

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

# Commit default spacemacs dotfile
cp .spacemacs ${HOME}/.spacemacs

# Install haskell dependencies with stack, do it manually to avoid dynamic
# linking in arch linux haskell packages
# Avoid building too much packages as this exceed max build time
# https://wiki.archlinux.org/index.php/Haskell
stack setup
stack upgrade

# Set global resolver to latest lts version supported by stack
mkdir -p /home/spacemacs/.stack/global-project
echo "# This is the implicit global project's config file, which is only used when
# 'stack' is run outside of a real project.  Settings here do _not_ act as
# defaults for all projects.  To change stack's default settings, edit
# '/home/spacemacs/.stack/config.yaml' instead.
#
# For more information about stack's configuration, see
# http://docs.haskellstack.org/en/stable/yaml_configuration/
#
packages: []
resolver: lts-14.27" >> /home/spacemacs/.stack/global-project/stack.yaml

stack install pandoc
stack install ShellCheck

# Get latest hadolint release
wget -O "${localInstallDir}/bin/hadolint" https://github.com/hadolint/hadolint/releases/latest/download/hadolint-Linux-x86_64
chmod +x "${localInstallDir}/bin/hadolint"
