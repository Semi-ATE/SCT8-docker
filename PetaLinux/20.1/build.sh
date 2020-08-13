#!/usr/bin/bash
START_TIME=$(date +%s)

# Ubuntu
############################################################################
UBUNTU=20.04
BASE_IMAGE="ubuntu:${UBUNTU}"

# PetaLinux
############################################################################
PETA="2020.1"
PETA_RUN_FILE="petalinux-v${PETA}-final-installer.run"
PETA_EXP_FILE="petalinux-v${PETA}-final-installer.exp"
SSTATE_ARCHIVE="sstate_aarch64_${PETA}.tar.gz"
DOWNLOAD_ARCHIVE="downloads_${PETA}.tar.gz"
TAG="petalinux:${PETA}"

if [ ! -f "${PETA_RUN_FILE}" ]; then
    printf "Please download '${PETA_RUN_FILE}'.\n"
    exit 1
fi

if [ ! -f "${PETA_EXP_FILE}" ]; then
    printf "Please re-create the '${PETA_EXP_FILE}' expect file.\n"
    exit 1
fi

if [ ! -f "${SSTATE_ARCHIVE}" ]; then
    printf "Please download '${SSTATE_ARCHIVE}'.\n"
    exit 1
fi

#if [ ! -f "${DOWNLOAD_ARCHIVE}" ]; then
#    printf "Please download '${DOWNLOAD_ARCHIVE}'.\n"
#    exit 1
#fi

# brass
############################################################################
BRAS="2.3.2"
BRAS_ARCHIVE="bras-${BRAS}.tar.gz"
BRAS_PATCH="bras-${BRAS}.patch"

if [ ! -f "${BRAS_ARCHIVE}" ]; then
    printf "Please download '${BRAS_ARCHIVE}'.\n"
    exit 1
fi

if [ ! -f "${BRAS_PATCH}" ]; then
    printf "Please re-create the '$BRAS_PATCH}' file.\n"
    exit 1
fi

# entrypoint
############################################################################
ENTRYPOINT="entrypoint.sh"

if [ ! -f "${ENTRYPOINT}" ]; then
    printf "Please re-create the '${ENTRYPOINT}' file.\n"
    exit 1
fi

# Build container
############################################################################
printf "\nBuilding docker image '${TAG}' from Ubuntu ${UBUNTU} with:\n"
printf "  - PetaLinux v${PETA}\n"
printf "  - brass v${BRAS}\n"
printf "  - entrypoint = '${ENTRYPOINT}'\n\n"

docker build --build-arg BASE_IMAGE=$BASE_IMAGE --build-arg PETA=$PETA --build-arg BRAS=$BRAS -t $TAG .

END_TIME=$(date +%s)
RUN_TIME=$(($END_TIME-$START_TIME))
RUN_TIME_MIN=$(echo "scale=1 ; $RUN_TIME / 60" | bc)

printf "\nBuilding took ${RUN_TIME_MIN} minutes.\n"
printf "\nNext steps:\n"
printf "  \$cat ~/GH_TOKEN.txt | docker login docker.pkg.github.com -u <USER> --password-stdin\n"
printf " ...>>> add the tagging stuff\n"
printf "  \$docker push ${TAG}\n"

