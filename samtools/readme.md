# Samtools
 
This sub-directory contains:
 - [The Install Script](#the-install-script)(Install)
 - [The Package Config File](#the-package-config-file)(samtools_package.cfg)
 - [The Package Dependencies File](#the-package-dependencies-file)(samtools_dependencies.cfg)

## The Install Script
 This script is called by the main install script 
(install_package.sh)  to build and install  a new version of the package 

### What it does:
  1) sources the main config file to set global path
  2) sources the dependencies config file
  3) runs the build and Install to
  ```
   a. copy  the executables to /opt/software/bin
   b. copy  the libraries to /opt/software/lib[64]
   c. copy  the include to /opt/software/include
  ```

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
Samtools only uses few of these variables.

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
 See : https://github.com/samtools/samtools/blob/develop/INSTALL 
 
## Dependency
### Programs:
  * GNU make
  * C compiler (e.g. gcc or clang)
  * autoheader
  * autoconf

### Libraries:
  * zlib library <http://zlib.net>
  * bzip2 library <http://bzip.org/>
  * curses or GNU ncurses library <http://www.gnu.org/software/ncurses/>

Notes: The bzip2 and liblzma dependencies can be removed if full CRAM support
is not needed - see HTSlib  INSTALL file for details.

Installing curses 

sudo yum install ncurses-devel ncurses
```
