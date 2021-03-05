#!/bin/sh

source "prefix.sh"

echo "Cleaning up..."
sh clear.sh

echo "Building for macOS..."
sh ${PWD}/mac/build.sh

echo "Building for iOS..."
sh ${PWD}/ios/build.sh

echo "Creating a XCFramework..."
mkdir "${PWD}/XCFramework" 
xcodebuild -create-xcframework \
-library "ios/fat-lib-iphoneos/RDICU4c.a" -headers "${MAC_INSTALL_DIR}/include" \
-library "ios/fat-lib-iphonesimulator/RDICU4c.a" -headers "${MAC_INSTALL_DIR}/include" \
-library "mac/fat-lib-macosx/RDICU4c.a" -headers "${MAC_INSTALL_DIR}/include" \
-output "XCFramework/RDICU4c.xcframework"