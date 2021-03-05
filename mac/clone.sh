#!/bin/sh

source "prefix.sh"
source "helper.sh"

git clone https://github.com/unicode-org/icu.git "${BUILD_DIR}/icu_git" --depth=1 --branch=release-${ICU_VERSION}

cp -r "${BUILD_DIR}/icu_git/icu4c/" ${ICU_DIR}
