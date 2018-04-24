# Trimmomatic

This sub-directory contains:
 - [The Package Config File](#the-package-config-file)(trimmomatic_package.cfg)
 - [The Package Dependencies File](#the-package-dependencies-file)(trimmomatic_dependencies.cfg)

Trimmomatic is one of the tools we do not intall from source,instead we download binaries from the download site.
In addition, since we can't at the moment automate the porcess of getting the current version of this tool,
we run the install command with the version to install as argument.

```
  Example: 
   ./trigger_install.sh trimmomatic 0.36
```
  
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
  

## Appendix:
```
See: https://github.com/timflutre/trimmomatic
Installation
============

For the impatients:
	make
	make check
	make install

By default everything is installed in a directory bin/ in ${HOME}. 
If the bin/ directory does not exist, it will be created.
To install elsewhere, use the option INSTALL, for instance: 
	make install INSTALL="/usr/local/"
 
```
