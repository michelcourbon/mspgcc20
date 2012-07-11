#!/bin/bash

echo '****************************************************'
echo ' WiSMote Contiki tools - python tools installation  '
echo '****************************************************'


echo '******* enter the sudo password **********'
cd python-msp430-tools-0.3
sudo python setup.py install
sudo rm -rf build
sudo chmod +x /usr/local/lib/python2.7/dist-packages/msp430/*.*
cd ..

PYSERIAL_VERSION=2.5
wget http://sourceforge.net/projects/pyserial/files/pyserial/$PYSERIAL_VERSION/pyserial-$PYSERIAL_VERSION.tar.gz
tar -xvzf pyserial-$PYSERIAL_VERSION.tar.gz 
cd pyserial-$PYSERIAL_VERSION/
sudo python setup.py install
cd ..
sudo rm -rf pyserial-$PYSERIAL_VERSION*

echo 'install done!!!!!!!!'



