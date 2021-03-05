#!/bin/bash

source "prefix.sh"
source "helper.sh"

echo "================================="
echo "===== Running build for iOS ====="
echo "================================="

cd $BASE_ICU_DIR/ios/

sh build_iphoneos.sh
sh build_iphonesimulator.sh

cd $BASE_ICU_DIR

