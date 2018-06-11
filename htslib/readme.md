# Htslib
 
This sub-directory contains:
 - [The Install Script](#the-install-script)(Install)
 - [The Package Config File](#the-package-config-file)(htslib_package.cfg)
 - [The Package Dependencies File](#the-package-dependencies-file)(htslib_dependencies.cfg)

## The Install Script
 This script is called by the main install script 
(install_package.sh)  to build and install  a new version of the package 

### What it does:
  1) sources the main config file to set global path
  2) sources the dependencies config file
  3) build and copy the executables to /opt/software/bin

### Note:
The following environment variables are expected to be set by the caller:

 1) GLOBAL_CONFIG  (Path to the main Configuration file
    ``` ${PACKAGE_DOWNLOADS_BASE}/Configuration ) ```
 2) PACKAGE_BASE   (Path to the new release install directory  ${EXTERNAL_SOFTWARE_BASE}/${SHORT_NAME}/${RELEASE_DIR})
 3) PACKAGE_DEPENDENCIES_FILE (The dependencies file for this tool  PACKAGE_DOWNLOADS_BASE/SHORT_NAME/


## The Package Config File 
The config file sets environment variables specific to this tool.
Some key variables include:

  - GIT_ORG
  - SHORT_NAME  (same as the name of the tool local directory)
  - GIT_REPOS
  - REMOTE_SITE
  - REMOTE_DIR
  - REPOS_TAG_PATTERN
  - REMOTE_VERSION_FILE
  - RELEASE_DIR
  - EXPORT_GIT
  - CLONE_GIT
  
## The Package Dependencies File
Each tool's dependency file contains the pre-install and post-install sets of dependencies.
Htslib only uses few of these variables.

### Used for Pre-Install Dependencies Check
  - BIN_DEPENDENCIES
  - LIB_DEPENDENCIES

### Used To Verify the install was a success
  - FILE_CHECK
  - DIR_CHECK

### Used to copy files to ../bin /../lib ../lib64 ../include 
  - BIN_FILES
  - INCLUDE_DIR
  - LIB64_DIR
  - LIB_DIR
## Appendix:
```
# Building and installing
 See : https://github.com/samtools/htslib/blob/develop/INSTALL
 
## Dependency
### Programs:
  * GNU make
  * C compiler (e.g. gcc or clang)
  * autoheader
  * autoconf
 
### Libraries:

  * libz       (required)
    libbz2     (required, unless configured with --disable-bz2)
    liblzma    (required, unless configured with --disable-lzma)
    libcurl    (optional, but strongly recommended)
    libcrypto  (optional for Amazon S3 support; not needed on MacOS)
### Installing bzlib.h
[ec2-user@ip-172-31-40-156 ~]$ sudo yum search bzip2
[ec2-user@ip-172-31-40-156 ~]$ sudo yum info bzip2-devel
[ec2-user@ip-172-31-40-156 ~]$ sudo yum install bzip2-devel
[ec2-user@ip-172-31-40-156 ~]$ sudo yum install bzip2-libs

## Configure and Install Htslib

  * cd to the install directory (/opt/software/external/samtools) then run:
  * ./configure --prefix=/opt/software/external/samtools
  * make 
  * make install
 
## Check the Install
There should be the bin/ , lib/ , and include/ subdirectories 
under the install root directory

 samtools/bin
 samtools/lib
 samtools/share/man
```
