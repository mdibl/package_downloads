

# Kallisto


This sub-directory contains:
 - [The Package Config File](#the-package-config-file)(kallisto_package.cfg)
 - [The Package Dependencies File](#the-package-dependencies-file)(kallisto_dependencies.cfg)

Kallisto is one of the tools we do not intall from source,instead we download binaries from the download site.
The main install script then calls the install_binaries.sh script to copy the downloaded includes 
to the specified include directory as specified in this package's global configuration file


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
See: https://pachterlab.github.io/kallisto/manual

kallisto is a program for quantifying abundances of transcripts from RNA-Seq data, 
or more generally of target sequences using high-throughput sequencing reads. 

It is based on the novel idea of pseudoalignment for rapidly determining the compatibility
of reads with targets,without the need for alignment. On benchmarks with standard RNA-Seq data,
kallisto can quantify 30 million human reads in less than 3 minutes on a Mac desktop computer 
using only the read sequences and a transcriptome index that itself takes less than 10 minutes to build.

Pseudoalignment of reads preserves the key information needed for quantification, and kallisto 
is therefore not only fast, but also as accurate as existing quantification tools. 

In fact, because the pseudoalignment procedure is robust to errors in the reads, 
in many benchmarks kallisto significantly outperforms existing tools. 
```
