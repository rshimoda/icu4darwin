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

DEVICE_ARCH=`arch`

if [ $DEVICE_ARCH == 'arm64' ]; then
export CFLAGS="${CFLAGS} -target arm64-apple-macos10.9"
export CXXFLAGS="${CXXFLAGS} -target arm64-apple-macos10.9"
export LDFLAGS="${LDFLAGS} -target arm64-apple-macos10.9"
else
export CFLAGS="${CFLAGS} -target x86_64-apple-macos10.9"
export CXXFLAGS="${CXXFLAGS} -target x86_64-apple-macos10.9"
export LDFLAGS="${LDFLAGS} -target x86_64-apple-macos10.9"
fi

sh ${ICU_SOURCE}/runConfigureICU MacOSX --prefix=${PLATFORM_PREFIX} ${CONFIG_PREFIX}

make clean
make -j`sysctl -n hw.ncpu`
make install

cd ${MAC_INSTALL_DIR}

combineICULibraries "." "libicu"

cd ${BASE_ICU_DIR}/mac

CROSS_BUILT_DIR=""

if [ $DEVICE_ARCH == 'arm64' ]; then
sh ${BASE_ICU_DIR}/mac/build_macosx_x86_64.sh
export CROSS_BUILT_DIR="build-x86_64-macosx"
else
sh ${BASE_ICU_DIR}/mac/build_macosx_arm64.sh
export CROSS_BUILT_DIR="build-arm64-macosx"
fi

mkdir -p "fat-lib-macosx"
lipo -create \
 "${MAC_INSTALL_DIR}/lib/libicu.a" \
 "${CROSS_BUILT_DIR}/lib/libicu.a" \
 -output "fat-lib-macosx/libicu.a"

cd ${BASE_ICU_DIR}