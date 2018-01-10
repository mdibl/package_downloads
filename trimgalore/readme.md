# Trim Galore!

Trim Galore! is a wrapper around Cutadapt and FastQC to consistently apply adapter and quality trimming to FastQ files, with extra functionality for RRBS data.

## Installation

Trim Galore! is a a Perl wrapper around two tools: Cutadapt and FastQC. To use, ensure that these two pieces of software are available and copy the trim_galore script to a location available on the PATH.

For example:
```
   # Check that cutadapt is installed
   cutadapt --version
   # Check that FastQC is installed
   fastqc -v
   # Install Trim Galore!
   Download the tar file
   tar xvzf trim_galore.tar.gz
   mv TrimGalore-0.4.3/trim_galore /usr/bin
```

See: https://github.com/FelixKrueger/TrimGalore
