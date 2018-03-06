#!/bin/sh

# Organization: MDIBL
# Author: Lucie Hutchins
# Date: February 2018
#
## Script is called by /runGetPackage.sh  main script
# to build and install a new package
#
# Usage: ./install_package TOOL_NAME
# Where TOOL_NAME is the name of the base directory for this package
# as defined in the variable SHORT_NAME in the tool config file
#
# Example : ./install_package bamtools 
# Different versions of bamtools will be installed under 
# EXTERNAL_SOFTWARE_BASE/bamtools  
# the file EXTERNAL_SOFTWARE_BASE/bamtools/current_release_NUMBER stores
# the latest release number for this tool
#
# Note: This script expects the following
# env variables set by the caller
# GLOBAL_CONFIG
# PACKAGE_DEPENDS
# PACKAGE_BASE
# 
# What it does:
# ----------------
# 1) Runs the dependency test
# 2) Calls the tool's install script
# 3) Runs the Install check

cd `dirname $0`

SCRIPT_NAME=`basename $0`
WORKING_DIR=`pwd`

if [ $# -lt 1 ]
then
  echo "Usage: ./${SCRIPT_NAME} tool_name
  echo "Example: ./${SCRIPT_NAME} bamtools 
  exit 1
fi
TOOL_NAME=$1
if [ -f ${GLOBAL_CONFIG} ]
then
  echo "ERROR: Missing ${GLOBAL_CONFIG} file `pwd` " 
fi

source ./${GLOBAL_CONFIG}

source ./${PACKAGE_DEPENDS}

rstatus=""
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
echo "$rstatus"
if [ "$rstatus" == Failed ]
then
  echo "Dependency test Failed" 
  exit 1
fi
export GLOBAL_CONFIG  PACKAGE_DEPENDS PACKAGE_BASE PACKAGE_CONFIG_FILE 
./${TOOL_NAME}/Install
./${CHECK_INSTALL_SCRIPT}
[ $? -ne 0 ] && exit 1

echo "Install Done" 
exit 0

