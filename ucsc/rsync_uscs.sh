#!/bin/sh

## Synched  UCSC Tools 
#
# Runs as cron on local server
#
script_name=`basename $0`
cd `dirname $0`
working_dir=`pwd`
rsync_prog=`which rsync`

if [ ! -f $rsync_prog ]
then
   echo $rsync_prog
   echo "'rsync' not installed on `uname -n`"
   exit 1
fi
LOG_BASE=`dirname $working_dir`/logs
[ ! -d $LOG_BASE ] && mkdir $LOG_BASE
log_file=$LOG_BASE/$script_name.log
rm -f $log_file
touch $log_file
echo "`date`" | tee -a $log_file
[ ! -f ./ucsc.cfg ] && exit 1

source ./ucsc.cfg

$rsync_prog $rsync_options $remote_url $local_ucsc_binaries_base

echo "`date`" | tee -a $log_file
#rsync_options="--links --ignore-errors"
# make sure the connection is passwordless between the host
# and the destination server - https://www.centos.org/docs/5/html/5.1/Deployment_Guide/s3-openssh-dsa-key.html
# A trailing slash on the source changes this behavior to avoid creating 
# an additional directory level at the destination. You can think of a trailing / 
# on a source as meaning "copy the contents of this directory" as opposed 
# to "copy the directory by name",
