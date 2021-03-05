#!/bin/sh

source "prefix.sh"
source "helper.sh"

echo "========================================"
echo "===== Run build for MacOS (Native) ====="
echo "========================================"

#export PLATFORM_PREFIX="${PWD}/${MAC_INSTALL_DIR}"
export PLATFORM_PREFIX="${MAC_INSTALL_DIR}"

export CPPFLAGS=${CFLAGS}

mkdir -p ${PREBUILD}
cd ${PREBUILD}

if [ -z ${FILTER+x} ]; then
    echo "No filters"
else
    echo "Using filters ${FILTER}"
    export ICU_DATA_FILTER_FILE="${FILTER}"
fi

sh ${ICU_SOURCE}/runConfigureICU MacOSX --prefix=${PLATFORM_PREFIX} ${CONFIG_PREFIX}

make clean
make -j8
make install

cd ${MAC_INSTALL_DIR}

combineICULibraries "." "RDICU4c"

cd ${BASE_ICU_DIR}/mac

DEVICE_ARCH=`arch`
CROSS_BUILT_DIR=""

if [ $DEVICE_ARCH == 'arm64' ]; then
sh ${BASE_ICU_DIR}/mac/build_macosx_x86_64.sh
export CROSS_BUILT_DIR="build-x86_64-macosx"
else
sh ${BASE_ICU_DIR}/mac/build_macosx_arm64.sh
export CROSS_BUILT_DIR="build-arm64-macosx"
fi

mkdir -p "fat-lib-macosx"
lipo -create -output "fat-lib-macosx/RDICU4c.a" "${MAC_INSTALL_DIR}/lib/RDICU4c.a" "${CROSS_BUILT_DIR}/lib/RDICU4c.a"

cd ${BASE_ICU_DIR}