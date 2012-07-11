#!/bin/bash

echo '************************************************'
echo ' WiSMote Contiki tools - mspdebug installation  '
echo '************************************************'

MSPDEBUG_VERSION=0.19

wget http://sourceforge.net/projects/mspdebug/files/mspdebug-$MSPDEBUG_VERSION.tar.gz
tar -xvzf mspdebug-$MSPDEBUG_VERSION.tar.gz 
cd mspdebug-$MSPDEBUG_VERSION/
sudo apt-get install libusb-dev
make WITHOUT_READLINE=1
sudo make install

echo '*******************************'
echo '  install done ? '
mspdebug --version



