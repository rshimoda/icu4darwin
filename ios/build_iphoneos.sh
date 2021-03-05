#!/bin/sh

source "../helper.sh"

echo "======================================"
echo "===== Run build for iOS (iPhone) ====="
echo "======================================"

build "armv7s" "armv7s" "armv7s-apple-darwin" "iphoneos"
#build "armv7" "armv7" "armv7-apple-darwin" "iphoneos"
build "arm64" "arm64" "aarch64-apple-darwin" "iphoneos"

combineICULibraries "build-armv7s" "RDICU4c"
#combineICULibraries "armv7" "RDICU4c"
combineICULibraries "build-arm64" "RDICU4c"

mkdir -p "fat-lib-iphoneos"
lipo -create -output "fat-lib-iphoneos/RDICU4c.a" "build-armv7s/lib/RDICU4c.a" "build-arm64/lib/RDICU4c.a"
#cp "build-arm64/lib/RDICU4c.a" "fat-lib-iphoneos"