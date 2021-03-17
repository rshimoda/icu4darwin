#!/bin/sh

source "../helper.sh"

echo "======================================"
echo "===== Run build for iOS (iPhone) ====="
echo "======================================"

build "armv7s" "armv7s-apple-darwin" "iphoneos" "armv7s-apple-ios9.0"
build "armv7" "armv7-apple-darwin" "iphoneos" "armv7-apple-ios9.0"
build "arm64" "aarch64-apple-darwin" "iphoneos" "arm64-apple-ios9.0"

combineICULibraries "build-armv7s-iphoneos" "libRDICU4c"
combineICULibraries "build-armv7-iphoneos" "libRDICU4c"
combineICULibraries "build-arm64-iphoneos" "libRDICU4c"

mkdir -p "fat-lib-iphoneos"
lipo -create \
 "build-armv7s-iphoneos/lib/libRDICU4c.a" \
 "build-armv7-iphoneos/lib/libRDICU4c.a" \
 "build-arm64-iphoneos/lib/libRDICU4c.a" \
 -output "fat-lib-iphoneos/libRDICU4c.a"
