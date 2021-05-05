#!/bin/sh

function build {
# $1: architecture
# $2: host triple
# $3: sdk name
# $4: deployment target name

unset CXX
unset CC
unset CFLAGS
unset CXXFLAGS
unset LDFLAGS

source "$PWD/../prefix.sh"

ARCH=$1
HOST=$2
SDK=$3
TARGET=$4

echo "-- Building ${ARCH} (host ${HOST}) on ${SDK} for ${TARGET}"

SDKROOT=$(xcrun --sdk ${SDK} --show-sdk-path) 

export BUILD_DIR="${PWD}/build-${ARCH}-${SDK}"

export ADDITION_FLAG="-DIOS_SYSTEM_FIX"

export CFLAGS="-isysroot ${SDKROOT} ${CFLAGS} -target ${TARGET} ${ADDITION_FLAG}"
export CXXFLAGS="-isysroot ${SDKROOT} ${CXXFLAGS} -stdlib=libc++ -target ${TARGET} ${ADDITION_FLAG}"
export LDFLAGS="-isysroot ${SDKROOT} -stdlib=libc++ -Wl,-dead_strip -lstdc++ -target ${TARGET} ${ADDITION_FLAG}"

echo "CFLAGS: "$CFLAGS
echo "CXXFLAGS: "$CXXFLAGS
echo "LDFLAGS: "$LDFLAGS

mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}

if [ -z ${FILTER+x} ]; then
    echo "No filters"
else
    echo "Using filters ${FILTER}"
    export ICU_DATA_FILTER_FILE="${FILTER}"
fi

${ICU_SOURCE}/configure --host=${HOST} --with-cross-build=${PREBUILD} ${CONFIG_PREFIX}

make clean
make -j`sysctl -n hw.ncpu`
# make install

cd ..

}

function combineICULibraries {
# $1: working directory
# $2: output library name
initialWD=${PWD}

cd $1/lib/

echo "-- Generating static library $2"
libtool -o $2.a libicudata.a libicui18n.a libicuuc.a

cd $initialWD

}

