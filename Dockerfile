FROM jonathonf/manjaro
LABEL Description="This image creates a dockerized version of spacemacs with all external tools required. It persists the home dir of the local user in a volume this allows to save stuff and let emacs caches work as expected. An ssh server is also installed for X forwarding accepting only public key authentification. To use it add your public key to ~/.ssh/authorized_keys" Vendor="smile13241324@gmail.com" Version="1.0"
COPY . /installRepo
WORKDIR /installRepo
RUN ./spacemacsAutoInstall_manjaro.sh "sudoRun" \
&& sed -i 's/#X11Forwarding.*/X11Forwarding yes/' /etc/ssh/sshd_config \
&& sed -i 's/#PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config \
&& sed -i 's/UsePAM.*/#UsePAM yes/' /etc/ssh/sshd_config \
&& /usr/bin/ssh-keygen -A \
&& useradd -m spacemacs -U
USER spacemacs:spacemacs
RUN ./spacemacsAutoInstall_manjaro.sh \
&& mkdir -p /home/spacemacs/Documents \
&& cp ./GTD /home/spacemacs/Documents/GTD -R

# Persist the home dir where spacemacs resides
VOLUME /home/spacemacs

# Expose the default ssh port, only forward when you want to connect via ssh for X forwarding
EXPOSE 22
CMD emacs
