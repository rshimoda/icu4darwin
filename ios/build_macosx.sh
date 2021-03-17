#!/bin/sh

source "../helper.sh"

echo "======================================"
echo "===== Run build for Mac Catalyst ====="
echo "======================================"

build "x86_64" "x86_64-apple-darwin" "macosx" "x86_64-apple-ios13.1-macabi"
build "arm64" "aarch64-apple-darwin" "macosx" "arm64-apple-ios13.1-macabi"

combineICULibraries "build-x86_64-macosx" "libRDICU4c"
combineICULibraries "build-arm64-macosx" "libRDICU4c"

mkdir -p "fat-lib-macosx"
lipo -create \
 "build-x86_64-macosx/lib/libRDICU4c.a" \
 "build-arm64-macosx/lib/libRDICU4c.a" \
 -output "fat-lib-macosx/libRDICU4c.a"
