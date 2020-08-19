ARG BASE_IMAGE
FROM $BASE_IMAGE

MAINTAINER Semi-ATE <Semi-ATE@users.noreply.github.com>

# Base installation
############################################################################
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y -q \
apt-utils \
less \
locales \
sudo \
tree && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* && \
echo "Set disable_coredump false" >> /etc/sudo.conf
# above line is a work-around for sudo v1.8.31
# https://github.com/sudo-project/sudo/issues/42
# once ubuntu updated to 1.9.x this can go away


# User installation
############################################################################
ENV USER=semiate
ENV HOMEDIR=/home/${USER}
RUN adduser --disabled-password --gecos '' ${USER} && \
  usermod -aG sudo ${USER} && \
  echo "${USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
WORKDIR ${HOMEDIR}

# Clean up a bit
############################################################################
RUN locale-gen en_US.UTF-8 && update-locale
# make /bin/sh symlink to bash instead of dash:
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

# prepare the SCT8-Board project
############################################################################
#ENV SCT8 ${HOMEDIR}/SCT8-Board
#RUN mkdir ${SCT8}
#WORKDIR ${SCT8}
#VOLUME ${SCT8}

#WORKDIR /
#COPY entrypoint.sh /
#ENTRYPOINT ["entrypoint.sh"]
