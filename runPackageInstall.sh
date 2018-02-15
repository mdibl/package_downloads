#!/bin/sh

# Organization: MDIBL
# Author: Lucie Hutchins
# Date: September 2017
# Modified: February 2018
#
# Wrapper script to call scripts that download and install a new package
# It creates an additional log that could be use later on
#
# What it does:
# 1) sources global configs
# 2) Downloads the specified version of this package 
# 3) Updates the symbolic link
# 4) Calls the install_package script
#
cd `dirname $0`
WORKING_DIR=`pwd`
SCRIPT_NAME=`basename $0`
GLOBAL_CONFIG=Configuration

if [ $# -lt 1 ]
then
  echo "Usage: ./${SCRIPT_NAME} tool_name
  echo "Example: ./${SCRIPT_NAME} bamtools 
  exit 1
fi
TOOL_NAME=$1
if [ ! -d ${TOOL_NAME} ]
then
  echo "ERROR: No automation found for ${TOOL_NAME}"
  echo "Check list of available automations under `pwd`"
  echo "Also check the spelling or the case sensitive"
  exit 1
fi
##The config file is relative to
# the root directory of pacakage download 

if [ ! -f ${GLOBAL_CONFIG} ]
then
  echo "'${GLOBAL_CONFIG}' file missing under `pwd`" 
  echo "You must run the setup.sh script first to generate this file"
  echo "Usage: ./setup.sh "
  exit 1
fi
source ./${GLOBAL_CONFIG}
#set path to packages install base
#and get the version to install from the flag file
#
PACKAGE_DOWNLOADS_BASE=${EXTERNAL_SOFTWARE_BASE}/${TOOL_NAME}
RELEASE_FILE=${PACKAGE_DOWNLOADS_BASE}/${CURRENT_FLAG_FILE}

if [ ! -f ${RELEASE_FILE} ]
then
   echo "ERROR: ${RELEASE_FILE} file missing"
   exit 1
fi
RELEASE_NUMBER=`cat ${RELEASE_FILE}`
PACKAGE_CONFIG_FILE=${TOOL_NAME}/${TOOL_NAME}${PACKAGE_CONFIGFILE_SUFFIX}
PACKAGE_DEPENDS=${TOOL_NAME}/${PACKAGE_DEPENDENCIES_FILE}

if [ ! -f ${PACKAGE_CONFIG_FILE} ]
then
    echo "ERROR: missing ${PACKAGE_CONFIG_FILE} "
    exit 1
fi
source ./${PACKAGE_CONFIG_FILE}
[ -f ${PACKAGE_DEPENDS} ] && source ./${PACKAGE_DEPENDS}
PACKAGE_BASE=${PACKAGE_DOWNLOADS_BASE}/${RELEASE_DIR}
#If this version is already installed, skipp the install
#
if [ -d ${PACKAGE_BASE} ]
then
    echo " "
    echo "************* Package Install ****************"
    echo ""
    echo "${TOOL_NAME} Version: ${RELEASE_NUMBER} is already installed"
    echo ""
    echo "***********************************************"
    echo " "
    echo "  See: ${PACKAGE_BASE}"
    echo "  If you want to re-install this version,"
    echo "  you must first remove the above directory then re-run the program"
    echo " " 
    exit 0
fi
LOG=${DOWNLOADS_LOG_DIR}/${SCRIPT_NAME}.${TOOL_NAME}.${RELEASE_NUMBER}.log
rm -f ${LOG}
touch ${LOG}
echo "==" | tee -a ${LOG}
echo "Package: ${TOOL_NAME}"  | tee -a ${LOG}
echo "Version: ${RELEASE_NUMBER}"  | tee -a ${LOG}
echo "Remote site: ${REMOTE_SITE}"  | tee -a ${LOG}
echo "Remote directory: ${REMOTE_DIR}"  | tee -a ${LOG}
echo "Install base directory: ${PACKAGE_DOWNLOADS_BASE}" | tee -a ${LOG}
echo "Install release directory: ${PACKAGE_DOWNLOADS_BASE}/${RELEASE_DIR}" | tee -a ${LOG}
echo "Path to Install logs: ${DOWNLOADS_LOG_DIR}" | tee -a ${LOG}
echo "Install Date:"`date` | tee -a ${LOG}
echo "Git Organization:${GIT_ORG}" | tee -a ${LOG}
echo "Git Repos:${GIT_REPOS}" | tee -a ${LOG}
echo "Remote files:" | tee -a ${LOG}
echo " ${REMOTE_FILES}" | tee -a ${LOG}
echo "==" | tee -a ${LOG}
echo "Running script from: ${WORKING_DIR}"| tee -a ${LOG}
echo "Command: ./${DOWNLOAD_SCRIPT} ${PACKAGE_CONFIG_FILE}"| tee -a ${LOG}
echo "==" | tee -a $LOG
if [ "${EXPORT_GIT}" = true ]
then
    #export git repos
    #
   ./${EXPORT_REPOS_SCRIPT} ${GIT_ORG} ${GIT_REPOS} ${RELEASE_NUMBER} ${PACKAGE_DOWNLOADS_BASE} 2>&1 | tee -a $LOG
else
   # Download the executable
   #
   ./${DOWNLOAD_SCRIPT}  2>&1 | tee -a $LOG
   echo "=="
   cd ${PACKAGE_DOWNLOADS_BASE}
   ## The zip file was downloaded under $EXTERNAL_SOFTWARE_BASE/$SHORT_NAME
   [ "${NO_LOCAL_PARENT_DIR}" = true ] && REMOTE_FILES=`basename ${REMOTE_FILES}`
   [ "${local_untar_dir}" != "" ] && [ "${is_tar}" = true ] && mkdir --parent ${untar_dir}
   if [ "${untar_flag}" = true ]
   then
      echo "Untar: ${untar_prog} ${REMOTE_FILES} ${local_untar_dir} From: "`pwd`
      [ -f ${REMOTE_FILES} ] && ${untar_prog} ${REMOTE_FILES} ${local_untar_dir}
   fi
   #Check if this release directory was created
   if [ ! -d ${PACKAGE_BASE} ]
   then
        echo "Download failed: missing ${PACKAGE_BASE}" | tee -a $LOG
        exit 1
   fi
   # Update symbolic link of this package to point to
   # the downloaded version
   #
   [ -f $REMOTE_FILES ] && rm -f ${REMOTE_FILES} 
fi
#
#Now run the install_package script
./${INSTALL_PACKAGE_SCRIPT} ${TOOL_NAME}
if [ $? -ne 0 ]
then
    echo "Status: FAILED" | tee -a ${LOG}
    exit 1
fi
cd ${PACKAGE_DOWNLOADS_BASE}
rm -f ${TOOL_NAME}
ln -s ${RELEASE_DIR} ${TOOL_NAME}

echo "Status: SUCCESS" | tee -a ${LOG}
echo "=="
echo "End Date:"`date` | tee -a ${LOG}
echo ""
exit 0
