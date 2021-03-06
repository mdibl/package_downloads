# Bamtools
 
This sub-directory contains:
 - [The Install Script](#the-install-script)(Install)
 - [The Package Config File](#the-package-config-file)(bamtools_package.cfg)
 - [The Package Dependencies File](#the-package-dependencies-file)(bamtools_dependencies.cfg)

## USAGE: ./trigger_tool_install.sh tool_name [tool_version]

After installing the package_downloads repos 

See: https://github.com/mdibl/package_downloads/wiki/How-To-Install-This-Repos

**cd**  to package_downloads/ install root directory and run 
```

Example 1: ./trigger_tool_install.sh bamtools
The above command tells the trigger script to install the current version of bamtools

Example 2: ./trigger_tool_install.sh bamtools v2.4.1
The above command tells the trigger script to install version v2.4.1
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

 See : https://github.com/pezmaster31/bamtools/wiki/Building-and-installing 
 
Dependencies:
From their site, BamTools has been migrated to a CMake-based build system.
BamTools requires CMake (version >= 2.6.4). If you are missing CMake or have an older version, 
check your OS package manager (for Linux users) 
or download it here: http://www.cmake.org/cmake/resources/software.html .

bash
  Note: To check is cmake is installed, run the following command: cmake --version

Build BamTools

  * cd to the install root directory (path2/bamtools
  * mkdir build
  * cd build
  * cmake ..
  * make
  * cd ..

Check the Install
There should be the bin/ , lib/ , and include/ subdirectories 
under the install root directory
 bamtools/bin
 bamtools/lib
 bamtools/include
```
