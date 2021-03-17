#!/bin/sh

source "../helper.sh"

echo "========================================="
echo "===== Run build for iOS (Simulator) ====="
echo "========================================="

build "x86_64" "x86_64-apple-darwin" "iphonesimulator" "x86_64-apple-ios9.0-simulator"
build "arm64" "aarch64-apple-darwin" "iphonesimulator" "arm64-apple-ios9.0-simulator"

combineICULibraries "build-x86_64-iphonesimulator" "libRDICU4c"
combineICULibraries "build-arm64-iphonesimulator" "libRDICU4c"

mkdir -p "fat-lib-iphonesimulator"
lipo -create \
 "build-x86_64-iphonesimulator/lib/libRDICU4c.a" \
 "build-arm64-iphonesimulator/lib/libRDICU4c.a" \
 -output "fat-lib-iphonesimulator/libRDICU4c.a"
