# icu4darwin

Build scripts to produce a XCFramwork for libicu4c. 

# Included platforms and architectures:
- macosx (x86_64, arm64)
- iphoneos (armv7s, arm64)
- iphonesimulator (x86_64, arm64)

# Coming soon:
- mac catalyst (x86_64, arm64)

# Usage:
1. modify `prefix.sh`
  1.1 set `BASE_ICU_DIR` (full path to project directory)
  1.2 (optional) specify ICU version (64.2 by default)
2. run `sh create-xcframework`
3. if everything is ok, the resulting XCFramework will be located in $BASE_ICU_DIR/XCFramework
