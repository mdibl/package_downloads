#!/bin/sh

# Organization: MDIBL
# Author: Lucie Hutchins
# Date: February 2018
#
## Script is called by the Install script 
#  to check whether or not the install was successful
#
# Usage: ./install_check_package_install
#
# Assuming all global environment variables needed have
# been set by the parent process
#
# DIR_CHECK and FILE_CHECK are a list of directories and files 
# as specified in each tool's dependencies.cfg filw
#

echo "Checking the package install under ${PACKAGE_BASE}" | tee -a ${LOG_FILE}
#Check the install
rstatus="SUCCESS"
for folder in ${DIR_CHECK}
do
    if [ ! -d ${PACKAGE_BASE}/${folder} ]
    then
       echo "${PACKAGE_BASE}/${folder} missing" | tee -a ${LOG_FILE}
       rstatus="FAILED"
     fi
done
for file_to_check on ${FILE_CHECK}
do
    if [ ! -f ${PACKAGE_BASE}/${file_to_check} ]
    then
        echo "${PACKAGE_BASE}/${file_to_check} missing" | tee -a ${LOG_FILE}
        rstatus="FAILED"
    fi
done
if [ "${rstatus}" == FAILED ]
then
   echo "${rstatus}" | tee -a ${LOG_FILE}
   exit 1
fi
echo "Install's Status: ${rstatus} " | tee -a ${LOG_FILE}
exit 0