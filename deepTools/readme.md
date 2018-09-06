# Deeptools
 
This sub-directory contains:
 - [The Install Script](#the-install-script)(Install)
 - [The Package Config File](#the-package-config-file)(deeptools_package.cfg)
 - [The Package Dependencies File](#the-package-dependencies-file)(deeptools_dependencies.cfg)

## USAGE: ./trigger_tool_install.sh tool_name [tool_version]

After installing the package_downloads repos 

See: https://github.com/mdibl/package_downloads/wiki/How-To-Install-This-Repos

**cd**  to package_downloads/ install root directory and run 
```

Example 1: ./trigger_tool_install.sh deeptools
The above command tells the trigger script to install the current version of deeptools

Example 2: ./trigger_tool_install.sh deeptools 3.1.0
The above command tells the trigger script to install version 3.1.0
```

## The Install Script
 This script is called by the main install script 
(install_package.sh)  to build and install  a new version of the package 

### What it does:
  1) sources the main config file to set global path
  2) sources the dependencies config file
  3) runs the build and 
     a. copy  the executables to /opt/software/bin
     b. copy  the libraries to /opt/software/lib[64]
     c. copy  the include to /opt/software/include
 

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
Bamtools only uses few of these variables.

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

 See : https://deeptools.readthedocs.io/en/latest/content/installation.html
       https://github.com/deeptools/deepTools
 
Dependencies:
From their site,

* Python 2.7 or Python 3.x
* numpy >= 1.8.0
* scipy >= 0.17.0
* py2bit >= 0.1.0
* pyBigWig >= 0.2.1
* pysam >= 0.8
* matplotlib >= 1.4.0

Build BamTools

  * wget https://github.com/deeptools/deepTools/archive/x.x.xx.tar.gz
  * tar -xzvf
  * python setup.py install --prefix /User/Tools/deepToolsx.x
  
Check the Install

```
