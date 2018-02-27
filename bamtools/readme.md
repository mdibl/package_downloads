 # The Install Script: Install
 This script is called by the main install script 
(install_package.sh)  to build and install  a new version of the package 

## What it does:
  1) source the main config file to set global path
  2) source the dependencies config file
  3) runs the build and 
     a. copy  the executables to /opt/software/bin
     b. copy  the libraries to /opt/software/lib[64]
     c. copy  the include to /opt/software/include
 

## Note:
The following environment variables are expected to be set by the caller:

 1) GLOBAL_CONFIG
 2) PACKAGE_BASE
 3) PACKAGE_DEPENDENCIES_FILE


```
# Building and installing
 See : https://github.com/pezmaster31/bamtools/wiki/Building-and-installing 
 
## Dependency
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
