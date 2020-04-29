#!/bin/sh

swift package generate-xcodeproj

xcodebuild test -scheme SwiftiumKit-Package -destination OS=latest,name="iPad (7th generation)" | xcpretty
XCODEBUILD_RC=$?

rm -rf SwiftiumKit.xcodeproj

exit $XCODEBUILD_RC
