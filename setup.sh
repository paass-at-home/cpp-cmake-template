#!/bin/bash
set -euo pipefail

# define directories relative to script directory
BASE_PATH=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
THIRD_PARTY_PATH="$BASE_PATH/third-party"
DOWNLOADS_PATH="$BASE_PATH/.downloads"

if [ ! -d ${THIRD_PARTY_PATH} ]; then
    mkdir -p ${THIRD_PARTY_PATH}
fi
if [ ! -d ${DOWNLOADS_PATH} ]; then
    mkdir -p ${DOWNLOADS_PATH}
fi

# SFML
URL="https://www.sfml-dev.org/files/SFML-2.5.1-sources.zip"
ZIP_FILE="SFML-2.5.1-sources.zip"
ZIP_OUTPUT_DIRECTORY="SFML-2.5.1"
THIRD_PARTY_OUTPUT_PATH="${THIRD_PARTY_PATH}/SFML"

pushd ${THIRD_PARTY_PATH}
if [ ! -d ${THIRD_PARTY_OUTPUT_PATH} ]; then

    if [ ! -f ${DOWNLOADS_PATH}/${ZIP_FILE} ]; then
        echo "Downloading ${ZIP_FILE} into ${DOWNLOADS_PATH} folder ..."
        curl -Lso ${DOWNLOADS_PATH}/${ZIP_FILE} ${URL}  >/dev/null
    fi
    
    echo "Unzipping ${ZIP_FILE} into ${ZIP_OUTPUT_DIRECTORY} ..."
	unzip ${DOWNLOADS_PATH}/${ZIP_FILE} >/dev/null
	
	cd ${THIRD_PARTY_PATH}/${ZIP_OUTPUT_DIRECTORY}
	
	mkdir ./build && cd ./build
	cmake .. -DGL_SILENCE_DEPRECATION=true \
	  -DBUILD_SHARED_LIBS=true \
	  -DSFML_BUILD_FRAMEWORKS=true \
	  -DCMAKE_INSTALL_PREFIX=${THIRD_PARTY_OUTPUT_PATH}/Frameworks \
	  -DSFML_DEPENDENCIES_INSTALL_PREFIX=${THIRD_PARTY_OUTPUT_PATH}/Frameworks \
	  -DSFML_MISC_INSTALL_PREFIX=${THIRD_PARTY_OUTPUT_PATH}/misc

    cmake --build . --config Release
    cmake --install . --config Release

    cd ${THIRD_PARTY_PATH}
    rm -rf ${THIRD_PARTY_PATH}/${ZIP_OUTPUT_DIRECTORY}
fi
popd
