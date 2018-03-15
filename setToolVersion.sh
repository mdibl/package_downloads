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
PREVIOUS_RELEASE=""
## set release number to current value in ${RELEASE_FILE}
[ -f ${RELEASE_FILE} ] &&  RELEASE_NUMBER=`cat ${RELEASE_FILE}`

date | tee -a ${LOG_FILE}
echo "**********              *******************" | tee -a ${LOG_FILE}
echo " Setting ${TOOL_NAME}'s Release to "| tee -a ${LOG_FILE}
echo "**********  *******************************"| tee -a ${LOG_FILE}

echo ""| tee -a ${LOG_FILE}
echo "The current version info is stored in  ${RELEASE_FILE}"| tee -a ${LOG_FILE}

RELEASE_NUMBER=`echo $RELEASE_NUMBER | sed -e 's/[[:space:]]*$//' | sed -e 's/^[[:space:]]*//'`

## Create the current release Number file
echo "${TOOL_NAME} release: ${RELEASE_NUMBER} "
echo "Updating ${RELEASE_FILE} with version:${RELEASE_NUMBER}"

echo "Current Release Number:${RELEASE_NUMBER}"| tee -a ${LOG_FILE}
echo ""| tee -a ${LOG_FILE}
echo "Program complete"| tee -a ${LOG_FILE}
exit 0
