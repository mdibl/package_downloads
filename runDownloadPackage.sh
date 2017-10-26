#!/bin/sh

# Organization: MDIBL
# Author: Lucie Hutchins
# Date: September 2017
#
#Wrapper script to call the download script 
# It creates an additional log that could be use later on
#
cd `dirname $0`
WORKING_DIR=`pwd`
SCRIPT_NAME=`basename $0`

if [ $# -lt 1 ]
then
  echo "Usage: ./$SCRIPT_NAME path2package_config"
  echo "Example: ./$SCRIPT_NAME blat/blat_package.cfg"
  exit 1
fi
#
#Relative to current working directory
#
PACK_CONFIG=$1
MAIN_CONFIG=Configuration

if [ ! -f $MAIN_CONFIG ]
then
  echo "$MAIN_CONFIG file missing "     
  exit 1
fi
if [ ! -f $PACK_CONFIG ]
then
  echo "'$PACK_CONFIG' file missing "     
  exit 1
fi

# get global environment variable from config files
#
source ./$MAIN_CONFIG
source ./$PACK_CONFIG

LOG=$DOWNLOADS_LOG_DIR/$SCRIPT_NAME.$SHORT_NAME.$RELEASE_NUMBER.log
rm -f $LOG
touch $LOG
echo "==" | tee -a $LOG
echo "Package: $SHORT_NAME"  | tee -a $LOG
echo "Version: $RELEASE_NUMBER"  | tee -a $LOG
echo "Remote site: $REMOTE_SITE"  | tee -a $LOG
echo "Remote directory: $REMOTE_DIR"  | tee -a $LOG
echo "Install directory: ${LOCAL_DIR}" | tee -a $LOG
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

./$DOWNLOAD_SCRIPT $PACK_CONFIG   2>&1 | tee -a $LOG
echo "=="
cd $EXTERNAL_SOFTWARE_BASE/$SHORT_NAME

if [ "$untar_flag" = true ]
then
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
rm -f $REMOTE_FILES 
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
