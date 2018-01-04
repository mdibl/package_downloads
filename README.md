# package_downloads
A repository to store scripts and configuration files used to create pipelines to download external bioinformatics packages.

## To Install
 * FASTQC
 * FASTX
 * Trimgalore
 * Trimmomatic

## Pipeline Setting on Jenkins:
1) Create the Package-XX-CheckNewVersion job with the following config:
```
For Git Repos:
   CONFIG_FILE=$SHORT_NAME/${SHORT_NAME}_repos.cfg
   GET_VERSION_SCRIPT=cloneGitRepos.sh
   DOWNLOAD_SCRIPT=runDownloadGitRepos.sh
   
For non Git repos:
   CONFIG_FILE=$SHORT_NAME/${SHORT_NAME}_package.cfg
   GET_VERSION_SCRIPT=getVersion.sh
   DOWNLOAD_SCRIPT=rrunDownloadPackage.sh

CURRENT_RELEASE_SCRIPT=getCurrentReleaseNumber.sh
param_log=$WORKSPACE/logs.sh
rm -f $param_log
touch $param_log
echo "PACKAGE_CONFIG_FILE=$CONFIG_FILE" | tee -a $param_log
echo "GET_VERSION_SCRIPT=$GET_VERSION_SCRIPT" | tee -a $param_log
echo "DOWNLOAD_SCRIPT=$DOWNLOAD_SCRIPT" | tee -a $param_log
echo "CURRENT_RELEASE_SCRIPT=$CURRENT_RELEASE_SCRIPT" | tee -a $param_log

```

```
Then: 
Package-XX-CheckNewVersion job => download-version-file job => toggleDownload job => Download-and-Install-Package
```
## Dependencies:
### Bamtools
  * cmake 
  ```
  version >=2.6.4
  ```
### BedTools
 * zlib.h
### Bwa tools
 * zlib.h
### Samtools, Htslib
 * gcc 
 * autoconf 
 * autoheader
 * zlib.h 
 * lzma.h 
 * bzip2.h 
 * ncurses
 * bzlib.h
