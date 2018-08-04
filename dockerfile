FROM jonathonf/manjaro
LABEL Description="This image creates a dockerized version of spacemacs with all external tools required. It persists the home dir of the local user in a volume this allows to save stuff and let emacs caches work as expected." Vendor="smile13241324@gmail.com" Version="1.0"
COPY . /installRepo
WORKDIR /installRepo
RUN ./spacemacsAutoInstall_manjaro.sh "sudoRun" \
&& useradd -m spacemacs -U
USER spacemacs:spacemacs
RUN ./spacemacsAutoInstall_manjaro.sh

# Persist the home dir where spacemacs resides
VOLUME /home/spacemacs
CMD emacs
