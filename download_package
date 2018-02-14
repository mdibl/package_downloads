#!/bin/sh

# Organization: MDIBL
# Author: Lucie Hutchins
# Date: September 2017
#
#Wrapper script to download a given package from its download site 
# It creates an additional log that could be use later on
#
cd `dirname $0`
WORKING_DIR=`pwd`
SCRIPT_NAME=`basename $0`
DATE=`date +"%B %d %Y"`
DATE=`echo $DATE | sed -e 's/[[:space:]]/-/g'`

WGET=`which wget`

if [ $# -lt 1 ]
then
  echo "Usage: ./$SCRIPT_NAME path2annotation_config"
  echo "Example: ./$SCRIPT_NAME jenkins/jenkins.cfg"
  exit 1
fi
#
#Relative to current working directory
#
PACKAGE_CONFIG=$1
MAIN_CONFIG=Configuration

if [ ! -f $MAIN_CONFIG ]
then
  echo "$MAIN_CONFIG file missing "     
  exit 1
fi
if [ ! -f $PACKAGE_CONFIG ]
then
  echo "'$PACKAGE_CONFIG' file missing "     
  exit 1
fi

# get global environment variable from config files
#
source ./$MAIN_CONFIG
source ./$PACKAGE_CONFIG

LOCAL_DIR=${EXTERNAL_SOFTWARE_BASE}/${SHORT_NAME}
LOG=$DOWNLOADS_LOG_DIR/$SCRIPT_NAME.$SHORT_NAME.$DATE.log
WGET_COMMAND="$WGET_OPTIONS '$REMOTE_URL'"
rm -f $LOG
touch $LOG
#
# Set path of files on local server
#
if [ "$LOCAL_DIR" = "" ]
then
    echo "LOCAL_DIR not defined in  $PACKAGE_CONFIG "  | tee -a $LOG   
    exit 1
fi

echo "==" | tee -a $LOG
echo "Start Date:"`date` | tee -a $LOG
echo "Package: $SHORT_NAME"  | tee -a $LOG
echo "Remote site: $REMOTE_SITE"  | tee -a $LOG
echo "Remote directory: $REMOTE_DIR"  | tee -a $LOG
echo "Remote files: $REMOTE_FILES"  | tee -a $LOG
echo "Remote url: $REMOTE_URL" | tee -a $LOG
echo "==" | tee -a $LOG
echo "Local directory: $LOCAL_DIR" | tee -a $LOG 
echo "==" | tee -a $LOG
echo "Running $SCRIPT_NAME from: $WORKING_DIR"| tee -a $LOG

[ ! -d $LOCAL_DIR ] && mkdir --parents $LOCAL_DIR
if [ $is_xml_query ]
then
   ##don't do the loop if this is a xml query string
   target_file="$REMOTE_SITE$REMOTE_DIR/${REMOTE_FILES}"
   echo "---- $WGET $WGET_OPTIONS $target_file" | tee -a  ${LOG}
   cd ${LOCAL_DIR}
   $WGET -a ${LOG} $WGET_OPTIONS "$target_file"
else
(
set -f
for remote_file in ${REMOTE_FILES}
do
   echo "Downloading $remote_file"
   target_file="$REMOTE_SITE$REMOTE_DIR/$remote_file"
   echo "Downloading $target_file"
   ## get the directory part from the remote_file name
   target_local_dir=`dirname $remote_file`
   #
   # Make parent directories as needed
   if [ "$target_local_dir" != "" ]
   then
       if [ "$NO_LOCAL_PARENT_DIR" = true ]
       then 
           target_local_dir=""
       else
           echo "Creating ${LOCAL_DIR}/$target_local_dir"
           mkdir -p ${LOCAL_DIR}/$target_local_dir
       fi
   fi
   #cd to LOCAL_DOWNLOAD_BASE and run wget command 
   cd ${LOCAL_DIR}/$target_local_dir 
   # delete local files as needed
   if [ "$do_deletes" = true ]
   then
       rm -f $remote_file
   fi
   if [ "$IS_HTTP_PATTERN" = true ]
   then
       $WGET -a ${LOG} $WGET_OPTIONS -A "$remote_file" "$REMOTE_SITE$REMOTE_DIR/" 
    else
      echo "Running command: $WGET -a ${LOG} $WGET_OPTIONS $target_file "
       $WGET  $WGET_OPTIONS $target_file 2>&1 | tee -a ${LOG}
    fi
 done
 )
 fi
 
echo "End Date:"`date` | tee -a $LOG
echo "==" | tee -a $LOG
echo ""
exit 0
