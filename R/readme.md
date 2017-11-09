# R

Base directory to store R downloads scripts and config files

```
R is a free software environment for statistical computing and graphics. It compiles and runs on a wide variety of UNIX platforms, Windows and MacOS.
```

## What do we download from R -- https://cran.r-project.org/src/base/?

We download:

 * VERSION-INFO.dcf ( contains info on the version)
 * R-latest.tar.gz

## Upgrades Frequency

See: https://cran.r-project.org/src/base/VERSION-INFO.dcf

Runs: weekly

## How to Install R
  * See: https://cran.r-project.org/src/base/INSTALL

# R Packages -  
## Install Bioconductor Packages

Bioconductor provides tools for the analysis and comprehension of high-throughput genomic data. 
Use the biocLite.R script to install Bioconductor packages.

To install core packages, type the following in an R command window:
```
   > source("https://bioconductor.org/biocLite.R")
   > biocLite()
``` 

To Install specific packages, e.g., “GenomicFeatures” and “AnnotationDbi”
```
   > biocLite(c("GenomicFeatures", "AnnotationDbi"))
```
See: http://bioconductor.org/install/

## Get The List Of Installed Packages
To get the list of installed R packages, type the following in an R command window:
```
  > installed.packages()
  
```
