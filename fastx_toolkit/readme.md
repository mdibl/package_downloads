The FASTX-Toolkit is a collection of command line tools for Short-Reads
FASTA/FASTQ files preprocessing.

# Building and installing
 See : http://hannonlab.cshl.edu/fastx_toolkit/download.html 
 
## Prerequisites
 * pkg-config
 * wget
 * Fastx-toolkit version 0.0.13 requires libgtextutils-0.6 (available here for download)
 * A recent g++ compiler (tested with GNU G++ 4.1.2 and later).
 * The fasta_clipping_histogram tool requires two perl modules: PerlIO::gzip and GD::Graph::bars.
 * The fastx_barcode_splitter tool requires GNU sed.
 * The fastq_quality_boxplot tool requires gnuplot version 4.2 or newer.

## Program Installation on CentOS
See: http://hannonlab.cshl.edu/fastx_toolkit/install_centos.txt

### First Install libgtextutils
 ```
 $ wget http://cancan.cshl.edu/labmembers/gordon/files/libgtextutils-0.7.tar.gz
 $ tar -xjf libgtextutils-0.7.tar.gz
 $ cd libgtextutils-0.6
 $ ./configure
 $ make
 $ sudo make install
 $ cd ..
 
 // Tell pkg-config to look for libraries in /usr/local/lib, too.
  export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig"


 ```

## Check the Install
There should be the executables in the bin folder is under the install root  directory

