# BLAT

Base directory to store Blat downloads scripts and config files

```
Blat produces two major classes of alignments:
* at the DNA level between two sequences that are of 95% or greater identity, but which may include large inserts.
* at the protein or translated DNA level between sequences that are of 80% or greater identity and may also include large inserts.

The main programs in the blat suite are:
 * gfServer – a server that maintains an index of the genome in memory and uses the index to quickly find regions with high levels of sequence similarity to a query sequence.
 * gfClient – a program that queries gfServer over the network and does a detailed alignment of the query sequence with regions found by gfServer.
 * blat – client and server combined into a single program, first building the index, then using the index, and then exiting.
```

## What do we download from Blat -- http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/blat/?

We download:

 * blat
 * gfClient
 * gfServer

## Upgrades Frequency

See: http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/blat/FOOTER.txt
Runs: On demand

## How to upgrade Jenkins
  
