#!/bin/bash

# before execute this macro.. 
#    see at the url http://sourceforge.net/projects/mspgcc/files/mspgcc/DEVEL-4.7.x/
#    to control latest version ....... and if this release are up to date


#Install linux software package pre-requisites
echo '************************************************'
echo '***     linux package before installation   ****'
sudo apt-get update
sudo apt-get install make wget patch git texinfo libncurses5-dev zlibc zlib1g-dev libx11-dev libusb-dev libreadline6-dev flex

# to update verify the project's date on sourceforge
BINUTILDate=20120911
GCCDate=20120911
MCUDate=20120716
LIBCDate=20120716

#Retrieve the files
wget http://sourceforge.net/projects/mspgcc/files/mspgcc/DEVEL-4.7.x/mspgcc-$GCCDate.tar.bz2
wget http://sourceforge.net/projects/mspgcc/files/msp430mcu/msp430mcu-$MCUDate.tar.bz2
wget http://sourceforge.net/projects/mspgcc/files/msp430-libc/msp430-libc-$LIBCDate.tar.bz2
wget http://ftpmirror.gnu.org/binutils/binutils-2.22.tar.bz2
wget http://mirror.ibcp.fr/pub/gnu/gcc/gcc-4.7.0/gcc-4.7.0.tar.bz2

#Create a temporary build directory
mkdir msp430-build

#copy all the downloaded files into here
mv *.tar.bz2 msp430-build/
cd msp430-build

# extract all the following files into the msp430-build directory
tar xvfj binutils-2.22.tar.bz2
tar xvfj gcc-4.7.0.tar.bz2
tar xvfj mspgcc-$GCCDate.tar.bz2
tar xvfj msp430mcu-$MCUDate.tar.bz2
tar xvfj msp430-libc-$LIBCDate.tar.bz2

# install gcc prerequisites
echo '---------------------------'
echo '---   gcc ?????????    ----'
cd gcc-4.7.0
./contrib/download_prerequisites
cd ..

echo '---------------------------------'
echo '---       binutils           ----'
echo '--- press any key to continue ---'
read test
# patch binutils
cd binutils-2.22
patch -p1<../mspgcc-$GCCDate/msp430-binutils-2.22-$BINUTILDate.patch
cd ..

echo '---- patch the gcc ----'
# patch GCC to bring it up to latest Release 
cd gcc-4.7.0
patch -p1<../mspgcc-$GCCDate/msp430-gcc-4.7.0-$GCCDate.patch
cd ..

#Create a sub-set of Build Directories
mkdir binutils-2.22-msp430
mkdir gcc-4.7.0-msp430

# Configure Binutils
cd binutils-2.22-msp430
# We need to build binutils for the msp430
../binutils-2.22/configure --target=msp430 --program-prefix="msp430-"
make
# Do the install as root (e.g., sudo)
echo '----------- be carefull : enter the password -------------'
sudo make install

echo '---------------------------------'
echo '---    gcc compilation       ----'
echo '--- press any key to continue ---'
read test
#Configure GCC
cd ../gcc-4.7.0-msp430
../gcc-4.7.0/configure --target=msp430 --enable-languages=c --program-prefix="msp430-"
make
# Do the install as root (e.g., sudo)
echo'----------- be carefull : enter the password -------------'
sudo make install

echo '-----------------------------------------'
echo '---  install msp430mcu & mspgcc-libc  ---'
echo '---  press any key to continue        ---'
read test

#Install the mspgcc-mcu files
cd ../msp430mcu-$MCUDate
sudo MSP430MCU_ROOT=`pwd` ./scripts/install.sh /usr/local/

# Install the mspgcc-libc
cd ../msp430-libc-$LIBCDate
cd src
make
# Do the install as root (e.g., sudo)
sudo PATH=$PATH make PREFIX=/usr/local install
cd ..
