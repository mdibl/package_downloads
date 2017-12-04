
See: https://pachterlab.github.io/kallisto/manual

```
kallisto is a program for quantifying abundances of transcripts from RNA-Seq data, 
or more generally of target sequences using high-throughput sequencing reads. 

It is based on the novel idea of pseudoalignment for rapidly determining the compatibility
of reads with targets,without the need for alignment. On benchmarks with standard RNA-Seq data,
kallisto can quantify 30 million human reads in less than 3 minutes on a Mac desktop computer 
using only the read sequences and a transcriptome index that itself takes less than 10 minutes to build.

Pseudoalignment of reads preserves the key information needed for quantification, and kallisto 
is therefore not only fast, but also as accurate as existing quantification tools. 

In fact, because the pseudoalignment procedure is robust to errors in the reads, 
in many benchmarks kallisto significantly outperforms existing tools. 
```
