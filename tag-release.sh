#!/bin/sh

if [ $# -lt 1 ] ; then
    echo "usage : $(basename $0) x.y";
    exit -1
fi

TAG=$1

echo "Have you updated the changelog for version $VERSION ? (ctrl-c to go update it)"
read

set -e

echo "Creating tag $TAG and pushing it to github"
git tag $TAG
git push --tags

