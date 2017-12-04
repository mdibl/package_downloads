# Overview

Salmon is a wicked-fast program to produce a highly-accurate, transcript-level quantification estimates 
from RNA-seq data.
Salmon works by (quasi)-mapping sequencing reads directly to the transcriptome. 
This means the Salmon index should be built on a set of target transcripts,
not on the genome of the underlying organism.


## Obtaining Salmon

Once you’ve downloaded the appropriate binary (e.g. Salmon-0.8.1_linux_x86_64.tar.gz for a 64-bit Linux system), you simply decompress it like so:

```
 tar xzvf Salmon-0.8.1_linux_x86_64.tar.gz
```

The binary will be located in the bin directory inside of the uncompressed folder; 
for example Salmon-0.8.1_linux_x86_64/bin/salmon in the example above. 

You can either run salmon directly using the full path, or place it into your PATH variable for easier execution. 

See :

```
 1) https://github.com/COMBINE-lab/salmon/releases
 2) https://combine-lab.github.io/salmon/getting_started/#obtaining-salmon
```
