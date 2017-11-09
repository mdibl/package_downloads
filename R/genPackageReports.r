#!/opt/software/bin/Rscript

#installed.packages(c("Package","Version"))
#This R command lists all the packages installed by the user (ignoring packages that come with R such as base and foreign) and the package versions.
# This is a small step towards managing package versions: for a better solution, see the checkpoint package. 
# You could also use the first column to reinstall user-installed R packages after an R upgrade.
#
# Credit: https://www.r-bloggers.com/list-of-user-installed-r-packages-and-their-versions/
#

ip <- as.data.frame(installed.packages()[,c(1,3:4)])
rownames(ip) <- NULL
ip <- ip[is.na(ip$Priority),1:2,drop=FALSE]
print(ip, row.names=FALSE)
