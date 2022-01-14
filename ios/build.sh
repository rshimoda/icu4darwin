#!/bin/sh

source "prefix.sh"
source "helper.sh"

echo "================================="
echo "===== Running build for iOS ====="
echo "================================="

cd $BASE_ICU_DIR/ios/

./build_iphoneos.sh
./build_iphonesimulator.sh
./build_macosx.sh

cd $BASE_ICU_DIR

