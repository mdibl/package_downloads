# BLAT


This sub-directory contains:
 - [The Package Config File](#the-package-config-file)(blat_package.cfg)
 - [The Package Dependencies File](#the-package-dependencies-file)(blat_dependencies.cfg)

Blat is one of the tools we do not intall from source,instead we download binaries from the download site.
The main install script then calls the install_binaries.sh script to copy the downloaded executables 
to the specified bin directory.


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
Blat produces two major classes of alignments:
* at the DNA level between two sequences that are of 95% or greater identity, but which may include large inserts.
* at the protein or translated DNA level between sequences that are of 80% or greater identity and may also include large inserts.

The main programs in the blat suite are:
 * gfServer – a server that maintains an index of the genome in memory and uses the index to quickly find regions with high levels of sequence similarity to a query sequence.
 * gfClient – a program that queries gfServer over the network and does a detailed alignment of the query sequence with regions found by gfServer.
 * blat – client and server combined into a single program, first building the index, then using the index, and then exiting.

What do we download from Blat -- http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/blat/?
We download:

 * FOOTER.txt ( contains info on the version)
 * blat
 * gfClient
 * gfServer

See: http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/blat/FOOTER.txt

```

