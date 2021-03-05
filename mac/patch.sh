#!/bin/sh

source "prefix.sh"
source "helper.sh"

echo "===== Modify icu/source/common/unicode/uconfig.h ====="

cp "${ICU_SOURCE}/common/unicode/uconfig" "${ICU_SOURCE}/common/unicode/uconfig.h" 2>/dev/null
cp "${ICU_SOURCE}/common/unicode/uconfig.h" "${ICU_SOURCE}/common/unicode/uconfig" 2>/dev/null

for var in "${defines_config_set_1[@]}"
do
sed "/define __UCONFIG_H__/a \\
#ifndef ${var} \\
#define ${var} 1 \\
#endif \\
" "${ICU_SOURCE}/common/unicode/uconfig.h" > "${ICU_SOURCE}/common/unicode/uconfig.tmp"

mv "${ICU_SOURCE}/common/unicode/uconfig.tmp" "${ICU_SOURCE}/common/unicode/uconfig.h"
done

for var in "${defines_config_set_0[@]}"
do
sed "/define __UCONFIG_H__/a \\
#ifndef ${var} \\
#define ${var} 0 \\
#endif \\
" "${ICU_SOURCE}/common/unicode/uconfig.h" > "${ICU_SOURCE}/common/unicode/uconfig.tmp"

mv "${ICU_SOURCE}/common/unicode/uconfig.tmp" "${ICU_SOURCE}/common/unicode/uconfig.h"
done

echo "===== Modify icu/source/common/unicode/utypes.h ====="

cp "${ICU_SOURCE}/common/unicode/utypes" "${ICU_SOURCE}/common/unicode/utypes.h" 2>/dev/null
cp "${ICU_SOURCE}/common/unicode/utypes.h" "${ICU_SOURCE}/common/unicode/utypes" 2>/dev/null

for var in "${defines_utypes[@]}"
do
sed "/define UTYPES_H/a \\
#ifndef ${var} \\
#define ${var} 1 \\
#endif \\
" "${ICU_SOURCE}/common/unicode/utypes.h" > "${ICU_SOURCE}/common/unicode/utypes.tmp"

mv "${ICU_SOURCE}/common/unicode/utypes.tmp" "${ICU_SOURCE}/common/unicode/utypes.h"
done

echo "===== Patching icu/source/tools/pkgdata/pkgdata.cpp for iOS ====="

cp "${ICU_SOURCE}/tools/pkgdata/pkgdata" "${ICU_SOURCE}/tools/pkgdata/pkgdata.cpp" 2>/dev/null
cp "${ICU_SOURCE}/tools/pkgdata/pkgdata.cpp" "${ICU_SOURCE}/tools/pkgdata/pkgdata" 2>/dev/null

sed "s/int result = system(cmd);/ \\
#if defined(IOS_SYSTEM_FIX) \\
pid_t pid; \\
char * argv[2]; argv[0] = cmd; argv[1] = NULL; \\
posix_spawn(\&pid, argv[0], NULL, NULL, argv, environ); \\
waitpid(pid, NULL, 0); \\
int result = 0; \\
#else \\
int result = system(cmd); \\
#endif \\
/g" "${ICU_SOURCE}/tools/pkgdata/pkgdata.cpp" > "${ICU_SOURCE}/tools/pkgdata/pkgdata.tmp"

sed "/#include <stdlib.h>/a \\
#if defined(IOS_SYSTEM_FIX) \\
#include <spawn.h> \\
extern char **environ; \\
#endif \\
" "${ICU_SOURCE}/tools/pkgdata/pkgdata.tmp" > "${ICU_SOURCE}/tools/pkgdata/pkgdata.cpp"


#mv "${ICU_SOURCE}/tools/pkgdata/pkgdata.tmp" "${ICU_SOURCE}/tools/pkgdata/pkgdata.cpp"