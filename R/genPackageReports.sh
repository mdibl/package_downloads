#!/bin/bash

## This is a wrapper script to call
# the R script that generates a list
# of user-installed R packages with the version installed

#

REPORTS_DIR=/data/logs/reports/R

mkdir -p $REPORTS_DIR
DATE=`date +"%Y-%m-%d"`
REPORT_FILE=$REPORTS_DIR/$DATE.R.Packages.log
R_SCRIPT=genPackageReports.r
UPDATE_PACKAGE_SCRIPT=checkPackageUpdate.r
LOG=$REPORT_FILE
rm -f $LOG
touch $LOG
cd `dirname $0`

./$UPDATE_PACKAGE_SCRIPT  2>&1 | tee -a  $LOG

#There should be the genPackageReports.r R script
# in the same directory as this script
#
if [ ! -f $R_SCRIPT ]
then
   echo "R script genPackageReports.r missing from:"`pwd`
   exit 1
fi
echo "Date generated: `date`" | tee -a $LOG
echo "***********************************" | tee -a $LOG
echo "Generating $REPORT_FILE" 
echo "***********************************"

echo "Command: ./$R_SCRIPT > $LOG"

./$R_SCRIPT >>  $LOG


lines_count=`wc -l  $LOG | cut -f1`
echo "Report generated."
echo "Lines Count:$lines_count"

echo $DATE

exit 0
