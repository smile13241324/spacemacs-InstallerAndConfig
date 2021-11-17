# syntax = docker/dockerfile:1.0-experimental
FROM manjarolinux/base
LABEL Description="This image creates a dockerized version of spacemacs with all external tools required. It persists the home dir of the local user in a volume this allows to save stuff and let emacs caches work as expected. An ssh server is also installed for X forwarding accepting only public key authentification from the base image. To use it add your public key to ~/.ssh/authorized_keys" Vendor="smile13241324@gmail.com" Version="1.5"
COPY . /installRepo
WORKDIR /installRepo
RUN ./spacemacsAutoInstall_manjaro.sh "sudoRun" \
    && sed -i 's/#X11Forwarding.*/X11Forwarding yes/' /etc/ssh/sshd_config \
    && sed -i 's/#X11UseLocalhost.*/X11UseLocalhost no/' /etc/ssh/sshd_config \
    && sed -i 's/#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config \
    && sed -i 's/#PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/UsePAM.*/UsePAM yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config \
    && ssh-keygen -A \
    && useradd -m spacemacs -U \
    && chown spacemacs:spacemacs /installRepo -R
USER spacemacs:spacemacs
RUN ./spacemacsAutoInstall_manjaro.sh \
    && mkdir -p /home/spacemacs/Documents \
    && mv ./GTD /home/spacemacs/Documents/GTD \
    && rm "${HOME}/.spacemacsInstall" -R

# Persist the host key directory for easy replacement of standard container keys
VOLUME /etc/ssh

# Persist the home dir where spacemacs resides
VOLUME /home/spacemacs

# Expose the default ssh port, only forward when you want to connect via ssh for X forwarding
EXPOSE 22

# Define emacs as default command
CMD emacs
