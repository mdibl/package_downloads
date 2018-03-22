#!/bin/sh

# Organization: MDIBL
# Author: Lucie Hutchins
# Date:  March 2018
#
# Wrapper script to call getToolVersion.sh and runGetPackage.sh scripts
# To download and install the current version of the tool.
# If a second argument is specified, then it's used as the version
# to install
# 
#
# What it does:
# 1) sources global configs
# 2) Calls the appropriate download script to download the specified version of this package 

cd `dirname $0`
WORKING_DIR=`pwd`
SCRIPT_NAME=`basename $0`
GLOBAL_CONFIG=Configuration

function displayTools() {
    echo ""
    echo " List of available tools"
    echo "----------------------------"
    tools="`ls`"
    for tool in ${tools}
    do
       [ -d ${tool} ] && echo " ${tool}"
    done
    echo ""
}

if [ $# -lt 1 ]
then
  echo "Usage: ./${SCRIPT_NAME} tool_name [tool_version]"
  echo "Example: ./${SCRIPT_NAME} bamtools [v2.5.1]"
  displayTools
  exit 1
fi
TOOL_NAME=$1

##The config file is relative to
# the root directory of package download 

if [ ! -f ${GLOBAL_CONFIG} ]
then
  echo "'${GLOBAL_CONFIG}' file missing under `pwd`" 
  echo "You must run the setup.sh script first to generate this file"
  echo "Usage: ./setup.sh "
  exit 1
fi
source ./${GLOBAL_CONFIG}
## Update the release flag file
if [ $# -lt 2 ]
then 
    echo "Running cmd: ./${GET_TOOL_VERSION_SCRIPT} ${TOOL_NAME}  -- from `pwd`"
    ./${GET_TOOL_VERSION_SCRIPT} ${TOOL_NAME}
else
    TOOL_VERSION=$2
    echo "Running cmd:  ./{SET_TOOL_VERSION_SCRIPT}  ${TOOL_NAME} ${TOOL_VERSION}  -- from `pwd` "
    ./${SET_TOOL_VERSION_SCRIPT}  ${TOOL_NAME} ${TOOL_VERSION}
fi
if [ $? -ne 0 ]
then
    echo "Cmd Status: FAILED"
    exit 1
fi

PACKAGE_DOWNLOADS_BASE=${EXTERNAL_SOFTWARE_BASE}/${TOOL_NAME}
RELEASE_FILE=${PACKAGE_DOWNLOADS_BASE}/${CURRENT_FLAG_FILE}
if [ ! -f ${RELEASE_FILE} ]
then
   echo "ERROR: ${RELEASE_FILE} file missing"
   exit 1
fi
RELEASE_NUMBER=`cat ${RELEASE_FILE}`

PACKAGE_CONFIG_FILE=${TOOL_NAME}/${TOOL_NAME}${PACKAGE_CONFIGFILE_SUFFIX}
if [ ! -f ${PACKAGE_CONFIG_FILE} ]
then
  echo "${TOOL_NAME}'S confifiguration file: '${PACKAGE_CONFIG_FILE}' missing under `pwd`" 
  exit 1
fi
#if this version of the tool is already installed, do run run the main install script
source ./${PACKAGE_CONFIG_FILE}
[ -d ${PACKAGE_DOWNLOADS_BASE}/${RELEASE_DIR} ] && exit 1

## Run the main install script to install the version of the tool found in current_release file 
echo "Running cmd: ./${GET_PACKAGE_MAIN_SCRIPT} ${TOOL_NAME}  -- from `pwd`"
./${GET_PACKAGE_MAIN_SCRIPT} ${TOOL_NAME}

if [ $? -ne 0 ]
then
    echo "Cmd Status: FAILED"
    exit 1
fi


