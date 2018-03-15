
# FASTX-Toolkit

This sub-directory contains:
 - [The Install Script](#the-install-script)(Install)
 - [The Package Config File](#the-package-config-file)(fastx_toolkit_package.cfg)
 - [The Package Dependencies File](#the-package-dependencies-file)(fastx_toolkit_dependencies.cfg)

 

## The Install Script
 This script is called by the main install script 
(install_package.sh)  to build and install  a new version of the package 

### What it does:
  1) sources the config files to set global path
  2) export PKG_CONFIG_PATH
  3) builds and install the tool
  ```
     a. copy  the executables to SOFTWARE_BASE/bin
     b. copy  the libraries to SOFTWARE_BASE/lib[64]
     c. copy  the include to SOFTWARE_BASE/include
 ```

### Note:
The following environment variables are expected to be set by the caller:

 1) GLOBAL_CONFIG  (Path to the main Configuration file
    ``` ${PACKAGE_DOWNLOADS_BASE}/Configuration ) ```
 2) PACKAGE_BASE   (Path to the new release install directory  ${EXTERNAL_SOFTWARE_BASE}/${TOOL_NAME}/${RELEASE_DIR})
 3) PACKAGE_DEPENDS (The dependencies file for this tool )


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
Fastx_toolkit only uses few of these variables.

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
The FASTX-Toolkit is a collection of command line tools for Short-Reads
FASTA/FASTQ files preprocessing.

# Building and installing
 See : http://hannonlab.cshl.edu/fastx_toolkit/download.html 
 
## Prerequisites
 * pkg-config
 * wget
 * Fastx-toolkit version 0.0.13 requires libgtextutils-0.6 
 * A recent g++ compiler (tested with GNU G++ 4.1.2 and later).
 * The fasta_clipping_histogram tool requires two perl modules: PerlIO::gzip and GD::Graph::bars.
 * The fastx_barcode_splitter tool requires GNU sed.
 * The fastq_quality_boxplot tool requires gnuplot version 4.2 or newer.

## Program Installation on CentOS
See: http://hannonlab.cshl.edu/fastx_toolkit/install_centos.txt

### First Install libgtextutils
 $ wget http://cancan.cshl.edu/labmembers/gordon/files/libgtextutils-0.7.tar.gz
 $ tar -xjf libgtextutils-0.7.tar.gz
 $ cd libgtextutils-0.6
 $ ./configure
 $ make
 $ sudo make install
 $ cd ..
 
 // Tell pkg-config to look for libraries in /usr/local/lib, too.
  export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig"


 ```

