# Stringtie

This sub-directory contains:
 - [The Package Config File](#the-package-config-file)(stringtie_package.cfg)
 - [The Package Dependencies File](#the-package-dependencies-file)(stringtie_dependencies.cfg)

Stringtie is one of the tools we do not intall from source,instead we download binaries from the download site.
The main install script then calls the install_binaries.sh script to copy the downloaded executable
to the specified bin directory as specified in this package's global configuration file


## The Package Config File 
The config file sets environment variables specific to this tool.
Some key variables include:

  - SHORT_NAME  (same as the name of the tool local directory)
  - REMOTE_SITE
  - REMOTE_DIR
  - REPOS_TAG_PATTERN
  - REMOTE_URL
  - REMOTE_VERSION_FILE
  - VERSION_PREFIX
  - VERSION_SUFFIX
  - EXP_PREFIX
  - RELEASE_DIR
  - EXPORT_GIT
  - CLONE_GIT
  - BINARIES_INSTALL
  
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

## Apendix:


```
Stringtie:

StringTie is a fast and highly efficient assembler of RNA-Seq alignments into potential transcripts. 
It uses a novel network flow algorithm as well as an optional de novo assembly step to assemble and 
quantitate full-length transcripts representing multiple splice variants for each gene locus. 

Its input can include not only the alignments of raw reads used by other transcript assemblers, 
but also alignments longer sequences that have been assembled from those reads.

In order to identify differentially expressed genes between experiments,
StringTie's output can be processed by specialized software like Ballgown, 
Cuffdiff or other programs (DESeq2, edgeR, etc.).

The main input of the program is a BAM file with RNA-Seq read mappings 
which must be sorted by their genomic location (for example the accepted_hits.
bam file produced by TopHat or the output of HISAT2 after sorting and converting it using samtools). 


See: http://ccb.jhu.edu/software/stringtie/index.shtml?t=manual#run
     http://ccb.jhu.edu/software/stringtie/#install
```
  
