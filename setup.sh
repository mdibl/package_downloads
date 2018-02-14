#!/bin/sh

#
# Organization: MDIBL
# Author: Lucie Hutchins
# Date: September 2017
#
# Install
#

cd `dirname $0`

pwd

if [ -f Configuration ]
then
  rm Configuration
fi
cp Configuration.default Configuration

. ./Configuration

EXECUTABLES=`ls | grep .sh`
for script_name in ${EXECUTABLES}
do
  echo "Processing: $script_name"
done


if [ ! -d ${DOWNLOADS_LOG_DIR} ]
then
    mkdir ${DOWNLOADS_LOG_DIR}
fi
