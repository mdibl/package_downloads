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

