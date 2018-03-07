# Trim Galore!

This sub-directory contains:
 - [The Package Config File](#the-package-config-file)(trimgalore_package.cfg)
 - [The Package Dependencies File](#the-package-dependencies-file)(trimgalore_dependencies.cfg)

Trimgalore is one of the tools we do not intall from source,instead we download binaries from the download site.
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
Trim Galore! is a wrapper around Cutadapt and FastQC to consistently apply adapter and quality trimming to FastQ files, with extra functionality for RRBS data.

## Installation

Trim Galore! is a a Perl wrapper around two tools: Cutadapt and FastQC. To use, ensure that these two pieces of software are available and copy the trim_galore script to a location available on the PATH.

For example:
   # Check that cutadapt is installed
   cutadapt --version
   # Check that FastQC is installed
   fastqc -v
   # Install Trim Galore!
   Download the tar file
   tar xvzf trim_galore.tar.gz
   mv TrimGalore-0.4.3/trim_galore /usr/bin

See: https://github.com/FelixKrueger/TrimGalore

```
