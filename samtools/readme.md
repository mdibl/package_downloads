# Building and installing
 See : https://github.com/samtools/samtools/blob/develop/INSTALL 
 
## Dependency
```
  * GNU make
  * C compiler (e.g. gcc or clang)
  * autoheader
  * autoconf
  
```
## Configure and Install SamTools
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
