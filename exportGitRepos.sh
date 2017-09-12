#!/bin/sh

# Organization: MDIBL
# Author: Lucie Hutchins
# Date: September 2017
#
# This script export git repos 

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

PACKAGE_INSTALL_BASE="$EXTERNAL_SOFTWARE_BASE/$SHORT_NAME"
release_flag=${PACKAGE_INSTALL_BASE}/$CURRENT_RELEASE_FLAG

if [ ! -f $release_flag ]
then
   echo "File $release_flag does not exists"
   exit 1
fi
if [ ! -f $EXPORT_REPOS_SCRIPT ]
then
   echo "File $EXPORT_REPOS_SCRIPT does not exists"
   exit 1
fi
RELEASE_NUMBER=`cat $release_flag`
LOG_FILE="${DOWNLOADS_LOG_DIR}/$SCRIPT_NAME.$SHORT_NAME.$RELEASE_NUMBER.log"

rm -rf $LOG_FILE
touch $LOG_FILE

echo "==" | tee -a $LOG_FILE
echo "Start Date:"`date` | tee -a $LOG_FILE
echo "$SHORT_NAME Release: $RELEASE_NUMBER"  | tee -a $LOG_FILE
echo "Path to Local install: $PACKAGE_INSTALL_BASE" | tee -a $LOG_FILE
echo "Git Organization:$GIT_ORG" | tee -a $LOG_FILE
echo "Git Repos:$GIT_REPOS" | tee -a $LOG_FILE
echo "Git repos url: $GIT_DOWNLOADS_URL_BASE" | tee -a $LOG_FILE
echo "==" | tee -a $LOG_FILE

if [ ! -d $PACKAGE_INSTALL_BASE ]
then
  mkdir -p $PACKAGE_INSTALL_BASE
fi
TOP=`pwd`

$EXPORT_REPOS_SCRIPT $GIT_ORG $GIT_REPOS $RELEASE_NUMBER $PACKAGE_INSTALL_BASE
cd $TOP

echo "Current Release Number:$RELEASE_NUMBER"| tee -a $LOG_FILE
echo ""| tee -a $LOG_FILE
echo "Program complete"| tee -a $LOG_FILE

exit 0
