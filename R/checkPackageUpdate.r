#!/opt/software/bin/Rscript

#This R commands Update Installed Bioconductor Packages 
#
# Credit: https://bioconductor.org/install/ 
#
source("https://bioconductor.org/biocLite.R")
biocLite(ask=FALSE)  
