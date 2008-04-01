#!/bin/bash -e

if [ $# -eq 0 ]
then
 echo "usage: update-version.sh [old version] [new version]"
 exit 1
fi


ROOT=$(cd $(dirname $0); pwd)/..
if [ $# -eq 0 ]
then
 OLD_VERSION=`grep Bundle-Version $ROOT/org.eclipse.mylyn/META-INF/MANIFEST.MF | sed 's/Bundle-Version: //' | sed 's/.qualifier//'`
 NEW_VERSION=$1
else
 OLD_VERSION=$1
 NEW_VERSION=$2
fi

echo renaming version from $OLD_VERSION to $NEW_VERSION

echo processing MAINFEST.MF files...
find $ROOT/org.eclipse.mylyn* -name MANIFEST.MF -not -path org.eclipse.mylyn.releng | xargs sed -i "s/${OLD_VERSION}\.qualifier/${NEW_VERSION}.qualifier/"

echo processing feature.xml files...
find $ROOT/org.eclipse.mylyn* -name feature.xml -not -path org.eclipse.mylyn.releng | xargs sed -i "s/${OLD_VERSION}\.qualifier/${NEW_VERSION}.qualifier/"

echo done