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
PACKAGE_GIT_CLONE_BASE=${PACKAGE_DOWNLOADS_BASE}/temp/github_repos
[ ! -d ${PACKAGE_GIT_CLONE_BASE} ] && mkdir -p ${PACKAGE_GIT_CLONE_BASE}
echo ""
echo "Path to package_downloads base: `pwd`"
echo "*****************************************************"
echo ""
echo "Next: Update the file 'Configuration' "
echo " "
echo "  Set:"
echo "  SOFTWARE_BASE=path2/software_packages_root     -- parent directory of bin/ lib/ include/  ..."
echo "  EXTERNAL_SOFTWARE_BASE=path2/packages_installs --  full path to where packages will be installed "
echo "  LOGS_BASE=path2/logs_base  --  full path to the logs base"
echo ""
echo "  Set:"
echo "  PACKAGE_DOWNLOADS_BASE=${PACKAGE_DOWNLOADS_BASE}"
echo ""

