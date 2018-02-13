#!/bin/sh

# Organization: MDIBL
# Author: Lucie Hutchins
# Date: September 2017
#
# Wrapper script to call scripts that download and install a new package
# It creates an additional log that could be use later on
#
cd `dirname $0`
WORKING_DIR=`pwd`
SCRIPT_NAME=`basename $0`
GLOBAL_CONFIG=Configuration

if [ $# -lt 1 ]
then
  echo "Usage: ./${SCRIPT_NAME} tool_name
  echo "Example: ./${SCRIPT_NAME} bamtools 
  exit 1
fi
TOOL_NAME=$1
if [ ! -d ${TOOL_NAME} ]
then
  echo "ERROR: No automation found for ${TOOL_NAME}"
  echo "Check list of available automations under `pwd`"
  echo "Also check the spelling or the case sensitive"
  exit 1
fi
##The config file is relative to
# the root directory of pacakage download 

if [ ! -f ${GLOBAL_CONFIG} ]
then
  echo "'${GLOBAL_CONFIG}' file missing under `pwd`" 
  echo "You must run the setup.sh script first to generate this file"
  echo "Usage: ./setup.sh "
  exit 1
fi
source ./${GLOBAL_CONFIG}
#set path to packages install base
#and get the version to install from the flag file
#
PACKAGE_DOWNLOADS_BASE=${EXTERNAL_SOFTWARE_BASE}/${TOOL_NAME}
RELEASE_FILE=${PACKAGE_DOWNLOADS_BASE}/${CURRENT_FLAG_FILE}
if [ ! -f ${RELEASE_FILE} ]
then
   echo "ERROR: ${RELEASE_FILE} file missing"
   exit 1
fi
RELEASE_NUMBER=`cat ${RELEASE_FILE}`
PACKAGE_CONFIG_FILE=${TOOL_NAME}/${TOOL_NAME}${PACKAGE_CONFIGFILE_SUFFIX}
PACKAGE_DEPENDS=${TOOL_NAME}/${PACKAGE_DEPENDENCIES_FILE}

if [ ! -f ${PACKAGE_CONFIG_FILE} ]
then
    echo "ERROR: missing "
fi
[ -f source ./${PACKAGE_DEPENDENCIES_FILE}
source ./${PACKAGE_CONFIG_FILE}

LOG=$DOWNLOADS_LOG_DIR/$SCRIPT_NAME.$TOOL_NAME.$RELEASE_NUMBER.log
rm -f $LOG
touch $LOG
echo "==" | tee -a $LOG
echo "Package: $TOOL_NAME"  | tee -a $LOG
echo "Version: $RELEASE_NUMBER"  | tee -a $LOG
echo "Remote site: $REMOTE_SITE"  | tee -a $LOG
echo "Remote directory: $REMOTE_DIR"  | tee -a $LOG
echo "Install directory: ${PACKAGE_DOWNLOADS_BASE}" | tee -a $LOG
echo "Path to Install logs: ${DOWNLOADS_LOG_DIR}" | tee -a $LOG
echo "Install Date:"`date` | tee -a $LOG
echo "Git Organization:$GIT_ORG" | tee -a $LOG
echo "Git Repos:$GIT_REPOS" | tee -a $LOG
echo "Remote files:" | tee -a $LOG
echo " $REMOTE_FILES" | tee -a $LOG
echo "==" | tee -a $LOG
echo "Running script from: $WORKING_DIR"| tee -a $LOG
echo "Command: ./$DOWNLOAD_SCRIPT $PACK_CONFIG"| tee -a $LOG
echo "==" | tee -a $LOG
#
##We don't need to download files - case of cutadapt
#
if [ "$NO_DOWNLOAD" = true ]
then
    mkdir -p $EXTERNAL_SOFTWARE_BASE/$SHORT_NAME/${RELEASE_DIR}
else
    ./$DOWNLOAD_SCRIPT $PACK_CONFIG   2>&1 | tee -a $LOG
fi
echo "=="
cd $EXTERNAL_SOFTWARE_BASE/$SHORT_NAME

## The zip file was downloaded under $EXTERNAL_SOFTWARE_BASE/$SHORT_NAME
if [ "$NO_LOCAL_PARENT_DIR" = true ]
then
   REMOTE_FILES=`basename $REMOTE_FILES`
fi
if [ "$local_untar_dir" != "" ]
then
   [ "$is_tar" = true ] && mkdir --parent $untar_dir
fi
if [ "$untar_flag" = true ]
then
   echo "Untar: $untar_prog $REMOTE_FILES $local_untar_dir From: "`pwd`
   [ -f $REMOTE_FILES ] && $untar_prog $REMOTE_FILES $local_untar_dir
fi
#Check if this release directory was created

if [ ! -d ${RELEASE_DIR} ]
then
   echo "Download failed: missing ${RELEASE_DIR}"
   exit 1
fi
# Update symbolic link of this package to point to
# the downloaded version
#
rm -f $SHORT_NAME
ln -s ${RELEASE_DIR} $SHORT_NAME
[ -f $REMOTE_FILES ] && rm -f $REMOTE_FILES 
####
cd $WORKING_DIR
#Check the install
if [ -f $SHORT_NAME/Install ]
then
   cd $SHORT_NAME
   echo "Running the install script from:"`pwd`
   ./Install
   if [ $? -ne 0 ]
   then
      echo "Status: FAILED" | tee -a $LOG
      exit 1
   fi
   echo "Status: SUCCESS" | tee -a $LOG
fi
echo "=="
echo "End Date:"`date` | tee -a $LOG
echo ""
exit 0