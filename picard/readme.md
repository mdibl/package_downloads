# Picard
 
This sub-directory contains:
 - [The Install Script](#the-install-script)(Install)
 - [The Package Config File](#the-package-config-file)(picard_package.cfg)
 - [The Package Dependencies File](#the-package-dependencies-file)(picard_dependencies.cfg)

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

## Appendix:
```
# Building and installing
 See : https://github.com/samtools/samtools/blob/develop/INSTALL 
 
Building Picard

First, clone the repo:
    git clone https://github.com/broadinstitute/picard.git
    cd picard/
Picard is now built using gradle. A wrapper script (gradlew) is included which will download the appropriate version of gradle on the first invocation.

To build a fully-packaged, runnable Picard jar with all dependencies included, run:

    ./gradlew shadowJar
The resulting jar will be in build/libs. To run it, the command is:
    java -jar build/libs/picard.jar
    
    or
    
    java -jar build/libs/picard-<VERSION>-all.jar 
To build a jar containing only Picard classes (without its dependencies), run:
    ./gradlew jar
To clean the build directory, run:
    ./gradlew clean
Running Tests

To run all tests, the command is:
    ./gradlew test
To run a specific test, the command is:
    ./gradlew test -Dtest.single=TestClassName 

```
