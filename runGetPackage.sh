#!/bin/sh

# Organization: MDIBL
# Author: Lucie Hutchins
# Date: September 2017
# Modified: March 2018
#
# Wrapper script to call scripts that download and install a new package
# It creates an additional log that could be use later on
#
# What it does:
# 1) sources global configs
# 2) Calls the appropriate download script to download the specified version of this package 
# 3) Calls the install_package script to run the install 
# 4) Updates the tool symbolic link on success 

cd `dirname $0`
WORKING_DIR=`pwd`
SCRIPT_NAME=`basename $0`
GLOBAL_CONFIG=Configuration

function displayTools() {
    echo ""
    echo " List of available tools"
    echo "----------------------------"
    tools="`ls`"
    for tool in ${tools}
    do
       [ -d ${tool} ] && echo " ${tool}"
    done
    echo ""
}

echo "
***************************************
 BIOCORE PACKAGE INSTALL AUTOMATION 
***************************************
A package to create automations that download and Install
commonly used bioinformatics tools and libraries. 

"

if [ $# -lt 1 ]
then
  echo "Usage: ./${SCRIPT_NAME} tool_name"
  echo "Example: ./${SCRIPT_NAME} bamtools"
  displayTools
  exit 1
fi
TOOL_NAME=$1
if [ ! -d ${TOOL_NAME} ]
then
   echo "ERROR: No automation found for ${TOOL_NAME}"
   echo "Check the spelling or the case sensitive"
   displayTools
   exit 1
fi
##The config file is relative to
# the root directory of package download 

if [ ! -f ${GLOBAL_CONFIG} ]
then
  echo "'${GLOBAL_CONFIG}' file missing under `pwd`" 
  echo "You must run the setup.sh script first to generate this file"
  echo "Usage: ./setup.sh "
  exit 1
fi
source ./${GLOBAL_CONFIG}
# Create base directories if not exist
# Make sure the directory is not empty or
# the main root directory "/" 
#
bad_dir=false
[ "${SOFTWARE_BASE}" == "" ] && bad_dir=true
[ "${SOFTWARE_BASE}" == "/" ] && bad_dir=true
if [ "$bad_dir" == true ]
then
   echo "ERROR - SOFTWARE_BASE has an invalid value: ${SOFTWARE_BASE}"
   exit 1
fi
mkdir -p ${SOFTWARE_BASE}
bad_dir=false
[ "${EXTERNAL_SOFTWARE_BASE}" == "" ] && bad_dir=true
[ "${EXTERNAL_SOFTWARE_BASE}" == "/" ] && bad_dir=true

if [ "$bad_dir" == true ]
then
   echo "ERROR - EXTERNAL_SOFTWARE_BASE has an invalid value: ${EXTERNAL_SOFTWARE_BASE}"
   exit 1
fi
 mkdir -p ${EXTERNAL_SOFTWARE_BASE}
[ ! -d ${DOWNLOADS_LOG_DIR} ] && mkdir -p ${DOWNLOADS_LOG_DIR}
[ ! -d ${SOFTWARE_BIN_BASE} ] && mkdir -p ${SOFTWARE_BIN_BASE}
[ ! -d ${SOFTWARE_LIB_BASE} ] && mkdir -p ${SOFTWARE_LIB_BASE}
[ ! -d ${SOFTWARE_LIB64_BASE} ] && mkdir -p ${SOFTWARE_LIB64_BASE}
[ ! -d ${SOFTWARE_INCLUDE_BASE} ] && mkdir -p ${SOFTWARE_INCLUDE_BASE}

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
PACKAGE_DEPENDS=${TOOL_NAME}/${TOOL_NAME}${PACKAGE_DEPENDENCIES_SUFFIX}

if [ ! -f ${PACKAGE_CONFIG_FILE} ]
then
    echo "ERROR: missing ${PACKAGE_CONFIG_FILE} "
    exit 1
fi
source ./${PACKAGE_CONFIG_FILE}
[ -f ${PACKAGE_DEPENDS} ] && source ./${PACKAGE_DEPENDS}
PACKAGE_BASE=${PACKAGE_DOWNLOADS_BASE}/${RELEASE_DIR}
export GLOBAL_CONFIG PACKAGE_DOWNLOADS_BASE  RELEASE_NUMBER PACKAGE_BASE PACKAGE_CONFIG_FILE 
export PACKAGE_DEPENDS SOFTWARE_BASE
echo " "
echo "************* Package Install ****************"
echo ""
#If this version is already installed, skip the install
#
if [ -d ${PACKAGE_BASE} ]
then
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
echo "Installing ${TOOL_NAME} Version: ${RELEASE_NUMBER} "
echo ""
echo "***********************************************"
echo " "
LOG=${DOWNLOADS_LOG_DIR}/${SCRIPT_NAME}.${TOOL_NAME}.${RELEASE_NUMBER}.log
rm -f ${LOG}
touch ${LOG}
export LOG
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
    if [ "${NO_DOWNLOAD}" != true ]
    then
        ./${EXPORT_REPOS_SCRIPT} ${GIT_ORG} ${GIT_REPOS} ${RELEASE_NUMBER} ${PACKAGE_DOWNLOADS_BASE} 2>&1 | tee -a $LOG
    fi
else
   # Download the executable
   ./${DOWNLOAD_SCRIPT}  2>&1 | tee -a $LOG
   echo "=="
   cd ${PACKAGE_BASE}
   ## The files are downloaded under ${PACKAGE_BASE}
   [ "${NO_LOCAL_PARENT_DIR}" = true ] && REMOTE_FILES=`basename ${REMOTE_FILES}`
   [ "${local_untar_dir}" != "" ] && [ "${is_tar}" = true ] && mkdir --parent ${untar_dir}
   if [ "${untar_flag}" = true ]
   then
      echo "Untar: ${untar_prog} ${REMOTE_FILES} ${local_untar_dir} From: "`pwd`
      [ -f ${REMOTE_FILES} ] && ${untar_prog} ${REMOTE_FILES} ${local_untar_dir}
      [ -f $REMOTE_FILES ] && rm -f ${REMOTE_FILES} 
   fi
   if [ "${RELEASE_DIR}" != "" ]
   then
      if [ -d ${RELEASE_DIR} ]
      then
          mv  ${RELEASE_DIR}/* .
          rm -rf ${RELEASE_DIR}
      fi
   fi
   if [ "${TEMP_DOWNLOAD_DIR}" != "" ]
   then
       if [ -d ${TEMP_DOWNLOAD_DIR} ]
       then
           mv ${TEMP_DOWNLOAD_DIR}/* .
           rm -rf ${TEMP_DOWNLOAD_DIR}
       fi
   fi
fi
#Check if this release directory was created
if [ ! -d ${PACKAGE_BASE} ]
then
    echo "Download failed: missing ${PACKAGE_BASE}" | tee -a $LOG
    exit 1
fi

cd ${WORKING_DIR}
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
