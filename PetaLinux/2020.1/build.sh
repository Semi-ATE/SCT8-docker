#!/usr/bin/bash
START_TIME=$(date +%s)

UBUNTU=20.04
BASE_IMAGE="ubuntu:${UBUNTU}"
HASHES="hashes"

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

if [ ! -f "${DOWNLOAD_ARCHIVE}" ]; then
    printf "Please download '${DOWNLOAD_ARCHIVE}'.\n"
    exit 1
fi

# brass
############################################################################
BRAS="2.3.2"
BRAS_ARCHIVE="bras-${BRAS}.tar.gz"
BRAS_PATCH="brasfile"
BRAS_PATCH_FILE="${BRAS_PATCH}.patch"

if [ ! -f "${BRAS_ARCHIVE}" ]; then
    printf "Please download '${BRAS_ARCHIVE}'.\n"
    exit 1
fi

if [ ! -f "${BRAS_PATCH_FILE}" ]; then
    printf "Please re-create the '${BRAS_PATCH_FILE}' file.\n"
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
if [ ! -f ${HASHES} ]; then
    printf "'${HASHES}' file not found."
    exit 1
else
    md5sum --check ${HASHES}
fi
printf "\n"

docker build --build-arg BASE_IMAGE=$BASE_IMAGE --build-arg PETA=$PETA --build-arg BRAS=$BRAS -t $TAG .

END_TIME=$(date +%s)
RUN_TIME=$(($END_TIME-$START_TIME))
RUN_TIME_MIN=$(echo "scale=1 ; $RUN_TIME / 60" | bc)

printf "\nBuilding took ${RUN_TIME_MIN} minutes.\n"
printf "\nNext steps:\n"
printf "  \$docker images"
printf "  REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE\n"
printf "  petalinux           2020.1              05b1e474ae1b        10 seconds ago      37.6GB\n"
printf "  ubuntu              20.04               1e4467b07108        3 weeks ago         73.9MB\n"
printf "  \$cat ~/GH_TOKEN.txt | docker login docker.pkg.github.com -u <USER> --password-stdin\n"
printf "  \$docker tag <IMAGE_ID> docker.pkg.github.com/semi-ate/sct8-board/petalinux:2020.1\n"
printf "  \$docker push docker.pkg.github.com/semi-ate/sct8-board/petalinux:2020.1\n"

