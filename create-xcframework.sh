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
 -library "mac/fat-lib-macosx/libicu.a" -headers "${MAC_INSTALL_DIR}/include" \
 -library "ios/fat-lib-iphoneos/libicu.a" -headers "${MAC_INSTALL_DIR}/include" \
 -library "ios/fat-lib-iphonesimulator/libicu.a" -headers "${MAC_INSTALL_DIR}/include" \
 -library "ios/fat-lib-macosx/libicu.a" -headers "${MAC_INSTALL_DIR}/include" \
 -output "XCFramework/Static/icu.xcframework"

ICU_FRAMEWORK_VERSION=${ICU_VERSION_MAJOR}.${ICU_VERSION_MINOR}
ICU_FRAMEWORK_COMPATIBILITY_VERSION=${ICU_VERSION_MAJOR}.0

echo "-- Building macOS framework"
xcodebuild archive \
 -project unicode/unicode.xcodeproj \
 -scheme unicode-macOS \
 -configuration Release \
 -arch arm64 \
 -arch x86_64 \
 -sdk macosx \
 -archivePath Archive/unicode-macosx.xcarchive \
 DYLIB_COMPATIBILITY_VERSION=${ICU_FRAMEWORK_COMPATIBILITY_VERSION} DYLIB_CURRENT_VERSION=${ICU_FRAMEWORK_VERSION}

echo "-- Building iOS framework"
xcodebuild archive \
 -project unicode/unicode.xcodeproj \
 -scheme unicode-iOS \
 -configuration Release \
 -arch arm64 \
 -arch armv7 \
 -arch armv7s \
 -sdk iphoneos \
 -archivePath Archive/unicode-iphoneos.xcarchive \
 DYLIB_COMPATIBILITY_VERSION=${ICU_FRAMEWORK_COMPATIBILITY_VERSION} DYLIB_CURRENT_VERSION=${ICU_FRAMEWORK_VERSION}

echo "-- Building iOS Simulator framework"
xcodebuild archive \
 -project unicode/unicode.xcodeproj \
 -scheme unicode-iOS \
 -configuration Release \
 -arch arm64 \
 -arch x86_64 \
 -sdk iphonesimulator \
 -archivePath Archive/unicode-iphonesimulator.xcarchive \
 DYLIB_COMPATIBILITY_VERSION=${ICU_FRAMEWORK_COMPATIBILITY_VERSION} DYLIB_CURRENT_VERSION=${ICU_FRAMEWORK_VERSION}

echo "-- Building Mac Catalyst framework"
xcodebuild archive \
 -project unicode/unicode.xcodeproj \
 -scheme unicode-iOS \
 -configuration Release \
 -arch x86_64 \
 -arch arm64 \
 -sdk macosx \
 -archivePath Archive/unicode-maccatalyst.xcarchive \
 SUPPORTS_MACCATALYST=YES DYLIB_COMPATIBILITY_VERSION=${ICU_FRAMEWORK_COMPATIBILITY_VERSION} DYLIB_CURRENT_VERSION=${ICU_FRAMEWORK_VERSION}

echo "-- Creating XCFramework..."
xcodebuild -create-xcframework \
 -framework "Archive/unicode-macosx.xcarchive/Products/Library/Frameworks/unicode.framework" \
 -framework "Archive/unicode-iphoneos.xcarchive/Products/Library/Frameworks/unicode.framework" \
 -framework "Archive/unicode-iphonesimulator.xcarchive/Products/Library/Frameworks/unicode.framework" \
 -framework "Archive/unicode-maccatalyst.xcarchive/Products/Library/Frameworks/unicode.framework" \
 -output "XCFramework/icu.xcframework"

echo "-- Compressing XCFramework..."
cd XCFramework
zip -ry icu${ICU_VERSION_MAJOR}-${ICU_VERSION_MINOR}-darwin-xcframework-dynamic.zip icu.xcframework 
cd Static
zip -ry ../icu${ICU_VERSION_MAJOR}-${ICU_VERSION_MINOR}-darwin-xcframework-static.zip icu.xcframework 
cd ../..

echo "-- Done"
