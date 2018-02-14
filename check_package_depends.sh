#!/bin/sh

# Organization: MDIBL
# Author: Lucie Hutchins
# Date: February 2018
#
## Script is called by the Install script 
#  to run the dependency test 
#
# Usage: ./install_check_depends
#
# Assuming all global environment variables needed have
# been set by the parent process
#
cd `dirname $0`
SCRIPT_NAME=`basename $0`
WORKING_DIR=`pwd`
rstatus=""
echo "==" | tee -a ${LOG_FILE}
echo "Running the dependency test" | tee -a ${LOG_FILE}
for dependency in $BIN_DEPENDENCIES
do
    token=`which ${dependency}`
    if [ ! -f "${token}" ]
    then
       echo "ERROR: Dependency ${dependency} missing" | tee -a ${LOG_FILE}
       rstatus="Failed"
    fi
done
# Check LIBRARY dependencies
for dependency in $LIB_DEPENDENCIES
do
  tokens=`locate $dependency`
  for lib_path in $tokens
  do
    if [ ! -f ${lib_path} ]
    then
      echo "ERROR: Dependency  ${lib_path} missing" | tee -a $LOG_FILE
      rstatus="Failed"
    fi
  done
done
echo "==" | tee -a ${LOG_FILE}
if [ "$rstatus" == Failed ]
then
  echo "Dependency test Failed" | tee -a ${LOG_FILE}
  exit 1
fi
exit 0
