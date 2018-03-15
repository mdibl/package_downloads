# Picard
 
This sub-directory contains:
 - [The Package Config File](#the-package-config-file)(picard_package.cfg)
 - [The Package Dependencies File](#the-package-dependencies-file)(picard_dependencies.cfg)

Picard is one of the tools we do not intall from source,instead we download binaries from the download site.
  
## The Package Dependencies File

Each tool's dependency file contains the pre-install and post-install sets of dependencies.
Blat only uses few of these variables.

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
  

## Appendix:
```
# Building and installing from source 

 See : http://broadinstitute.github.io/picard/ 
 
Building Picard From Source

First, clone the repos:
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
