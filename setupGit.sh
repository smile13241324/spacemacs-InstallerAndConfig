#!/bin/bash
# Config your git, pass your username, mail, gpg signing key id as well as your prefered editor

# Git config
git config --global user.name "$1"
git config --global user.email "$2"
git config --global user.signingkey "$3"
git config --global commit.gpgsign true
git config --global core.editor "$4"
