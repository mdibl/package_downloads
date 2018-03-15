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
  2) move downloaded content where expected
  3) builds and install R
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

## Generate Installed Package Repeort

This is a wrapper script to call  R scripts that generates a list of 
user-installed R packages with the version installed

What it does: 
 - Call [Bioconductor Packages Update](#bioconductor-packages-update)(checkPackageUpdate.r) to 
  update the version of installed packages
 - Call [Installed Packages Report](#installed-packages-report)(genPackageReports.r) to gereate the report


## Bioconductor Packages Update

This R script runs the update command to update  Installed Bioconductor Packages.

## Installed Packages Report

This R script R lists all the packages installed and their versions.
A small step towards managing package versions. You could also use the first column to reinstall user-installed R packages after an R upgrade.


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
