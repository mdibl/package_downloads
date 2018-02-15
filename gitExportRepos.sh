#!/bin/sh

#This script exports tags from public git repositories
#
# Assumption: None
#
# Input:
#   1) Owner/Organization name
#   2) Repository name
#   3) Tag
#   4) Install path
#
# What it does:
#    1) Set path to git tag
#    2) wget repos tag 
#    3) Create local directory for the new tag
#    4) Untar new tag tar 
#    5) Remove the downloaded tar file
#
# Author: lnh
# Date : 8/1/2017
# Modification Date : February/2018
#

WGET=`which wget`
TAR=`which tar`

#setup the log file
SCRIPT_NAME=`basename $0`
TOP=`dirname $0`
WORKING_DIR=`realpath $TOP`
#Check the number of arguments
if [ $# -lt 4 ]
then
  echo ""
  echo "***********************************************"
  echo "Bad usage ---"
  echo "Usage: ./$SCRIPT_NAME ORGANIZATION/OWNER REPO_NAME GIT_TAG INSTALL_DIR"
  echo "Example1: ./$SCRIPT_NAME mdibl data_downloads  v1.1.0 /usr/local/biocore"
  echo "Example1: ./$SCRIPT_NAME mdibl biocore_misc  master /usr/local/biocore/admin"
  echo ""
  echo "***********************************************"
  echo ""
  exit 1
fi
##
ORG=$1
REPO=$2
TAG=$3
INSTALL_DIR=$4

#Url to private repository
GIT_URL=https://api.github.com/repos/$ORG/$REPO/tarball/$TAG
#Local tag directory
tag_base=`basename $TAG`
TAG_DIR=$REPO-$tag_base
LOG_DIR=$WORKING_DIR/logs

if [ ! -d $LOG_DIR ]
then
   mkdir $LOG_DIR
fi

LOG=$LOG_DIR/$SCRIPT_NAME.$TAG_DIR.log
rm -f $LOG
touch $LOG

#Results tar file
TAG_TAR_FILE=$TAG_DIR.tar.gz

date | tee -a $LOG
echo "The path to logs is $LOG_DIR" | tee -a $LOG
echo "wget path: $WGET" | tee -a $LOG
echo "tar path: $TAR"| tee -a $LOG
echo "Tag: $TAG"| tee -a $LOG
echo "Repository: $REPO"| tee -a $LOG
echo "Organization: $ORG"| tee -a $LOG
echo "Git url: $GIT_URL"| tee -a $LOG
echo "This product will be installed under: $INSTALL_DIR" | tee -a $LOG

date | tee -a $LOG

cd $INSTALL_DIR
#clean previous download of this tag
if [ -d $TAG_DIR ]
then
   echo "The tag $TAG_DIR is already installed under $INSTALL_DIR"
   if [ -d $TAG_DIR.old ]
   then 
      rm -rf $TAG_DIR.old
   fi
   mv $TAG_DIR $TAG_DIR.old
fi
#execute the command
echo Cammand: $WGET -O $TAG_TAR_FILE  "$GIT_URL" | tee -a $LOG
$WGET -O $TAG_TAR_FILE  "$GIT_URL"  2>&1 | tee -a $LOG

#Create local directory for this tag
mkdir $TAG_DIR

#Untar the new archive
echo "Untar $TAG_TAR_FILE" | tee -a $LOG
echo "Command: $TAR -xzvf $TAG_TAR_FILE -C $TAG_DIR --strip-components 1"
$TAR -xzvf $TAG_TAR_FILE -C $TAG_DIR --strip-components 1

#Remove the tar file
rm -f $TAG_TAR_FILE
date
echo "Program complete"
exit 0
