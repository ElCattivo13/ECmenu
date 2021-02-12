#!/bin/echo Run: source

# tool versions
VERSION_JAVA="1.8.0-openjdk-1.8.0.242-1.b08"
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

TOOLCHAIN_WIN_PATH="$( cygpath -w ${TOOLCHAIN_DIR} )"
# echo "Toolchain dir is ${TOOLCHAIN_WIN_PATH}"