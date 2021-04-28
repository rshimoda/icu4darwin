#!/bin/sh

source "../helper.sh"

echo "========================================="
echo "===== Run build for macOS (arm64) ====="
echo "========================================="

build "arm64" "aarch64-apple-darwin" "macosx" "arm64-apple-macos10.9"
combineICULibraries "build-arm64-macosx" "libicu"
