#!/bin/sh

source "prefix.sh"
source "helper.sh"

echo "==================================="
echo "===== Running build for macOS ====="
echo "==================================="

mkdir -p ${ICU_DIR}
mkdir -p ${ICU_SOURCE}
mkdir -p ${MAC_INSTALL_DIR}

if [ ! -d "${BUILD_DIR}/icu_git" ] ; then
#do this only if git with icu data is not available
sh ${BASE_ICU_DIR}/mac/clone.sh
sh ${BASE_ICU_DIR}/mac/patch.sh
fi

sh ${BASE_ICU_DIR}/mac/build_macosx.sh

cd ${BASE_ICU_DIR}
