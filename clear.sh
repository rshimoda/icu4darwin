#!/bin/sh

source "prefix.sh"

rm -rf "${BUILD_DIR}"

rm -rf "${BASE_ICU_DIR}/mac/${MAC_INSTALL_DIR}"
rm -rf "${BASE_ICU_DIR}/mac/build-*"
rm -rf "${BASE_ICU_DIR}/mac/fat-*"

rm -rf "${BASE_ICU_DIR}/ios/${IOS_INSTALL_DIR}"
rm -rf "${BASE_ICU_DIR}/ios/build-*"
rm -rf "${BASE_ICU_DIR}/ios/fat-*"

rm -rf "${BASE_ICU_DIR}/XCFramework"

