<a href="http://spacemacs.org"><img src="https://cdn.rawgit.com/syl20bnr/spacemacs/442d025779da2f62fc86c2082703697714db6514/assets/spacemacs-badge.svg" alt="Made with Spacemacs"></a><br>
# spacemacs-InstallerAndConfig

This project contains an easy to use installer for the first class development environment Spacemacs.
In contrast to most of the other Spacemacs installer solutions this one is based on Manjaro Linux an Arch based distribution.
This results in much more up-to-date system packages due to Arch's great Pacman package network.

Many of these packages are required to run Spacemacs properly like the adobe fonts, which must be manually build
on most debian based systems.

The above mentioned installer script can setup your programming environment in no time.
Currently the external dependencies for most of the more popular layers are installed including:
* go
* python
* kubernetes
* clojure
* docker
* C++ with Clang
* common-lisp
* bash-script
* org, with presetuped GTD environment
* ansi-term configured to use fish
* and many more

In addition to the installer script you can also find:
* GTD templates for all mentioned file types from "Getting things done second edition", including a projectFile, inbox, calendar, reference, Next task... When you start emacs, org-mode is already preconfigured to work with the files.
* A preconfigured Spacemacs Docker container based on Manjaro Linux. It contains only Spacemacs running as a separate user and the packages installed by the installer script. The Spacemacs user's home is persisted in a Docker volume to allow local package installation and caching to work as expected. To run Spacemacs execute the provided startEmacsDocker<OS>.sh. On linux Spacemacs will be started in your local X server session. In Windows an SSH connection is necessary for which a one time public key setup must be executed manually. Please refer to the start script for detailed instructions.

Notice that to get a fullfledged ide a one time setup must be done including:
* configuring your git identity
* building your local version of hie the haskell language server, only required if you are using it
For these `post_build.sh` is available which should be called in the terminal once the home volume is created.
