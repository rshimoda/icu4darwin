export ICU_VERSION_MAJOR="64"
export ICU_VERSION_MINOR="2"
export ICU_VERSION="${ICU_VERSION_MAJOR}-${ICU_VERSION_MINOR}"

#base directory
export BASE_ICU_DIR="/Users/sergi/Developer/icu4darwin/"

#Where buidling data are put
export BUILD_DIR="${BASE_ICU_DIR}/build"

export ICU_DIR="${BUILD_DIR}/icu-${ICU_VERSION}"

export ICU_SOURCE="${ICU_DIR}/source"

export PREBUILD="${BUILD_DIR}/scripts/mac/icu_build"

export NDK_STANDALONE_TOOLCHAIN_ROOT="${BUILD_DIR}/scripts/android/toolchains"

export ANDROID_NDK_ROOT="/Users/perry/Library/Android/sdk/android-ndk-r16b"

#Where final builded data are put
export MAC_INSTALL_DIR="${BASE_ICU_DIR}/mac/mac-install"
export IOS_INSTALL_DIR="${BASE_ICU_DIR}/ios/ios-install"
export ANDROID_INSTALL_DIR="${BASE_ICU_DIR}/android/android-install"

#if FILTER variable is not set, all settings are used
#https://github.com/unicode-org/icu/blob/master/docs/userguide/icu_data/buildtool.md
export FILTER="${BASE_ICU_DIR}/filters.json"

#====================================================================================
#====================================================================================
#====================================================================================

export CONFIG_PREFIX=" --enable-extras=no \
--enable-tools=yes \
--enable-icuio=yes \
--enable-strict=no \
--enable-static \
--enable-shared=no \
--enable-tests=no \
--disable-renaming \
--enable-samples=no \
--enable-dyload=no \
--with-data-packaging=static"

export CFLAGS="-O3 -fno-exceptions"
export CXXFLAGS="${CFLAGS} -std=c++11"

#will set value to 1
defines_config_set_1=( \
"UCONFIG_NO_LEGACY_CONVERSION" \
"UCONFIG_NO_BREAK_ITERATION" \
"CONFIG_NO_CONVERSION" \
"U_DISABLE_RENAMING" \
)

#will set value to 0
defines_config_set_0=( \
"U_HAVE_NL_LANGINFO_CODESET" \
"UCONFIG_NO_TRANSLITERATION" \
"U_USING_ICU_NAMESPACE" \
"UCONFIG_NO_FORMATTING" \
)

#will set value to 1
defines_utypes=( \
"U_CHARSET_IS_UTF8" \
)


