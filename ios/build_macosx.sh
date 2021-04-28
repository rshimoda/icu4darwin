#!/bin/sh

source "../helper.sh"

echo "======================================"
echo "===== Run build for Mac Catalyst ====="
echo "======================================"

build "x86_64" "x86_64-apple-darwin" "macosx" "x86_64-apple-ios13.1-macabi"
build "arm64" "aarch64-apple-darwin" "macosx" "arm64-apple-ios13.1-macabi"

combineICULibraries "build-x86_64-macosx" "libicu"
combineICULibraries "build-arm64-macosx" "libicu"

mkdir -p "fat-lib-macosx"
lipo -create \
 "build-x86_64-macosx/lib/libicu.a" \
 "build-arm64-macosx/lib/libicu.a" \
 -output "fat-lib-macosx/libicu.a"
