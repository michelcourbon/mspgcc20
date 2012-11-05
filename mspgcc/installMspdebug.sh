#!/bin/bash

# before execute this macro.. 
#    see at the url http://sourceforge.net/projects/mspdebug/files/ 
#    to control latest version .......

echo '************************************************'
echo ' WiSMote Contiki tools - mspdebug installation  '
echo '************************************************'

MSPDEBUG_VERSION=0.20

wget http://sourceforge.net/projects/mspdebug/files/mspdebug-$MSPDEBUG_VERSION.tar.gz
tar -xvzf mspdebug-$MSPDEBUG_VERSION.tar.gz 
cd mspdebug-$MSPDEBUG_VERSION/
sudo apt-get install libusb-dev
make WITHOUT_READLINE=1
sudo make install
sudo rm -r mspdebug-$MSPDEBUG_VERSION/
rm mspdebug-$MSPDEBUG_VERSION.tar.gz

echo '*******************************'
echo '  install done ? '
mspdebug --version



