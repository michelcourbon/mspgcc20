#Install pre-requisites
sudo apt-get update
sudo apt-get install make wget patch git texinfo libncurses5-dev zlibc zlib1g-dev libx11-dev libusb-dev libreadline6-dev flex

#Retrieve the files
wget http://sourceforge.net/projects/mspgcc/files/mspgcc/DEVEL-4.7.x/mspgcc-20120606.tar.bz2
wget http://sourceforge.net/projects/mspgcc/files/msp430mcu/msp430mcu-20120606.tar.bz2
wget http://sourceforge.net/projects/mspgcc/files/msp430-libc/msp430-libc-20120606.tar.bz2
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
tar xvfj mspgcc-20120606.tar.bz2
tar xvfj msp430mcu-20120606.tar.bz2
tar xvfj msp430-libc-20120606.tar.bz2

# install gcc prerequisites
echo '---------------------------'
echo '---   gcc ?????????    ----'
cd gcc-4.7.0
./contrib/download_prerequisites
cd ..

echo '---------------------------------'
echo '---       binutils           ----'
echp '--- press any key to continue ---'
read test
# patch binutils
cd binutils-2.22
patch -p1<../mspgcc-20120606/msp430-binutils-2.22-20120606.patch
cd ..

# patch GCC to bring it up to Release 20120606
cd gcc-4.7.0
patch -p1<../mspgcc-20120606/msp430-gcc-4.7.0-20120606.patch
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
echo'----------- be carefull : enter the password -------------'
sudo make install

echo '---------------------------------'
echo '---    gcc compilation       ----'
echp '--- press any key to continue ---'
read test
#Configure GCC
cd ../gcc-4.7.0-msp430
../gcc-4.7.0/configure --target=msp430 --enable-languages=c --program-prefix="msp430-"
make
# Do the install as root (e.g., sudo)
echo'----------- be carefull : enter the password -------------'
sudo make install

#Install the mspgcc-mcu files
cd ../msp430mcu-20120606
sudo MSP430MCU_ROOT=`pwd` ./scripts/install.sh /usr/local/

# Install the mspgcc-libc
cd ../msp430-libc-20120606
cd src
make
# Do the install as root (e.g., sudo)
sudo PATH=$PATH make PREFIX=/usr/local install
cd ..
