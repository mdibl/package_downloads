#!/bin/bash

## This is a wrapper script to call
# the R script that generates a list
# of user-installed R packages with the version installed

#

REPORTS_DIR=/data/logs/reports/R
LOG_DIR=/data/logs/package_downloads

mkdir -p $REPORTS_DIR
mkdir -p $LOG_DIR
DATE=`date +"%Y-%m-%d"`
REPORT=$REPORTS_DIR/$DATE.R.Packages.txt
LOG=$LOG_DIR/$DATE.R.Packages.log
R_SCRIPT=genPackageReports.r
UPDATE_PACKAGE_SCRIPT=checkPackageUpdate.r
rm -f $LOG
touch $LOG

rm -f $REPORT
touch $REPORT
cd `dirname $0`

sudo ./$UPDATE_PACKAGE_SCRIPT  2>&1 | tee -a  $LOG

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
echo "Generating $REPORT" 
echo "***********************************"

echo "Command: ./$R_SCRIPT > $REPORT"

./$R_SCRIPT >>  $REPORT


lines_count=`wc -l  $REPORT | cut -f1`
echo "Report generated."
echo "Lines Count:$lines_count"

echo $DATE

exit 0
