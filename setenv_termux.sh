#!/bin/echo Run: source

# tool versions
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

# TODO only install wget if necessary
echo "Installing wget"
pkg install wget;

# TODO only install java if necessary, current if-clause is not working
if [ ! -x java ] ;
then
    wget https://raw.githubusercontent.com/MasterDevX/java/master/installjava && bash installjava
fi

echo $JAVA_HOME
java -version
# the name of the java tool directory
#JAVA_DIR_NAME="jdk-${VERSION_JAVA}-ojdkbuild-linux-armhf"
# the absolute path of the java tool directory
#JAVA_DIR="${TOOLCHAIN_DIR}/${JAVA_DIR_NAME}"

# call to download java
# if [ ! -d "${JAVA_DIR}" ] ;
# then
#     echo "Downloading Java v1.${VERSION_JAVA} ..."
#     JAVA_ZIP="${JAVA_DIR}.zip"
#     JAVA_URL="https://github.com/ojdkbuild/contrib_jdk8u-aarch32-ci/releases/download/jdk${VERSION_JAVA}-b01-arch32-20201109/${JAVA_DIR_NAME}.zip"
#     curl --progress-bar -L -o "${JAVA_ZIP}" "${JAVA_URL}" || { echo "Failed to download java" ; return 20 ; } ;

#     echo "Unpacking ..."
#     # the zip already contains a directory, so simply extract it in the toolchain dir
#     unzip -q -d "${TOOLCHAIN_DIR}" "${JAVA_ZIP}" || { echo "Failed to unpack java" ; return 21 ; } ;
# #    rm "${JAVA_ZIP}" || { echo "Failed to delete temporary java zip" ; } ;
    
#     echo "Done."
#     echo
# fi

# # set java home
# export JAVA_HOME="${JAVA_DIR}"
# # and prepend it to the path
# export PATH="${JAVA_HOME}/bin:${PATH}"

# the name of the maven tool directory
MAVEN_DIR_NAME="apache-maven-${VERSION_MAVEN}"
# the absolute path of the maven tool directory
MAVEN_DIR="${TOOLCHAIN_DIR}/${MAVEN_DIR_NAME}"

# call to download maven
if [ ! -d "${MAVEN_DIR}" ] ;
then
    echo "Downloading Apache Maven v${VERSION_MAVEN} ..."
    MAVEN_ZIP="${MAVEN_DIR}.zip"
    MAVEN_URL="https://downloads.apache.org/maven/maven-3/${VERSION_MAVEN}/binaries/apache-maven-${VERSION_MAVEN}-bin.zip"
    curl --progress-bar -o "${MAVEN_ZIP}" "${MAVEN_URL}" || { echo "Failed to download maven" ; return 30 ; } ;

    echo "Unpacking ..."
    # the zip already contains a directory, so simply extract it in the toolchain dir
    unzip -q -d "${TOOLCHAIN_DIR}" "${MAVEN_ZIP}" || { echo "Failed to unpack maven" ; return 31 ; } ;
    rm "${MAVEN_ZIP}" || { echo "Failed to delete temporary maven zip" ; } ;

    echo "Done."
    echo
fi

# add maven to the path
export PATH="${MAVEN_DIR}/bin/:${PATH}"
# remove deprecated env vars
unset M2_HOME MVN_HOME MAVEN_HOME

