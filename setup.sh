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
PACKAGE_DOWNLOADS_BASE=`pwd`
[ ! -d ${PACKAGE_GIT_CLONE_BASE} ] && mkdir -p ${PACKAGE_GIT_CLONE_BASE}
echo ""
echo "Path to package_downloads base: `pwd`"
echo "*****************************************************"
echo ""
echo "Next: Update the file 'Configuration' and set the following environment variables"
echo "  SOFTWARE_BASE : full path to where to store external executables and libraries"
echo "  EXTERNAL_SOFTWARE_BASE : full path to where packages will be installed "
echo "  LOGS_BASE : full path to the logs base"
echo "  PACKAGE_GIT_CLONE_BASE : full path to where to clone git repos locally "
echo "  Set PACKAGE_DOWNLOADS_BASE=`pwd`"
echo ""

