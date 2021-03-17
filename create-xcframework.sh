#!/bin/sh

source "prefix.sh"

echo "-- Cleaning up..."
./clear.sh

echo "-- Building for macOS..."
./mac/build.sh

echo "Building for iOS..."
./ios/build.sh

echo "-- Creating static XCFramework..."
xcodebuild -create-xcframework \
 -library "mac/fat-lib-macosx/libRDICU4c.a" -headers "${MAC_INSTALL_DIR}/include" \
 -library "ios/fat-lib-iphoneos/libRDICU4c.a" -headers "${MAC_INSTALL_DIR}/include" \
 -library "ios/fat-lib-iphonesimulator/libRDICU4c.a" -headers "${MAC_INSTALL_DIR}/include" \
 -library "ios/fat-lib-macosx/libRDICU4c.a" -headers "${MAC_INSTALL_DIR}/include" \
 -output "XCFramework/Static/RDICU4c.xcframework"

ICU_FRAMEWORK_VERSION=${ICU_VERSION_MAJOR}.${ICU_VERSION_MINOR}
ICU_FRAMEWORK_COMPATIBILITY_VERSION=${ICU_VERSION_MAJOR}.0

echo "-- Building macOS framework"
xcodebuild clean archive \
 -project RDICU4c/RDICU4c.xcodeproj \
 -scheme RDICU4c-macOS \
 -configuration Release \
 -arch arm64 \
 -arch x86_64 \
 -sdk macosx \
 -archivePath Archive/RDICU4c-macosx.xcarchive \
 DYLIB_COMPATIBILITY_VERSION=${ICU_FRAMEWORK_COMPATIBILITY_VERSION} DYLIB_CURRENT_VERSION=${ICU_FRAMEWORK_VERSION}

echo "-- Building iOS framework"
xcodebuild clean archive \
 -project RDICU4c/RDICU4c.xcodeproj \
 -scheme RDICU4c-iOS \
 -configuration Release \
 -arch arm64 \
 -arch armv7 \
 -arch armv7s \
 -sdk iphoneos \
 -archivePath Archive/RDICU4c-iphoneos.xcarchive \
 DYLIB_COMPATIBILITY_VERSION=${ICU_FRAMEWORK_COMPATIBILITY_VERSION} DYLIB_CURRENT_VERSION=${ICU_FRAMEWORK_VERSION}

echo "-- Building iOS Simulator framework"
xcodebuild clean archive \
 -project RDICU4c/RDICU4c.xcodeproj \
 -scheme RDICU4c-iOS \
 -configuration Release \
 -arch arm64 \
 -arch x86_64 \
 -sdk iphonesimulator \
 -archivePath Archive/RDICU4c-iphonesimulator.xcarchive \
 DYLIB_COMPATIBILITY_VERSION=${ICU_FRAMEWORK_COMPATIBILITY_VERSION} DYLIB_CURRENT_VERSION=${ICU_FRAMEWORK_VERSION}

echo "-- Building Mac Catalyst framework"
xcodebuild clean archive \
 -project RDICU4c/RDICU4c.xcodeproj \
 -scheme RDICU4c-iOS \
 -configuration Release \
 -arch x86_64 \
 -arch arm64 \
 -sdk macosx \
 -archivePath Archive/RDICU4c-maccatalyst.xcarchive \
 SUPPORTS_MACCATALYST=YES DYLIB_COMPATIBILITY_VERSION=${ICU_FRAMEWORK_COMPATIBILITY_VERSION} DYLIB_CURRENT_VERSION=${ICU_FRAMEWORK_VERSION}

echo "-- Creating XCFramework..."
xcodebuild -create-xcframework \
 -framework "Archive/RDICU4c-macosx.xcarchive/Products/Library/Frameworks/RDICU4c.framework" \
 -framework "Archive/RDICU4c-iphoneos.xcarchive/Products/Library/Frameworks/RDICU4c.framework" \
 -framework "Archive/RDICU4c-iphonesimulator.xcarchive/Products/Library/Frameworks/RDICU4c.framework" \
 -framework "Archive/RDICU4c-maccatalyst.xcarchive/Products/Library/Frameworks/RDICU4c.framework" \
 -output "XCFramework/RDICU4c.xcframework"