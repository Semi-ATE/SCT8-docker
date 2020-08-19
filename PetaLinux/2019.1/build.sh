#!/usr/bin/bash
START_TIME=$(date +%s)

# Ubuntu
############################################################################
UBUNTU=20.04
BASE_IMAGE="ubuntu:${UBUNTU}"
#TAG="sct8:$(date +'%y').$(date +'%V')"

TAG="docker.pkg.github.com/semi-ate/sct8-board/sct8:$(date +'%y').$(date +'%V').$(date +'%u')"


# PetaLinux
############################################################################
PETA_REGEX='^petalinux-v([0-9\.]+)-final-installer.run$'
PETA_BUILDS=()
for filename in $(ls); do
    [[ $filename =~ $PETA_REGEX ]]
    if [[ ${BASH_REMATCH[1]} != '' ]]
    then
	PETA_BUILDS+=( ${BASH_REMATCH[1]} )
    fi
done
if [ -z "$PETA_BUILDS" ]; then
    printf "Couldn't find an installer for PetaLinux ... aborting\\n"
    exit 1
fi
IFS=$'\n' PETA_SORTED_BUILDS=($(sort <<<"${PETA_BUILDS[*]}")); unset IFS
PETA=${PETA_SORTED_BUILDS[-1]}


#TODO add checking for the .exp and AARCH64 stuff !


# MCUXpresso                                                                                                                                                                                                                                 ############################################################################
MCUX_REGEX='^mcuxpressoide-([0-9\._]+).x86_64.deb.bin$'
MCUX_BUILDS=()
for filename in $(ls); do
    [[ $filename =~ $MCUX_REGEX ]]
    if [[ ${BASH_REMATCH[1]} != '' ]]
    then
        MCUX_BUILDS+=( ${BASH_REMATCH[1]} )
    fi
done
if [ -z "$MCUX_BUILDS" ]; then
    printf "Couldn't find an installer for MCUXpresso ... aborting\\n"
    exit 1
fi
IFS=$'\n' MCUX_SORTED_BUILDS=($(sort <<<"${MCUX_BUILDS[*]}")); unset IFS
MCUX=${MCUX_SORTED_BUILDS[-1]}

# brass
############################################################################
BRAS_REGEX='^bras-([0-9\.]+).tar.gz$'
BRAS_BUILDS=()
for filename in $(ls); do
    [[ $filename =~ $BRAS_REGEX ]]
    if [[ ${BASH_REMATCH[1]} != '' ]]
    then
        BRAS_BUILDS+=( ${BASH_REMATCH[1]} )
    fi
done
if [ -z "$BRAS_BUILDS" ]; then
    printf "Couldn't find a bras-x.y.z.tar.gz file  ... aborting\\n"
    exit 1
fi
IFS=$'\n' BRAS_SORTED_BUILDS=($(sort <<<"${BRAS_BUILDS[*]}")); unset IFS
BRAS=${BRAS_SORTED_BUILDS[-1]}

# Build container
############################################################################
printf "\nBuilding docker image '${TAG}' from Ubuntu ${UBUNTU} with:\n"
printf "  - PetaLinux : v${PETA}\n"
printf "  - MCUXpresso : v${MCUX}\n"
printf "  - brass : v${BRAS}\n\n"

docker build --build-arg BASE_IMAGE=$BASE_IMAGE --build-arg PETA=$PETA --build-arg MCUX=$MCUX --build-arg BRAS=$BRAS -t $TAG .
END_TIME=$(date +%s)
RUN_TIME=$(($END_TIME-$START_TIME))
RUN_TIME_MIN=$(echo "scale=1 ; $RUN_TIME / 60" | bc)

printf "\nBuilding took ${RUN_TIME_MIN} minutes.\n"
printf "\nNext steps:\n"
printf "  \$cat ~/GH_TOKEN.txt | docker login docker.pkg.github.com -u <USER> --password-stdin\n"
printf "  \$docker push ${TAG}\n"
