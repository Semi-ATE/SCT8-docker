ARG BASE_IMAGE
FROM $BASE_IMAGE

MAINTAINER Semi-ATE <Semi-ATE@users.noreply.github.com>

ARG PETA

ARG MCUX

ARG BRAS

# Base installation
############################################################################
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y -q \
sudo \
tree \
apt-utils \
less && \
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

# Pre-requisites for all packages
############################################################################
RUN dpkg --add-architecture i386 && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y -q \
autoconf \
bc \
bison \
build-essential \
chrpath \
cpio \
curl \
dfu-util \
diffstat \
expect \
emacs-nox \
flex \
gawk \
gcc \
gcc-multilib \
git \
gnupg \
gzip \
iproute2 \
kmod \
lib32z1-dev \
libglib2.0-dev \
libgtk2.0-0 \
libncurses5 \
libncurses5-dev \
libncursesw5-dev \
libsdl1.2-dev \
libselinux1 \
libssl-dev \
libtool \
libtool-bin \
libusb-1.0-0-dev \
libwebkit2gtk-4.0-37 \
locales \
make \
net-tools \
pax \
pv \
rsync \
screen \
socat \
tar \ 
tcl-dev \
texinfo \
tftp \
tofrodos \
u-boot-tools \
unzip \
update-inetd \
wget \
whiptail \
xterm \
xvfb \
zlib1g:i386 \
zlib1g-dev \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Clean up a bit
############################################################################
RUN locale-gen en_US.UTF-8 && update-locale
# make /bin/sh symlink to bash instead of dash:
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

# PetaLinux Instalation
############################################################################
ENV PETA_RUN_FILE=petalinux-v${PETA}-final-installer.run
ENV PETA_EXP_FILE=petalinux-v${PETA}-final-installer.exp
ENV PETA_AARCH64_FILE=sstate_aarch64_${PETA}.tar.gz
#ENV PETA_MIRROR_FILE

WORKDIR ${HOMEDIR}
COPY ${PETA_RUN_FILE} .
COPY ${PETA_EXP_FILE} .
COPY ${PETA_AARCH64_FILE} .
#COPY ${PETA_DOWNLOAD_FILE} .

RUN chmod a+rx ${HOMEDIR}/${PETA_RUN_FILE} && \
chmod a+rx ${HOMEDIR}/${PETA_INST_FILE} && \
su ${USER} ${HOMEDIR}/${PETA_EXP_FILE} && \
echo "source ${HOMEDIR}/petalinux/settings.sh" >> ${HOMEDIR}/.bashrc && \
rm -f ${HOMEDIR}/${PETA_RUN_FILE} ${HOMEDIR}/${PETA_EXP_FILE} && \
mkdir ./sstate-cache && \
pv ${HOMEDIR}/${PETA_AARCH64_FILE} | tar xzf - -C ./sstate-cache


# MCUXpresso Installation
############################################################################
ENV MCUX_BASE_NAME=mcuxpressoide-${MCUX}
ENV MCUX_DEB_FILE=${MCUX_BASE_NAME}.x86_64.deb
ENV MCUX_BIN_FILE=${MCUX_DEB_FILE}.bin

WORKDIR ${HOMEDIR}
COPY ${MCUX_BIN_FILE} .

RUN chmod +x ./${MCUX_BIN_FILE} && \
./${MCUX_BIN_FILE} --noexec --target mcuxpresso && \
dpkg --unpack mcuxpresso/${MCUX_DEB_FILE} && \
rm /var/lib/dpkg/info/mcuxpressoide.postinst -f && \
dpkg --configure --force-depends mcuxpressoide && \
rm -rf ${HOMEDIR}/mcuxpresso/ && \
rm ${HOMEDIR}/${MCUX_BIN_FILE} && \
ln -s /usr/local/${MCUX_BASE_NAME}/ide/mcuxpressoide /bin/mcuxpressoide

# bras installation
############################################################################
ENV BRAS_TGZ_FILE=bras-${BRAS}.tar.gz
ENV BRAS_PATCH_FILE=bras-${BRAS}.patch

COPY ${BRAS_TGZ_FILE} .


# prepare the SCT8-Board project
############################################################################
#ENV SCT8 ${HOMEDIR}/SCT8-Board
#RUN mkdir ${SCT8}
#WORKDIR ${SCT8}
#VOLUME ${SCT8}

#WORKDIR /
#COPY entrypoint.sh /
#ENTRYPOINT ["entrypoint.sh"]