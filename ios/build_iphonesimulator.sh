#!/bin/sh

source "../helper.sh"

echo "========================================="
echo "===== Run build for iOS (Simulator) ====="
echo "========================================="

build "x86_64-simulator" "x86_64" "x86_64-apple-darwin" "iphonesimulator"
build "arm64-simulator" "arm64" "aarch64-apple-darwin" "iphonesimulator"

combineICULibraries "build-x86_64-simulator" "RDICU4c"
#combineICULibraries "armv7" "RDICU4c"
combineICULibraries "build-arm64-simulator" "RDICU4c"

mkdir -p "fat-lib-iphonesimulator"
lipo -create -output "fat-lib-iphonesimulator/RDICU4c.a" "build-x86_64-simulator/lib/RDICU4c.a" "build-arm64-simulator/lib/RDICU4c.a"

