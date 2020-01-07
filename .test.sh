#!/bin/sh

swift package generate-xcodeproj

xcodebuild test -scheme SwiftiumKit-Package -destination OS=latest,name="iPad Air" | xcpretty

exit $?
