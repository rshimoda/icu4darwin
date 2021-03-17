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

DEVELOPER="$(xcode-select --print-path)"
SDKROOT="$(xcodebuild -version -sdk ${SDK} | grep -E '^Path' | sed 's/Path: //')"

export BUILD_DIR="${PWD}/build-${ARCH}-${SDK}"

ICU_FLAGS="-I${ICU_SOURCE}/common/ -I${ICU_SOURCE}/tools/tzcode/ "

export ADDITION_FLAG="-DIOS_SYSTEM_FIX"

export CXX="${DEVELOPER}/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++"
export CC="${DEVELOPER}/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang"
export CFLAGS="-isysroot ${SDKROOT} -I${SDKROOT}/usr/include/ -I./include/ $5${ICU_FLAGS} ${CFLAGS} -target ${TARGET} ${ADDITION_FLAG}"
export CXXFLAGS="${CXXFLAGS} -stdlib=libc++ -isysroot ${SDKROOT} -I${SDKROOT}/usr/include/ -I./include/ -target ${TARGET} $5${ICU_FLAGS} ${ADDITION_FLAG}"
export LDFLAGS="-stdlib=libc++ -L${SDKROOT}/usr/lib/ -isysroot ${SDKROOT} -Wl,-dead_strip $5-lstdc++ -target ${TARGET} ${ADDITION_FLAG}"

echo "CXX: "$CXX
echo "CC: "$CC
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

sh ${ICU_SOURCE}/configure --host=${HOST} --with-cross-build=${PREBUILD} ${CONFIG_PREFIX}

make clean
make -j8
# make install

cd ..

}

function combineICULibraries {
# $1: working directory
# $2: output library name
initialWD=${PWD}

cd $1/lib/

echo "-- Generating static library $2"
libtool -o $2.a libicudata.a libicui18n.a libicuio.a libicuuc.a

cd $initialWD

}

