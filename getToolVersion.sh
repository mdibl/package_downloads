#!/usr/bin/sh
#
# Organization: MDIBL
# Author: Lucie Hutchins
# Date: February 2018
#
#A script that downloads and stores locally
# a file containing the current release info.
# Only used for tools with no valid git repos irelease tags
#
# What it does:
#  1) 
#     a. For non git repos releases - downloads the current release Readme file (*.txt, *.html, ...) 
#       from the downloads site - parses it to extract the latest release number
#
#     b. For git repos releases - clones the repos - extract the latest release number
#  2) sets the current release number flag
#
# This can be scheduled on Jenkins to run dailly
#
cd `dirname $0`

SCRIPT_NAME=`basename $0`
WORKING_DIR=`pwd`
GLOBAL_CONFIG=Configuration

function displayTools() {
    echo ""
    echo " List of available tools"
    echo "---------------------------"
    tools="`ls`"
    for tool in ${tools}
    do
       [ -d ${tool} ] && echo " ${tool}"
    done
    echo ""
}

echo "
***************************************
 BIOCORE PACKAGE INSTALL AUTOMATION 
***************************************
"

## Validate usage
if [ $# -lt 1 ]
then
    echo "Usage: ./${SCRIPT_NAME} tool_name"
    echo "example: ./${SCRIPT_NAME} blat"
    displayTools
    exit 1
fi

TOOL_NAME=$1
if [ ! -d ${TOOL_NAME} ]
then
   echo "ERROR: No automation found for ${TOOL_NAME}"
   echo "Check the spelling or the case sensitive"
   displayTools
   exit 1
fi
if [ ! -f ${GLOBAL_CONFIG} ]
then
  echo "ERROR: ${GLOBAL_CONFIG} file missing  under:${WORKING_DIR}"     
  echo "Make sure you run the ./setup.sh script first  under:${WORKING_DIR}"     
  exit 1
fi
source ./${GLOBAL_CONFIG}

#
## Path relative to this script base
PACKAGE_CONFIG_FILE=${TOOL_NAME}/${TOOL_NAME}${PACKAGE_CONFIGFILE_SUFFIX}
if [ ! -f ${PACKAGE_CONFIG_FILE} ]
then
    echo "ERROR: ${PACKAGE_CONFIG_FILE} missing under: ${WORKING_DIR}"
    exit 1
fi
source ./${PACKAGE_CONFIG_FILE}
#
## Path relative to this package install base
PACKAGE_DOWNLOADS_BASE=${EXTERNAL_SOFTWARE_BASE}/${TOOL_NAME}
RELEASE_FILE=${PACKAGE_DOWNLOADS_BASE}/${CURRENT_FLAG_FILE}
[ ! -d ${PACKAGE_DOWNLOADS_BASE} ] && mkdir -p ${PACKAGE_DOWNLOADS_BASE}

## Check if wget is installed 
if [ ! -f ${WGET} ]
then
  echo "Can't use 'wget' command to download some of our packages "
  echo "Wget not installed on `uname -n`"
  exit 1 	
fi
## Check if git is installed 
if [ ! -f ${GIT} ]
then
  echo "Can't use 'git' command to download some of our packages"
  echo "Git not installed on `uname -n`"
  exit 1 	
fi

LOG_FILE="${DOWNLOADS_LOG_DIR}/${SCRIPT_NAME}.${TOOL_NAME}.log"

rm -rf ${LOG_FILE}
touch ${LOG_FILE}

## set release number to current value in ${RELEASE_FILE}
[ -f ${RELEASE_FILE} ] &&  RELEASE_NUMBER=`cat ${RELEASE_FILE}`

date | tee -a ${LOG_FILE}
echo "**********              *******************" | tee -a ${LOG_FILE}
echo " Checking ${TOOL_NAME}'s  Current Release"| tee -a ${LOG_FILE}
echo "**********  *******************************"| tee -a ${LOG_FILE}
echo ""| tee -a ${LOG_FILE}
echo "The current version info is stored in  ${RELEASE_FILE}"| tee -a ${LOG_FILE}

if [ "${CLONE_GIT}" = true ]
then
    #clone repos to get current release tag
    [ ! -d  ${PACKAGE_GIT_CLONE_BASE} ] && mkdir -p ${PACKAGE_GIT_CLONE_BASE}
    cd ${PACKAGE_GIT_CLONE_BASE}
    [ ! -d ${GIT_REPOS} ] && ${GIT} clone  ${REMOTE_VERSION_FILE}
    if [ ! -d ${GIT_REPOS} ]
    then
        echo "${GIT} clone for ${REMOTE_VERSION_FILE} FAILED"| tee -a ${LOG_FILE}
        exit 1
    fi
    cd ${GIT_REPOS}
    ${GIT} pull 2>&1 | tee -a ${LOG_FILE}
    RELEASE_TOKEN=`${GIT} rev-list --tags --max-count=1`
    RELEASE_NUMBER=`${GIT} describe --tags ${RELEASE_TOKEN}`
else
    FILE_TOKEN=`basename ${REMOTE_VERSION_FILE}`
    LOCAL_VERSION_FILE=${PACKAGE_DOWNLOADS_BASE}/${FILE_TOKEN}
    echo "Downloaded files are under ${PACKAGE_DOWNLOADS_BASE}"| tee -a ${LOG_FILE}
    echo "File to download:${REMOTE_VERSION_FILE}"| tee -a ${LOG_FILE}
    echo "Script :$DOWNLOAD_SCRIPT"| tee -a ${LOG_FILE}
    ${WGET}  -O ${LOCAL_VERSION_FILE} ${REMOTE_VERSION_FILE} 2>&1 | tee -a ${LOG_FILE}
    if [ ! -f ${LOCAL_VERSION_FILE} ]
    then
        echo "Download failed: ${LOCAL_VERSION_FILE} is missing" 
        exit 1
    fi
    EXPRESSION="$EXP_PREFIX ${LOCAL_VERSION_FILE}"
    RELEASE_NUMBER=`${EXPRESSION} | grep "${VERSION_PREFIX}" |sed "s/${VERSION_PREFIX}//" `
    [ "${VERSION_SUFFIX}" != "" ] && RELEASE_NUMBER=`echo ${RELEASE_NUMBER} | sed "s/${VERSION_SUFFIX}//"`
fi
RELEASE_NUMBER=`echo $RELEASE_NUMBER | sed -e 's/[[:space:]]*$//' | sed -e 's/^[[:space:]]*//'`

## Create the current release Number file
echo "${TOOL_NAME} release: ${RELEASE_NUMBER} "
echo "Updating ${RELEASE_FILE} with version:${RELEASE_NUMBER}"
if [[ ${RELEASE_NUMBER} =~ ${REPOS_TAG_PATTERN} ]]
then
   rm -f ${RELEASE_FILE}
   touch ${RELEASE_FILE}
   echo "${RELEASE_NUMBER}" > ${RELEASE_FILE}
fi
if [ -f ${RELEASE_FILE} ]
then
   RELEASE_NUMBER=`cat ${RELEASE_FILE}`
fi
source ./${PACKAGE_CONFIG_FILE}
echo "Current Release Number:${RELEASE_NUMBER}"| tee -a ${LOG_FILE}
if [ -d ${PACKAGE_DOWNLOADS_BASE}/${RELEASE_DIR} ]
then
    echo "${TOOL_NAME} version $RELEASE_NUMBER is already installed."
    echo "See: ${PACKAGE_DOWNLOADS_BASE}/${RELEASE_DIR} "
    echo " Remove this directory first if you want to re-install this version"
fi
echo ""| tee -a ${LOG_FILE}
echo "Program complete"| tee -a ${LOG_FILE}
exit 0
