#!/bin/sh

if [ $# -lt 2 ] ; then
    echo "usage : `basename $0` v1.0.0";
    exit -1
fi

TAG=$1

echo "Have you updated the changelog ? (ctrl-c to go update it)"
read

set -e

carthage build --no-skip-current && carthage archive SwiftiumKit

echo "Creating tag $TAG and pushing it to github"
git tag -a $TAG
git push --tags

echo "You can now upload SwiftiumKit.framework.zip and edit release notes from https://github.com/openium/SwiftiumKit/releases/edit/$TAG"

