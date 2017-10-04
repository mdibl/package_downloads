#!/bin/sh

# Organization: MDIBL
# Author: Lucie Hutchins
# Date: September 2017
#
# Goal: Install a new version of the package locally
#
# This script does the following:
# 1) export git repos
# 2) runs the install script  
#
# Input: package_config_file

cd `dirname $0`

SCRIPT_NAME=`basename $0`
WORKING_DIR=`pwd`
RELEASE_NUMBER=0
CURRENT_RELEASE_FLAG=current_release_NUMBER

GIT=`which git`

if [ ! -f $GIT ]
then
   echo "Git not installed on this server:"`uname -n`
   exit 1
fi

if [ $# -lt 1 ]
then 
  echo "Usage: ./$SCRIPT_NAME package_name/package_name_repos.cfg"
  echo "Example: ./$SCRIPT_NAME bedtools/bedtools_repos.cfg"
  exit 1
fi
if [ ! -f Configuration ]
then
  echo "'Configuration' file missing "     
  exit 1
fi
if [ ! -f $1 ]
then
  echo "'$1' file missing"     
  exit 1
fi

source ./Configuration
source ./$1

release_flag=${LOCAL_DIR}/$CURRENT_RELEASE_FLAG
if [ ! -f $release_flag ]
then
   echo "File $release_flag does not exists"
   exit 1
fi
TOP=`pwd`
RELEASE_NUMBER=`cat ${LOCAL_DIR}/$CURRENT_RELEASE_FLAG`
LOG_FILE="${DOWNLOADS_LOG_DIR}/$SCRIPT_NAME.$SHORT_NAME.$RELEASE_NUMBER.log"
INSTALL_SCRIPT_BASE=$TOP/$SHORT_NAME

if [ ! -f $EXPORT_REPOS_SCRIPT ]
then
   echo "File $EXPORT_REPOS_SCRIPT does not exists"
   exit 1
fi

rm -rf $LOG_FILE
touch $LOG_FILE
echo "==" | tee -a $LOG_FILE
echo "Start Date:"`date` | tee -a $LOG_FILE
echo "$SHORT_NAME Release: $RELEASE_NUMBER"  | tee -a $LOG_FILE
echo "Local path to package install: ${LOCAL_DIR}" | tee -a $LOG_FILE
echo "Git Organization:$GIT_ORG" | tee -a $LOG_FILE
echo "Git Repos:$GIT_REPOS" | tee -a $LOG_FILE
echo "Git repos url: $GIT_DOWNLOADS_URL_BASE" | tee -a $LOG_FILE
echo "==" | tee -a $LOG_FILE
echo "Running git export:" | tee -a $LOG_FILE

if [ ! -d $LOCAL_DIR ]
then
  mkdir -p $LOCAL_DIR
fi

echo "Command: $EXPORT_REPOS_SCRIPT $GIT_ORG $GIT_REPOS $RELEASE_NUMBER $LOCAL_DIR 2>&1" | tee -a $LOG_FILE
$EXPORT_REPOS_SCRIPT $GIT_ORG $GIT_REPOS $RELEASE_NUMBER $LOCAL_DIR 2>&1 | tee -a $LOG_FILE

if [ $? -ne 0 ]
then
   echo "Command: $EXPORT_REPOS_SCRIPT $GIT_ORG $GIT_REPOS $RELEASE_NUMBER $LOCAL_DIR  FAILED"
   exit 1
fi
echo "Export ended:"`date` | tee -a $LOG_FILE
echo "==" | tee -a $LOG_FILE
echo "Installing $SHORT_NAME-$RELEASE_NUMBER" | tee -a $LOG_FILE
echo "Running  $INSTALL_SCRIPT_BASE/Install" | tee -a $LOG_FILE
#Run the install script
cd $INSTALL_SCRIPT_BASE
./Install

if [ $? -ne 0 ]
then
   echo "./$INSTALL_SCRIPT_BASE/Install FAILED"
   exit 1
fi
echo "Install ended:"`date` | tee -a $LOG_FILE
echo "==" | tee -a $LOG_FILE
cd $TOP

echo "Current Release Number:$RELEASE_NUMBER"| tee -a $LOG_FILE
echo ""| tee -a $LOG_FILE
echo "Program complete"| tee -a $LOG_FILE

exit 0
