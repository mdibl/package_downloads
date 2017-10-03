# Building and installing
 See : https://github.com/samtools/htslib/blob/develop/INSTALL
 
## Dependency
### Programs:
```
  * GNU make
  * C compiler (e.g. gcc or clang)
  * autoheader
  * autoconf
  
```
### Libraries:
```
  * libz       (required)
    libbz2     (required, unless configured with --disable-bz2)
    liblzma    (required, unless configured with --disable-lzma)
    libcurl    (optional, but strongly recommended)
    libcrypto  (optional for Amazon S3 support; not needed on MacOS)

``` 
## Configure and Install Htslib
```
  * cd to the install directory (/opt/software/external/samtools) then run:
  * ./configure --prefix=/opt/software/external/samtools
  * make 
  * make install
 ```
## Check the Install
There should be the bin/ , lib/ , and include/ subdirectories 
under the install root directory

```
 samtools/bin
 samtools/lib
 samtools/share/man
```
