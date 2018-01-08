# Building and installing
 See : https://www.bioinformatics.babraham.ac.uk/projects/fastqc/
 
## Dependency
From their site: A suitable Java Runtime Environment 

## Build fastqc
```
  Linux:  They have included a wrapper script, called 'fastqc' which is the easiest way to
start the program.  The wrapper is in the top level of the FastQC installation.  You
may need to make this file executable:

chmod 755 fastqc

..but once you have done that you can run it directly

./fastqc

..or place a link in /usr/local/bin to be able to run the program from any location:

sudo ln -s /path/to/FastQC/fastqc /opt/software/bin/fastqc


 ```
## Check the Install
There should be the executable fastqc is under the install root directory

## Running FastQC
--------------

You can run FastQC in one of two modes, either as an interactive graphical application
in which you can dynamically load FastQ files and view their results.

Alternatively you can run FastQC in a non-interactive mode where you specify the files
you want to process on the command line and FastQC will generate an HTML report for
each file without launching a user interface.  This would allow FastQC to be run as
part of an analysis pipeline.

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

