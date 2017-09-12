#!/usr/bin/sh
#
# Organization: MDIBL
# Author: Lucie Hutchins
# Date: September 2017
#
#A simple script that downloads and stores locally the current release
# FOOTER.txt file 
#
# What it does:
#  1) downloads the current release Readme file (FOOTER.txt)
#  2) sets the current release number flag
#
# This will be scheduled on Jenkins to run dailly
#
cd `dirname $0`

SCRIPT_NAME=`basename $0`
WORKING_DIR=`pwd`
README_CONFIG=footer.cfg
DOWNLOAD_SCRIPT=download_package
CURRENT_RELEASE_FLAG=current_release_NUMBER
release_prefix='blat - Standalone BLAT v.'
release_sufix='fast sequence search command line tool'

if [ ! -f ../Configuration ]
then
  echo "'Configuration' file missing "     
  exit 1
fi
if [ ! -f $README_CONFIG ]
then
  echo "'$README_CONFIG' file missing under $README_CONFIG"     
  exit 1
fi

source ../Configuration
source ./$README_CONFIG

readme_config_path="$SHORT_NAME/$README_CONFIG"
SRC_BASE="$EXTERNAL_SOFTWARE_BASE/$SHORT_NAME"
LOG_FILE="${DOWNLOADS_LOG_DIR}/$SCRIPT_NAME.log"

rm -rf $LOG_FILE
touch $LOG_FILE

date | tee -a $LOG_FILE
echo "**********              *******************" | tee -a $LOG_FILE
echo " Checking Current Release Number"| tee -a $LOG_FILE
echo "**********  *******************************"| tee -a $LOG_FILE
echo ""| tee -a $LOG_FILE
echo " LOGS"| tee -a $LOG_FILE
echo "Logs generated by this script are under ${DOWNLOADS_LOG_DIR}"| tee -a $LOG_FILE
echo "Log: $SCRIPT_NAME.log"| tee -a $LOG_FILE
echo "Log: $README_CONFIG.log"| tee -a $LOG_FILE
echo ""| tee -a $LOG_FILE
echo " FILES"| tee -a $LOG_FILE
echo "Downloaded files are under ${SRC_BASE}"| tee -a $LOG_FILE
echo "File to download:$REMOTE_FILES"| tee -a $LOG_FILE
echo "Script :$DOWNLOAD_SCRIPT"| tee -a $LOG_FILE


./../$DOWNLOAD_SCRIPT $readme_config_path 2>&1 | tee -a $LOG_FILE

if [ ! -f ${SRC_BASE}/$REMOTE_FILES ]
then
   echo "Download failed: ${SRC_BASE}/$REMOTE_FILES is missing" 
   exit 1
fi

RELEASE_NUMBER=`head ${SRC_BASE}/$REMOTE_FILES | grep "$release_prefix" |sed "s/$release_prefix//" | sed "s/$release_sufix//"`
RELEASE_NUMBER=`echo $RELEASE_NUMBER | sed -e 's/[[:space:]]*$//' | sed -e 's/^[[:space:]]*//'`

## Create the current release Number file
release_flag=${SRC_BASE}/$CURRENT_RELEASE_FLAG
touch $release_flag
echo "v.$RELEASE_NUMBER" > $release_flag

echo "Current Release Number:$RELEASE_NUMBER"| tee -a $LOG_FILE
echo ""| tee -a $LOG_FILE
echo "Program complete"| tee -a $LOG_FILE


echo "********** System dump *******************"| tee -a $LOG_FILE
echo " ENVIRONMENT VARIABLES DUMP"| tee -a $LOG_FILE
echo "**********  *******************************"| tee -a $LOG_FILE
env | sort | tee -a $LOG_FILE
exit 0
