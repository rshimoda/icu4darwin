#!/bin/sh

source "../helper.sh"

echo "========================================="
echo "===== Run build for macOS (arm64) ====="
echo "========================================="

build "arm64-macosx" "arm64" "aarch64-apple-darwin" "macosx"
combineICULibraries "build-arm64-macosx" "RDICU4c"


