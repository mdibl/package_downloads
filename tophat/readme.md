## Obtaining and installing TopHat

To install TopHat from source package, unpack the tarball and 
change directory to the package directory as follows:

* tar zxvf tophat-2.0.0.tar.gz
* cd tophat-2.0.0/
* Configure the package, specifying the install path and the library dependencies as needed 
  ./configure --prefix=install_prefix --with-boost=boost_install_prefix --with-bam=samtools_install_prefix

* Finally, build and install TopHat:
  ** make
  ** make install
