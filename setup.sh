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
echo "  ${PACKAGE_DOWNLOADS_BASE}: is the full path to where this package is installed"
echo "Next: Update the file 'Configuration' and set the following environment variables"
echo "  SOFTWARE_BASE : full path to where to store external executables and libraries"
echo "  EXTERNAL_SOFTWARE_BASE : full path to where packages will be installed "
echo "  PACKAGE_GIT_CLONE_BASE : full path to where to clone git repos locally "
echo "  LOGS_BASE : full path to the logs base"
echo ""

