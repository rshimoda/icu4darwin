#!/bin/sh

source "../helper.sh"

echo "========================================="
echo "===== Run build for macOS (x86_64) ====="
echo "========================================="

build "x86_64-macosx" "x86_64" "x86_64-apple-darwin" "macosx"
combineICULibraries "build-x86_64-macosx" "RDICU4c"


