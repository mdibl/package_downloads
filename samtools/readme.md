# Building and installing
 See : https://github.com/samtools/samtools/blob/develop/INSTALL 
 
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
  * zlib library <http://zlib.net>
  * bzip2 library <http://bzip.org/>
  * curses or GNU ncurses library <http://www.gnu.org/software/ncurses/>

Notes: The bzip2 and liblzma dependencies can be removed if full CRAM support
is not needed - see HTSlib  INSTALL file for details.

``` 
## Configure and Install SamTools
```
  * cd to the install directory (/opt/software/external/samtools/samtools) then run:
  * ./configure --prefix=/opt/software
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

```
   - Copy libbam.a to the /opt/software/lib/ directory 
   - Create a directory called "bam" in the include/ directory (e.g. /opt/software/include/bam)
   - Copy the headers (files ending in .h) to the include/bam directory 
   - Copy the samtools binary to some directory in your PATH.

```
