#!/bin/sh

# Organization: MDIBL
# Author: Lucie Hutchins
# Date:  March 2018
#
# Wrapper script to call getToolVersion.sh/setToolVersion.sh and runGetPackage.sh scripts
# To download and install the current version of the tool.
# If a second argument is specified, then it's used as the version
# to install
# 
#
# What it does:
# 1) sources global configs
# 2) Calls the appropriate getToolVersion.sh/setToolVersion.sh to update the release flag file
# 3) Check if the specifide tool version is installed
# 4) Trigger the install if the specified tool's version is not installed
#

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
  echo "***********************************************"
  echo ""
  echo "Usage: ./${SCRIPT_NAME} tool_name [tool_version]"
  echo ""
  echo "Example: ./${SCRIPT_NAME} bamtools [v2.5.1]"
  echo ""
  echo "A trigger that calls scripts involved in the download and install of a new package."
  echo "If a second argument is specified,then it's used as the version to install."
  echo "It triggers the install only if the specified tool version is not installed."
  echo ""
  echo "NOTE: If you provide the tool_version argument, "
  echo "make sure the format follows the pattern specified in REPOS_TAG_PATTERN variable "
  echo "in the tool's config file (*_package.cfg)"
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


