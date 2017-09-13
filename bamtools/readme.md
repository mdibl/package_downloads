# Building and installing
 See : https://github.com/pezmaster31/bamtools/wiki/Building-and-installing 
 
## Dependency
From their site, BamTools has been migrated to a CMake-based build system.
BamTools requires CMake (version >= 2.6.4). If you are missing CMake or have an older version, 
check your OS package manager (for Linux users) 
or download it here: http://www.cmake.org/cmake/resources/software.html .
 ```bash
  Note: To check is cmake is installed, run the following command: cmake --version

## Build BamTools
  # cd to the install root directory
  # mkdir build
  # cd build
  # cmake ..
  # make
  # cd ..
  
## Check the Install
There should be the bin/ , lib/ , and include/ subdirectories 
under the install root directory
