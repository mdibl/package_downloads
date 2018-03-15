#!/usr/bin/sh
#
# Organization: MDIBL
# Author: Lucie Hutchins
# Date: March 2018
#
# A script that sets the tool's release version
# in the tool's current_release_number file to the value specified by the user
#
# What it does:
#  1) Create a directory for this tool if not exists under EXTERNAL_SOFTWARE_BASE
#  2) sets the current release number to the specified value 
#
# Usage: ./setToolVersion.sh <tool_name> <version>
#   
# This is run on demand
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
if [ $# -lt 2 ]
then
    echo "Usage: ./${SCRIPT_NAME} tool_name tool_version"
    echo "example: ./${SCRIPT_NAME} trimmomatic 0.36"
    displayTools
    exit 1
fi

TOOL_NAME=$1
RELEASE_NUMBER=$2

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
LOG_FILE="${DOWNLOADS_LOG_DIR}/${SCRIPT_NAME}.${TOOL_NAME}.log"

rm -rf ${LOG_FILE}
touch ${LOG_FILE}

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
[ ! -d ${PACKAGE_DOWNLOADS_BASE} ] && mkdir -p ${PACKAGE_DOWNLOADS_BASE}
RELEASE_FILE=${PACKAGE_DOWNLOADS_BASE}/${CURRENT_FLAG_FILE}
PREVIOUS_RELEASE=""
## set release number to current value in ${RELEASE_FILE}
[ -f ${RELEASE_FILE} ] &&  REVIOUS_RELEASE=`cat ${RELEASE_FILE}`

date | tee -a ${LOG_FILE}
echo "**********              *******************" | tee -a ${LOG_FILE}
echo " Setting ${TOOL_NAME}'s Release to ${RELEASE_NUMBER}"| tee -a ${LOG_FILE}
echo " The release flag contained  ${PREVIOUS_RELEASE}"| tee -a ${LOG_FILE}
echo "**********  *******************************"| tee -a ${LOG_FILE}

echo ""| tee -a ${LOG_FILE}
echo "The tool's version info is stored in  ${RELEASE_FILE}"| tee -a ${LOG_FILE}
RELEASE_NUMBER=`echo $RELEASE_NUMBER | sed -e 's/[[:space:]]*$//' | sed -e 's/^[[:space:]]*//'`
echo "Updating ${RELEASE_FILE} with version:${RELEASE_NUMBER}"
if [[ ${RELEASE_NUMBER} =~ ${REPOS_TAG_PATTERN} ]]
then
   rm -f ${RELEASE_FILE}
   touch ${RELEASE_FILE}
   echo "${RELEASE_NUMBER}" > ${RELEASE_FILE}
fi
if [ -d ${PACKAGE_DOWNLOADS_BASE}/${RELEASE_DIR} ]
then
    echo ""
    echo "WARNING:"
    echo "  ${TOOL_NAME} version $RELEASE_NUMBER is already installed."
    echo "   See: ${PACKAGE_DOWNLOADS_BASE}/${RELEASE_DIR} "
    echo "   Remove this directory first if you want to re-install this version"
fi

echo ""| tee -a ${LOG_FILE}
echo "Program complete"| tee -a ${LOG_FILE}
exit 0
