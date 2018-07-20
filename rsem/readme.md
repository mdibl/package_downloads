# RSEM
 
This sub-directory contains:
 - [The Install Script](#the-install-script)(Install)
 - [The Package Config File](#the-package-config-file)(rsem_package.cfg)
 - [The Package Dependencies File](#the-package-dependencies-file)(semdependencies.cfg)

## USAGE: ./trigger_tool_install.sh tool_name [tool_version]

After installing the package_downloads repos 

See: https://github.com/mdibl/package_downloads/wiki/How-To-Install-This-Repos

**cd**  to package_downloads/ install root directory and run 
```

Example 1: ./trigger_tool_install.sh rsem
The above command tells the trigger script to install the current version of rsem

Example 2: ./trigger_tool_install.sh rsem v1.3.0
The above command tells the trigger script to install version v1.3.0
```

## The Install Script
 This script is called by the main install script 
(install_package.sh)  to build and install  a new version of the package 

### What it does:
  1) sources the main config file to set global path
  2) sources the dependencies config file
  3) runs the build and 
     a. copy  the executables to /opt/software/bin
    
 

### Note:
The following environment variables are expected to be set by the caller:

 1) GLOBAL_CONFIG  (Path to the main Configuration file
    ``` ${PACKAGE_DOWNLOADS_BASE}/Configuration ) ```
 2) PACKAGE_BASE   (Path to the new release install directory  ${EXTERNAL_SOFTWARE_BASE}/${SHORT_NAME}/${RELEASE_DIR})
 3) PACKAGE_DEPENDENCIES_FILE (The dependencies file for this tool  PACKAGE_DOWNLOADS_BASE/SHORT_NAME/


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
  
## The Package Dependencies File
Each tool's dependency file contains the pre-install and post-install sets of dependencies.
RSEM only uses few of these variables.

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

## Appendix:
```

 See : https://github.com/deweylab/RSEM 
 
Dependencies:
From their site, Prerequisites

C++, Perl and R are required to be installed.

To use the --gff3 option of rsem-prepare-reference, Python is also required to be installed.

To take advantage of RSEM's built-in support for 
the Bowtie/Bowtie2/STAR alignment program,
you must have Bowtie/Bowtie2/STAR installed.

bash
  Note: To check is cmake is installed,
  run the following command: cmake --version

```
## Building indexes
```
EXAMPLES
    1) Suppose we have mouse RNA-Seq data and want to use the UCSC mm9
    version of the mouse genome. We have downloaded the UCSC Genes
    transcript annotations in GTF format (as mm9.gtf) using the Table
    Browser and the knownIsoforms.txt file for mm9 from the UCSC Downloads.
    We also have all chromosome files for mm9 in the directory '/data/mm9'.
    We want to put the generated reference files under '/ref' with name
    'mouse_0'. We do not add any poly(A) tails. Please note that GTF files
    generated from UCSC's Table Browser do not contain isoform-gene
    relationship information. For the UCSC Genes annotation, this
    information can be obtained from the knownIsoforms.txt file. Suppose we
    want to build Bowtie indices and Bowtie executables are found in
    '/sw/bowtie'.

    There are two ways to write the command:

Suppose we want to build STAR indices in the above example and save
    index files under '/ref' with name 'mouse_0'. Assuming STAR executable
    is '/sw/STAR', the command will be:

 rsem-prepare-reference --gtf mm9.gtf \
                        --transcript-to-gene-map knownIsoforms.txt \
                        --star \
                        --star-path /sw/STAR \
                        -p 8 \
                        /data/mm9/chr1.fa,/data/mm9/chr2.fa,...,/data/mm9/chrM.fa \
                        /ref/mouse_0

```
