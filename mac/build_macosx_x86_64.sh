#!/bin/sh

source "../helper.sh"

echo "========================================="
echo "===== Run build for macOS (x86_64) ====="
echo "========================================="

build "x86_64" "x86_64-apple-darwin" "macosx" "x86_64-apple-macos10.9"
combineICULibraries "build-x86_64-macosx" "libicu"
