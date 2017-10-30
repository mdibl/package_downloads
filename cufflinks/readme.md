## Building Cufflinks

Unpack the Cufflinks source tarball (in this example for version 2.2.1):
```
tar zxvf cufflinks-2.2.1.tar.gz
```
Change to the Cufflinks directory:
```
cd cufflinks-2.2.1
```
## To configure Cufflinks prior to the build

If Boost is installed somewhere other than /usr/local, you will need to tell the installer where to find it using the --with-boost option. Specify where to install Cufflinks using the --prefix option.

```
./configure --prefix=/path/to/cufflinks/install --with-boost=/path/to/boost --with-eigen=/path/to/eigen
```

If you see any errors during configuration, verify that you are using Boost version 1.47 or higher, and that the directory you specified via --with-boost contains the boost header files and libraries. See the Boost Getting started page for more details. If you copied the SAM tools binaries to someplace other than /usr/local/, you may need to supply the --with-bam configuration option. Finally, make and install Cufflinks.

```
  make
