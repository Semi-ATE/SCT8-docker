#!/usr/bin/bash
START_TIME=$(date +%s)

UBUNTU=20.04
BASE_IMAGE="ubuntu:${UBUNTU}"
NAME="trial"
TAG="${NAME}:${UBUNTU}"

# Build container
############################################################################
printf "\nBuilding docker image '${TAG}' from Ubuntu ${UBUNTU} with:\n"
printf "  - ${NAME} v${UBUNTU}\n"

docker build --build-arg BASE_IMAGE=$BASE_IMAGE -t $TAG .

END_TIME=$(date +%s)
RUN_TIME=$(($END_TIME-$START_TIME))
RUN_TIME_MIN=$(echo "scale=1 ; $RUN_TIME / 60" | bc)

printf "\nBuilding took ${RUN_TIME_MIN} minutes.\n"
printf "\nNext steps:\n"
printf "  \$docker images"
printf "  REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE\n"
printf "  trial               2020.1              05b1e474ae1b        10 seconds ago      37.6GB\n"
printf "  ubuntu              20.04               1e4467b07108        3 weeks ago         73.9MB\n"
printf "  \$cat ~/GH_TOKEN.txt | docker login docker.pkg.github.com -u <USER> --password-stdin\n"
printf "  \$docker tag <IMAGE_ID> docker.pkg.github.com/semi-ate/sct8-board/petalinux:2020.1\n"
printf "  \$docker push docker.pkg.github.com/semi-ate/sct8-board/petalinux:2020.1\n"

