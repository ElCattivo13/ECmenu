#!/bin/echo Run: source

# tool versions
VERSION_JAVA="8u282"
VERSION_MAVEN="3.6.3"
VERSION_NODEJS="12.18.3"
# git-root relative directory, where the toolchain will be "installed"
TOOLCHAIN_DIR="toolchain"

#######################################################################

# the directory, where the script is. the same as the git root
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# make the toolchain directory absolute
TOOLCHAIN_DIR="${DIR}/${TOOLCHAIN_DIR}"

# if needed create the toolchain directory
if [ ! -d "${TOOLCHAIN_DIR}" ] ;
 then
    mkdir -p "${TOOLCHAIN_DIR}" || { echo "Failed to create toolchain dir ${TOOLCHAIN_DIR}" ; return 10 ; }
fi

#TOOLCHAIN_WIN_PATH="$( cygpath -w ${TOOLCHAIN_DIR} )"
# echo "Toolchain dir is ${TOOLCHAIN_DIR}"

# the name of the java tool directory
JAVA_DIR_NAME="jdk-${VERSION_JAVA}-ojdkbuild-linux-x64"
# the absolute path of the java tool directory
JAVA_DIR="${TOOLCHAIN_DIR}/${JAVA_DIR_NAME}"

# call to download java
if [ ! -d "${JAVA_DIR}" ] ;
then
    echo "Downloading Java v1.${VERSION_JAVA} ..."
    JAVA_ZIP="${JAVA_DIR}.zip"
    JAVA_URL="https://github.com/ojdkbuild/contrib_jdk8u-ci/releases/download/jdk${VERSION_JAVA}-b08/${JAVA_DIR_NAME}.zip"
    curl --progress-bar -L -o "${JAVA_ZIP}" "${JAVA_URL}" || { echo "Failed to download java" ; return 20 ; } ;

    echo "Unpacking ..."
    # the zip already contains a directory, so simply extract it in the toolchain dir
    unzip -q -d "${TOOLCHAIN_DIR}" "${JAVA_ZIP}" || { echo "Failed to unpack java" ; return 21 ; } ;
#    rm "${JAVA_ZIP}" || { echo "Failed to delete temporary java zip" ; } ;
    
    echo "Done."
    echo
fi

# set java home
export JAVA_HOME="${JAVA_DIR}"
# and prepend it to the path
export PATH="${JAVA_HOME}/bin:${PATH}"