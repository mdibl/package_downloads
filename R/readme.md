# R

# Bamtools
 
This sub-directory contains:
 - [The Install Script](#the-install-script)(Install)
 - [The Package Config File](#the-package-config-file)(bamttols_package.cfg)
 - [The Package Dependencies File](#the-package-dependencies-file)(bamttols_dependencies.cfg)

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

## Appendix:
```
R is a free software environment for statistical computing and graphics. It compiles and runs on a wide variety of UNIX platforms, Windows and MacOS.

## What do we download from R -- https://cran.r-project.org/src/base/?

We download:

 * VERSION-INFO.dcf ( contains info on the version)
 * R-latest.tar.gz

## Install Bioconductor Packages

Bioconductor provides tools for the analysis and comprehension of high-throughput genomic data. 
Use the biocLite.R script to install Bioconductor packages.

To install core packages, type the following in an R command window:
   > source("https://bioconductor.org/biocLite.R")
   > biocLite()


To Install specific packages, e.g., “GenomicFeatures” and “AnnotationDbi”

   > biocLite(c("GenomicFeatures", "AnnotationDbi"))
See: http://bioconductor.org/install/

## Get The List Of Installed Packages
To get the list of installed R packages, type the following in an R command window:
  > installed.packages()
  
```
