#syntax=docker/dockerfile:1
FROM manjarolinux/base

LABEL Description="This image creates a dockerized version of spacemacs with all external tools required. It persists the home dir of the local user in a volume this allows to save stuff and let emacs caches work as expected." Vendor="smile13241324@gmail.com" Version="2.0"
COPY . /installRepo
WORKDIR /installRepo
RUN sed -i 's/IgnorePkg.*/#IgnorePkg/' /etc/pacman.conf \
    && ./spacemacsAutoInstall_manjaro.sh "sudoRun" \
    && useradd -m spacemacs -U \
    && chown spacemacs:spacemacs /installRepo -R
USER spacemacs:spacemacs
RUN ./spacemacsAutoInstall_manjaro.sh \
    && mkdir -p /home/spacemacs/Documents \
    && mv ./GTD /home/spacemacs/Documents/GTD \
    && rm "${HOME}/.spacemacsInstall" -R

# Persist the home dir where spacemacs resides
VOLUME /home/spacemacs

# Define emacs as default command
CMD emacs
