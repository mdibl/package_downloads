# Fastqc


This sub-directory contains:
 - [The Package Config File](#the-package-config-file)(fastqc_package.cfg)
 - [The Package Dependencies File](#the-package-dependencies-file)(fastqc_dependencies.cfg)

Fastqc is one of the tools we do not intall from source,instead we download binaries from the download site.
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
 See : https://www.bioinformatics.babraham.ac.uk/projects/fastqc/
 
## Dependency
From their site: A suitable Java Runtime Environment 

## Running FastQC as part of a pipeline
------------------------------------
To run FastQC non-interactively you should use the fastqc wrapper script to launch
the program.  You will probably want to use the zipped install file on every platform
(even OSX).

To run non-interactively you simply have to specify a list of files to process
on the commandline

fastqc somefile.txt someotherfile.txt

You can specify as many files to process in a single run as you like.  If you don't
specify any files to process the program will try to open the interactive application
which may result in an error if you're running in a non-graphical environment.

There are a few extra options you can specify when running non-interactively.  Full
details of these can be found by running 

fastqc --help

By default, in non-interactive mode FastQC will create an HTML report with embedded
graphs, but also a zip file containing individual graph files and additional data files
containing the raw data from which plots were drawn.  The zip file will not be extracted
by default but you can enable this by adding:

--extract

To the launch command.

If you want to save your reports in a folder other than the folder which contained
your original FastQ files then you can specify an alternative location by setting a
--outdir value:

--outdir=/some/other/dir/

If you want to run fastqc on a stream of data to be read from standard input then you
can do this by specifing 'stdin' as the name of the file to be processed and then 
streaming uncompressed fastq format data to the program.  For example:

zcat *fastq.gz | fastqc stdin

Customising the report output
-----------------------------

If you want to run FastQC as part of a sequencing pipeline you may wish to change the
formatting of the report to add in your own branding or to include extra information.

In the Templates directory you will find a file called 'header_template.html' which
you can edit to change the look of the report.  This file contains all of the header for
the report file, including the CSS section and you can alter this however you see fit.

Whilst you can make whatever changes you like you should probably leave in place the
<div> structure of the html template since later code will expect to close the main div
which is left open at the end of the header.  There is no facility to change the code in
the main body of the report or the footer (although you can of course change the styling).

The text tags @@FILENAME@@ and @@DATE@@ are placeholders which are filled in when the
report it created.  You can use these placeholders in other parts of the header if you
wish.

```
