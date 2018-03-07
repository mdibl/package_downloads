# R

This sub-directory contains:
 - [The Install Script](#the-install-script)(Install)
 - [The Package Config File](#the-package-config-file)(bamttols_package.cfg)
 - [The Package Dependencies File](#the-package-dependencies-file)(bamttols_dependencies.cfg)
 - [Generate Installed Package Repeort](#generate-installed-package-repeort)(genPackageReports.sh)
 - [Bioconductor Packages Update](#bioconductor-packages-update)(checkPackageUpdate.r)
 - [Installed Packages Report](#installed-packages-report)(genPackageReports.r)
 

## The Install Script
 This script is called by the main install script 
(install_package.sh)  to build and install  a new version of the package 

### What it does:
  1) sources the main config file to set global path
  2) move downloaded content where expected
  3) builds and install R
     a. copy  the executables to SOFTWARE_BASE/bin
     b. copy  the libraries to SOFTWARE_BASE/lib[64]
     c. copy  the include to SOFTWARE_BASE/include
 

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
