#!/bin/bash

# Organization: MDIBL
# Author: Lucie Hutchins
# Date: September 2017
#
# This script returns the release number

cd `dirname $0`

SCRIPT_NAME=`basename $0`
WORKING_DIR=`pwd`
RELEASE_NUMBER=0
GIT=`which git`

if [ ! -f $GIT ]
then
   echo "Git not installed on this server:"`uname -n`
   exit 1
fi

if [ $# -lt 1 ]
then 
  echo "Usage: ./$SCRIPT_NAME package_name/package_name_package.cfg"
  echo "Example: ./$SCRIPT_NAME bedtools/bedtools_package.cfg"
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

LOG_FILE="${DOWNLOADS_LOG_DIR}/$SCRIPT_NAME.$SHORT_NAME.log"
PACKAGE_INSTALL_BASE="$EXTERNAL_SOFTWARE_BASE/$SHORT_NAME"
REPOS_URL=$GIT_CLONE_URL_BASE/$GIT_ORG/$GIT_REPOS.git
RELEASE_FILE=${PACKAGE_INSTALL_BASE}/${CURRENT_FLAG_FILE}

rm -rf $LOG_FILE
touch $LOG_FILE
date | tee -a $LOG_FILE
echo "**********              *******************" | tee -a $LOG_FILE
echo " Checking Current Release Number"| tee -a $LOG_FILE
echo "**********  *******************************"| tee -a $LOG_FILE
echo ""| tee -a $LOG_FILE
echo "Path to Local install: $PACKAGE_INSTALL_BASE" | tee -a $LOG_FILE
echo "Git repos base: $PACKAGE_GIT_CLONE_BASE" | tee -a $LOG_FILE
echo "Organization:$GIT_ORG" | tee -a $LOG_FILE
echo "Repos:$GIT_REPOS" | tee -a $LOG_FILE
echo "Git url:$GIT_CLONE_URL_BASE" | tee -a $LOG_FILE
echo "Git repos url: $REPOS_URL" | tee -a $LOG_FILE

if [ ! -d $PACKAGE_GIT_CLONE_BASE ]
then
  mkdir -p $PACKAGE_GIT_CLONE_BASE
fi

if [ ! -d $PACKAGE_INSTALL_BASE ]
then
  mkdir -p $PACKAGE_INSTALL_BASE
fi

cd $PACKAGE_GIT_CLONE_BASE

if [ ! -d $GIT_REPOS ]
then
    echo "Cloning git repos $REPOS_URL " | tee -a $LOG_FILE
    echo "Under: "`pwd` | tee -a $LOG_FILE
    $GIT clone $REPOS_URL 2>&1 | tee -a $LOG_FILE
    if [ ! -d $GIT_REPOS ]
    then
        echo "$GIT clone $REPOS_URL FAILED"| tee -a $LOG_FILE
        exit 1
    fi
fi
cd $GIT_REPOS
$GIT pull 2>&1 | tee -a $LOG_FILE
RELEASE_TOKEN=`$GIT rev-list --tags --max-count=1`
RELEASE_NUMBER=`$GIT describe --tags $RELEASE_TOKEN`

echo "Latest release is: $RELEASE_NUMBER --- Release patter: $REPOS_TAG_PATTERN" | tee -a $LOG_FILE
## Update the current release Number file
# Only if the detected new release is a public release
#

if [[ $RELEASE_NUMBER =~ $REPOS_TAG_PATTERN ]] 
then
   rm -f $RELEASE_FILE
   touch $RELEASE_FILE
   echo "Current pattern match:$RELEASE_NUMBER" | tee -a $LOG_FILE
   echo "$RELEASE_NUMBER" > $RELEASE_FILE
fi
if [ -f $RELEASE_FILE ]
then
   RELEASE_NUMBER=`cat $RELEASE_FILE`
fi
echo "Detected  Release Number:$RELEASE_NUMBER"| tee -a $LOG_FILE
echo ""| tee -a $LOG_FILE
echo "Program complete"| tee -a $LOG_FILE

exit 0
