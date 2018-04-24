
# Bwa
 
This sub-directory contains:
 - [The Install Script](#the-install-script)(Install)
 - [The Package Config File](#the-package-config-file)(bwa_package.cfg)
 - [The Package Dependencies File](#the-package-dependencies-file)(bwa_dependencies.cfg)

## USAGE: ./trigger_tool_install.sh tool_name [tool_version]

After installing the package_downloads repos 

See: https://github.com/mdibl/package_downloads/wiki/How-To-Install-This-Repos

**cd**  to package_downloads/ install root directory and run 
```

Example 1: ./trigger_tool_install.sh bwa
The above command tells the trigger script to install the current version of bwa

Example 2: ./trigger_tool_install.sh bwa v0.7.16 
The above command tells the trigger script to install version v0.7.16 
```

## The Install Script
 This script is called by the main install script 
(install_package.sh)  to build and install  a new version of the package 

### What it does:
  1) sources the main config file to set global path
  2) sources the dependencies config file
  3) runs the build and copy the executables to /opt/software/bin

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
Bwa only uses few of these variables.

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

BWA is a software package for mapping DNA sequences against a large reference genome, such as the human genome.
It consists of three algorithms: BWA-backtrack, BWA-SW and BWA-MEM. 
The first algorithm is designed for Illumina sequence reads up to 100bp, 
while the rest two for longer sequences ranged from 70bp to a few megabases.

BWA-MEM and BWA-SW share similar features such as the support of long reads and chimeric alignment, 
but BWA-MEM, which is the latest, is generally recommended as it is faster and more accurate. 

BWA-MEM also has better performance than BWA-backtrack for 70-100bp Illumina reads. 

See:
1) https://github.com/lh3/bwa
2) http://www.htslib.org/workflow/#mapping_to_variant
```
