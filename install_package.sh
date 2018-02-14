#!/bin/sh

# Organization: MDIBL
# Author: Lucie Hutchins
# Date: February 2018
#
## Script to build and install a new package
#
# Usage: ./path2/Install tool_name
# Where tool_name is the name of the base directory for this tool
# as defined in the variable SHORT_NAME in the tool config file
#
# Example : ./install_package bamtools 
# Different versions of bamtools will be installed under 
# EXTERNAL_SOFTWARE_BASE/bamtools and the current version 
# installed is stored in  EXTERNAL_SOFTWARE_BASE/bamtools/current_release_NUMBER
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
source ./${CHECK_DEPENDS_SCRIPT} ${TOOL_NAME}
[ $? -ne 0 ] && exit 1
source ./${TOOL_NAME}/Install
source ./${CHECK_INSTALL_SCRIPT}
[ $? -ne 0 ] && exit 1
exit 0



