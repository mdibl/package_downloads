# Hisat2


This sub-directory contains:
 - [The Install Script](#the-install-script)(Install)
 - [The Package Config File](#the-package-config-file)(hisat2_package.cfg)
 - [The Package Dependencies File](#the-package-dependencies-file)(hisat_dependencies.cfg)
 

## The Install Script
 This script is called by the main install script 
(install_package.sh)  to build and install  a new version of the package 

### What it does:
  1) sources the main config file to set global path
  2) sources package specific config file
  3) builds and install the package
  ```
  copy  the executables to SOFTWARE_BASE/bin  
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
Hisat2 only uses few of these variables.

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

HISAT2 is a successor to both HISAT and TopHat2. 
It's recommended that the HISAT and TopHat2 users switch to HISAT2. 
A fast and sensitive spliced alignment program for mapping RNA-seq reads. 
In addition to one global FM index that represents a whole genome, 
HISAT uses a large set of small FM indexes that collectively 
cover the whole genome (each index represents a genomic region 
of ~64,000 bp and ~48,000 indexes are needed to cover the human genome).
```
