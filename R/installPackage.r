#!/opt/software/bin/Rscript

#This R commands Update Installed Bioconductor Packages 
#
# Credit: https://bioconductor.org/install/ 
#
source("https://bioconductor.org/biocLite.R")
biocLite(ask=FALSE)
biocLite("openssl")   #one of sleuth's dependencies
biocLite(c("GenomicFeatures", "AnnotationDbi"))
biocLite(c("DESeq","DESeq2"))
biocLite("devtools")    #one of sleuth's dependencies
biocLite("RMySQL")  #one of RUVSeq's dependencies
biocLite("pasilla")
biocLite("remotes") #one of sleuth's dependencies
biocLite("pachterlab/sleuth")
biocLite("RUVSeq")
biocLite("configr")
biocLite(c("config","edge"))                           
