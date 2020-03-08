# syntax = docker/dockerfile:1.0-experimental
FROM smile13241324/spacemacs-installerandconfig-base
LABEL Description="This image creates a dockerized version of spacemacs with all external tools required. It persists the home dir of the local user in a volume this allows to save stuff and let emacs caches work as expected. An ssh server is also installed for X forwarding accepting only public key authentification from the base image. To use it add your public key to ~/.ssh/authorized_keys" Vendor="smile13241324@gmail.com" Version="1.5"
COPY --chown=spacemacs:spacemacs . /installRepo
WORKDIR /installRepo
RUN ./spacemacsAutoInstall_manjaro.sh \
  && mkdir -p /home/spacemacs/Documents \
  && mv ./GTD /home/spacemacs/Documents/GTD \
  && rm "${HOME}/.spacemacsInstall" -R

# Persist the home dir where spacemacs resides
VOLUME /home/spacemacs

# Define emacs as default command
CMD emacs
