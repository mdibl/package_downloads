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
  echo "Example: ./$SCRIPT_NAME blat/blat.cfg"
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
echo "Start Date:"`date` | tee -a $LOG
echo "$SHORT_NAME Release: $RELEASE_NUMBER"  | tee -a $LOG
echo "Remote site: $REMOTE_SITE"  | tee -a $LOG
echo "Remote directory: $REMOTE_DIR"  | tee -a $LOG
echo "Local directory: $LOCAL_DIR" | tee -a $LOG 
echo "==" | tee -a $LOG
echo "Remote files:" | tee -a $LOG
echo " $REMOTE_FILES" | tee -a $LOG
echo "==" | tee -a $LOG
echo "Running script from: $WORKING_DIR"| tee -a $LOG
echo "Command: ./$DOWNLOAD_SCRIPT $PACK_CONFIG"| tee -a $LOG
echo "==" | tee -a $LOG

./$DOWNLOAD_SCRIPT $PACK_CONFIG   2>&1 | tee -a $LOG

echo "=="
if [ $? -ne 0 ]
then
  echo "Status: FAILED" | tee -a $LOG
  exit 1
fi
echo "Status: SUCCESS" | tee -a $LOG
echo "=="
echo "End Date:"`date` | tee -a $LOG
echo ""
exit 0
