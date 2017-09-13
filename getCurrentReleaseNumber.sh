#!/bin/sh

# Organization: MDIBL
# Author: Lucie Hutchins
# Date: September 2017
#
# This script returns the release number

cd `dirname $0`

SCRIPT_NAME=`basename $0`
WORKING_DIR=`pwd`
RELEASE_NUMBER=0

if [ $# -lt 1 ]
then 
  echo "Usage: ./$SCRIPT_NAME package_name/package_name.cfg"
  echo "Example: ./$SCRIPT_NAME blat/blat_package.cfg"
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

RELEASE_BASE=$LOCAL_DIR
CURRENT_RELEASE_FLAG=current_release_NUMBER

if [ -f $RELEASE_BASE/$CURRENT_RELEASE_FLAG ]
then
    cd $RELEASE_BASE
    RELEASE_NUMBER=`cat $CURRENT_RELEASE_FLAG | sed -e 's/[[:space:]]*$//' | sed -e 's/^[[:space:]]*//'`
    #Create symbolic link 'latest' as needed
    RELEASE_DIR=$INSTALL_PREFIX$RELEASE_NUMBER
    if [ -d $RELEASE_DIR ]
    then
        rm -f $SHORT_NAME
        ln -s $RELEASE_DIR $SHORT_NAME
    fi
fi 
echo "$RELEASE_NUMBER"

exit 0




