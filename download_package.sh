#!/bin/sh

# Organization: MDIBL
# Author: Lucie Hutchins
# Date: September 2017
#
# Wrapper script to download a given package from its download site. 
# This creates an additional log that could be use later on
#
# This script is called by the runPackageInstall.sh script
# Assumption: all the expected environment variables have been
# sourced by the caller.
#
cd `dirname $0`
WORKING_DIR=`pwd`
SCRIPT_NAME=`basename $0`
DATE=`date +"%B %d %Y"`
DATE=`echo $DATE | sed -e 's/[[:space:]]/-/g'`

WGET=`which wget`
#
# Set path of files on local server
#export GLOBAL_CONFIG PACKAGE_BASE  RELEASE_NUMBER PACKAGE_CONFIG_FILE
if [ "${GLOBAL_CONFIG}" = "" ]
then
    echo "ERROR: global environment GLOBAL_CONFIG not set " 
    exit 1
fi
if [ "${PACKAGE_CONFIG_FILE}" = "" ]
then
    echo "ERROR: global environment PACKAGE_CONFIG_FILE not set " 
    exit 1
fi
if [ "${PACKAGE_BASE}" = "" ]
then
    echo "ERROR: global environment PACKAGE_BASE not set " 
    exit 1
fi
source ./${GLOBAL_CONFIG}
source ./${PACKAGE_CONFIG_FILE}

LOG=${DOWNLOADS_LOG_DIR}/${SCRIPT_NAME}.${RELEASE_DIR}.log
WGET_COMMAND="${WGET_OPTIONS} '${REMOTE_URL}'"
rm -f ${LOG}
touch ${LOG}

if [ "${DOWNLOADS_LOG_DIR}" = "" ]
then
    echo "ERROR: global environment DOWNLOADS_LOG_DIR not set "  | tee -a ${LOG}   
    exit 1
fi
if [ "${REMOTE_URL}" = "" ]
then
    echo "ERROR: global environment REMOTE_URL not set "  | tee -a ${LOG}   
    exit 1
fi
echo "==" | tee -a ${LOG}  
echo "Start Date:"`date` | tee -a ${LOG}  
echo "Package: ${SHORT_NAME}"  | tee -a ${LOG}  
echo "Remote site: ${REMOTE_SITE}"  | tee -a ${LOG}  
echo "Remote directory: ${REMOTE_DIR}"  | tee -a ${LOG}  
echo "Remote files: ${REMOTE_FILES}"  | tee -a ${LOG}  
echo "Remote url: ${REMOTE_URL}" | tee -a ${LOG}  
echo "==" | tee -a ${LOG}  
echo "Local directory: ${PACKAGE_BASE}" | tee -a ${LOG}  
echo "==" | tee -a ${LOG}  
echo "Running $SCRIPT_NAME from: ${WORKING_DIR}"| tee -a ${LOG}  

[ ! -d ${PACKAGE_BASE} ] && mkdir --parents ${PACKAGE_BASE}
if [ ${is_xml_query} ]
then
   ##don't do the loop if this is a xml query string
   target_file="${REMOTE_URL}/${REMOTE_FILES}"
   echo "---- ${WGET} ${WGET_OPTIONS} $target_file" | tee -a  ${LOG}  
   cd ${PACKAGE_BASE}
   ${WGET} -a ${LOG} ${WGET_OPTIONS} "${target_file}"
else
(
set -f
for remote_file in ${REMOTE_FILES}
do
   target_file="${REMOTE_URL}/${remote_file}"
   echo "Downloading ${target_file}"
   ## get the directory part from the remote_file name
   target_local_dir=`dirname ${remote_file}`
   #
   # Make parent directories as needed
   if [ "${target_local_dir}" != "" ]
   then
       if [ "${NO_LOCAL_PARENT_DIR}" = true ]
       then 
           target_local_dir=""
       else
           echo "Creating ${PACKAGE_BASE}/${target_local_dir}"
           mkdir -p ${PACKAGE_BASE}/${target_local_dir}
       fi
   fi
   #cd to LOCAL_DOWNLOAD_BASE and run wget command 
   cd ${PACKAGE_BASE}/${target_local_dir} 
   # delete local files as needed
   if [ "${do_deletes}" = true ]
   then
       rm -f ${remote_file}
   fi
   if [ "${IS_HTTP_PATTERN}" = true ]
   then
       ${WGET} -a ${LOG} ${WGET_OPTIONS} -A "${remote_file}" "${REMOTE_URL}/" 
    else
      echo "Running command: ${WGET} -a ${LOG} ${WGET_OPTIONS} ${target_file} "
       ${WGET}  ${WGET_OPTIONS} ${target_file} 2>&1 | tee -a ${LOG}
    fi
 done
 )
 fi
 
echo "End Date:"`date` | tee -a ${LOG}  
echo "==" | tee -a ${LOG}  
echo ""
exit 0
