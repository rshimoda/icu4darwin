#!/bin/sh

source "prefix.sh"

rm -rf "${BUILD_DIR}"

rm -rf "${MAC_INSTALL_DIR}"
rm -rf "${BASE_ICU_DIR}/mac/build-"*
rm -rf "${BASE_ICU_DIR}/mac/fat-"*

rm -rf "${IOS_INSTALL_DIR}"
rm -rf "${BASE_ICU_DIR}/ios/build-"*
rm -rf "${BASE_ICU_DIR}/ios/fat-"*

rm -rf "${BASE_ICU_DIR}/XCFramework"

rm -rf "${BASE_ICU_DIR}/Frameworks"
rm -rf "${BASE_ICU_DIR}/Archive"

