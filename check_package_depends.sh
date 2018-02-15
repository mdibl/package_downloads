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

if [ "${PACKAGE_DEPENDS}"=""]
then
    echo "ERROR: global environment PACKAGE_DEPENDS not set " 
    exit 1
fi
if [ ! -f ${PACKAGE_DEPENDS} ]
then
    echo "ERROR: ${PACKAGE_DEPENDS} missing from `pwd`"
    exit 1
fi
echo "Running the dependency test" 
for dependency in $BIN_DEPENDENCIES
do
    token=`which ${dependency}`
    if [ ! -f "${token}" ]
    then
       echo "ERROR: Dependency ${dependency} missing"
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
      echo "ERROR: Dependency  ${lib_path} missing" 
      rstatus="Failed"
    fi
  done
done
echo "==" 
if [ "$rstatus" == Failed ]
then
  echo "Dependency test Failed" 
  exit 1
fi
exit 0
