# About STAR

SEE: https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf

## COMPILING FROM SOURCE

To compile STAR from source, you must first download the latest release and uncompress it and then build it.

Linux

# Get latest STAR source from releases
wget https://github.com/alexdobin/STAR/archive/2.5.3a.tar.gz
tar -xzf 2.5.3a.tar.gz
cd STAR-2.5.3a

# Alternatively, get STAR source using git
git clone https://github.com/alexdobin/STAR.git
cd STAR/source

# Build STAR
make STAR

# To include STAR-Fusion
git submodule update --init --recursive

# If you have a TeX environment, you may like to build the documentation
make manual
