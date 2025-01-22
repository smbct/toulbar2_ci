#!/bin/sh

if command -v git >/dev/null 2>&1 && git rev-parse --git-dir >/dev/null 2>&1;
then 
    TB2_NAME="$1" # release toulbar2 as base or parallel (MPI) version
    ROOT=`git rev-parse --show-toplevel`
    cd $ROOT
    FILE=$ROOT/src/ToulbarVersion.hpp
    PCKGVER=$ROOT/src/MyCPackConf.cmake
    VERSION=`git describe --abbrev=0 --tags --always`
    LONG_VERSION=`git describe --tags --always`
    MAJOR=`echo $VERSION| cut -d"." -f1`
    MINOR=`echo $VERSION| cut -d"." -f2`
    PATCH=`echo $VERSION| cut -d"." -f3`
    BRANCH=`git rev-parse --abbrev-ref HEAD`
    CTIME=`date +"%s"`
    HASH=`git log -1 --format=%h`

    git diff --quiet HEAD > /dev/null 2>&1
    if [ $? -ne 0 ]; then
	TAINTED="-tainted"
    fi

    echo "// Cmake generated version" > $FILE
    echo "#define Toulbar_VERSION \"$LONG_VERSION-$BRANCH$TAINTED ($CTIME)\"" >> $FILE

    echo "SET(CPACK_PACKAGE_VERSION \"$VERSION\")" > $PCKGVER
    echo "SET(CPACK_NSIS_DISPLAY_NAME \"$TB2_NAME $VERSION\")" >> $PCKGVER
    echo "SET(CPACK_NSIS_PACKAGE_NAME \"$TB2_NAME $VERSION\")" >> $PCKGVER
    echo "SET(CPACK_PACKAGE_FILE_NAME \"$TB2_NAME-$VERSION-x86_64\")" >> $PCKGVER
    echo "SET(CPACK_PACKAGE_INSTALL_DIRECTORY \"$TB2_NAME $VERSION\")" >> $PCKGVER
    echo "SET(CPACK_PACKAGE_INSTALL_REGISTRY_KEY \"$TB2_NAME $VERSION\")" >> $PCKGVER
    echo "SET(CPACK_PACKAGE_VERSION_MAJOR \"$MAJOR\")" >> $PCKGVER
    echo "SET(CPACK_PACKAGE_VERSION_MINOR \"$MINOR\")" >> $PCKGVER
    echo "SET(CPACK_PACKAGE_VERSION_PATCH \"$PATCH\")" >> $PCKGVER
fi
    
