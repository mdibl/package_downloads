# Salmon 

This sub-directory contains:
 - [The Package Config File](#the-package-config-file)(salmon_package.cfg)
 - [The Package Dependencies File](#the-package-dependencies-file)(salmon_dependencies.cfg)

Salmon is one of the tools we do not intall from source,instead we download binaries from the download site.
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
Salmon is a wicked-fast program to produce a highly-accurate, transcript-level quantification estimates 
from RNA-seq data.
Salmon works by (quasi)-mapping sequencing reads directly to the transcriptome. 
This means the Salmon index should be built on a set of target transcripts,
not on the genome of the underlying organism.

## Obtaining Salmon
Once you’ve downloaded the appropriate binary (e.g. Salmon-0.8.1_linux_x86_64.tar.gz for a 64-bit Linux system), you simply decompress it like so:

 tar xzvf Salmon-0.8.1_linux_x86_64.tar.gz

The binary will be located in the bin directory inside of the uncompressed folder; 
for example Salmon-0.8.1_linux_x86_64/bin/salmon in the example above. 
You can either run salmon directly using the full path, or place it into your PATH variable for easier execution. 

See :
 1) https://github.com/COMBINE-lab/salmon/releases
 2) https://combine-lab.github.io/salmon/getting_started/#obtaining-salmon
```
