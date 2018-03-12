#!/bin/sh

# Organization: MDIBL
# Author: Lucie Hutchins
# Date: March 2018
#
# This script is called by the main install script 
# (install_package.sh) for the install of packages we only download binanies
#
# What it does:
# 1) source the main config file to set global path
# 2) source the dependencies config file
# 3) copy 
#   a. executables to /opt/software/bin
#   b. includes to /opt/software/include
#   c. libs to /opt/software/lib[64]
#
#
# Note: the following environment variables are expected to be set
# by the caller
# 1) GLOBAL_CONFIG
# 2) PACKAGE_BASE
# 3) PACKAGE_DEPENDS
#
cd `dirname $0`
SCRIPT_NAME=`basename $0`
WORKING_DIR=`pwd`
echo "==" 
echo "Server Name: `uname -n`" 
echo "Install Date: `date`" 
if [ ! -f ${GLOBAL_CONFIG} ]
then
  echo "'${GLOBAL_CONFIG}' file missing "     
  exit 1
fi
source ./${GLOBAL_CONFIG}

if [ ! -f  ${PACKAGE_DEPENDS} ]
then
   echo "ERROR: ${PACKAGE_DEPENDS} file missing "  
   exit 1
fi
source ./${PACKAGE_DEPENDS}

if [ ! -d ${PACKAGE_BASE} ]
then
   echo "ERROR: Missing the install directory ${PACKAGE_BASE} "
   exit 1
fi
if [ ! -f ${PACKAGE_CONFIG_FILE} ]
then
    echo "ERROR: ${PACKAGE_CONFIG_FILE}  file missing "
   exit 1
fi
source ./${PACKAGE_CONFIG_FILE}
#Check the install
#Make sure files are installed where expected
# 
if [ "${TEMP_DOWNLOAD_DIR}" !="" ]
then
    mv ${PACKAGE_BASE}/${TEMP_DOWNLOAD_DIR}/* ${PACKAGE_BASE}
    rm -rf ${PACKAGE_BASE}/${TEMP_DOWNLOAD_DIR}
fi
rstatus="SUCCESS"
for bin_file in ${BIN_FILES}
do
    if [ ! -f ${PACKAGE_BASE}/${bin_file} ]
    then
       echo "ERROR: install failed - $PACKAGE_BASE/${bin_file} missing" 
       rstatus="FAILED"
     fi
done
for include_dir in ${INCLUDE_DIR} 
do
    if [ ! -d ${PACKAGE_BASE}/${include_dir} ]
    then
       echo "ERROR: install failed" 
       echo " Include directory INCLUDE_DIR=${PACKAGE_BASE}/${include_dir} not set properly in ${PACKAGE_DEPENDS}"
       rstatus="FAILED"
     fi
done

echo ${rstatus}

[ "$rstatus" == FAILED ] && exit 1
#Copy binaries and libraries to /opt/software/bin and /opt/software/lib
for bin_file in ${BIN_FILES}
do
    chmod 755 ${PACKAGE_BASE}/${bin_file}
    echo "cp -p  ${PACKAGE_BASE}/${bin_file} ${SOFTWARE_BIN_BASE}"
    if [ "${CREATE_BINFILE_SYM_LINK}" = true ]
    then
       [ -f ${SOFTWARE_BIN_BASE}/${bin_file} ] && rm -f ${SOFTWARE_BIN_BASE}/${bin_file}
       ln -s ${PACKAGE_BASE}/${bin_file}  ${SOFTWARE_BIN_BASE}/${bin_file}
    else
        cp -P  ${PACKAGE_BASE}/${bin_file}  ${SOFTWARE_BIN_BASE}/
    fi
done
for include_dir in ${INCLUDE_DIR} 
do
   cp -Rp ${PACKAGE_BASE}/${include_dir} $SOFTWARE_INCLUDE_BASE/
done
for lib_dir in ${LIB_DIR} 
do
   cp -Rp ${PACKAGE_BASE}/${lib_dir} ${SOFTWARE_LIB_BASE}/
done
for lib_dir in ${LIB64_DIR} 
do
   cp -Rp ${PACKAGE_BASE}/${lib_dir} ${SOFTWARE_LIB64_BASE}/
done
exit 0
