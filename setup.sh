#!/bin/sh

#
# Organization: MDIBL
# Author: Lucie Hutchins
# Date: September 2017
#
# Install
#

cd `dirname $0`

echo " "
echo "************* Package Install Setup ****************"
echo ""
echo "Path:`pwd`"
echo "*****************************************************"

if [ -f Configuration ]
then
  rm Configuration
fi
cp Configuration.default Configuration

source  ./Configuration

EXECUTABLES=`ls | grep .sh`
for script_name in ${EXECUTABLES}
do
  [ "${script_name}" == "setup.sh" ] && continue
  chmod 755 $script_name
done

if [ ! -d ${DOWNLOADS_LOG_DIR} ]
then
    mkdir ${DOWNLOADS_LOG_DIR}
fi
