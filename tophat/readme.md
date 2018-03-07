# Tophat

This sub-directory contains:
 - [The Package Config File](#the-package-config-file)(tophat_package.cfg)
 - [The Package Dependencies File](#the-package-dependencies-file)(tophat_dependencies.cfg)

Tophat is one of the tools we do not intall from source,instead we download binaries from the download site.
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
To install TopHat from source package, unpack the tarball and 
change directory to the package directory as follows:

* tar zxvf tophat-2.0.0.tar.gz
* cd tophat-2.0.0/
* Configure the package, specifying the install path and the library dependencies as needed 
  ./configure --prefix=install_prefix --with-boost=boost_install_prefix --with-bam=samtools_install_prefix

* Finally, build and install TopHat:
  ** make
  ** make install
```
