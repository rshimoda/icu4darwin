#!/bin/sh

source "../helper.sh"

echo "======================================"
echo "===== Run build for iOS (iPhone) ====="
echo "======================================"

build "armv7s" "armv7s-apple-darwin" "iphoneos" "armv7s-apple-ios9.0"
build "armv7" "armv7-apple-darwin" "iphoneos" "armv7-apple-ios9.0"
build "arm64" "aarch64-apple-darwin" "iphoneos" "arm64-apple-ios9.0"

combineICULibraries "build-armv7s-iphoneos" "libicu"
combineICULibraries "build-armv7-iphoneos" "libicu"
combineICULibraries "build-arm64-iphoneos" "libicu"

mkdir -p "fat-lib-iphoneos"
lipo -create \
 "build-armv7s-iphoneos/lib/libicu.a" \
 "build-armv7-iphoneos/lib/libicu.a" \
 "build-arm64-iphoneos/lib/libicu.a" \
 -output "fat-lib-iphoneos/libicu.a"
