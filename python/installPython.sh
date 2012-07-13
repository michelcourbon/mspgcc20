#!/bin/bash

echo '****************************************************'
echo ' WiSMote Contiki tools - python tools installation  '
echo '****************************************************'


echo '******* enter the sudo password **********'
PYTOOLS_VERSION=python-msp430-tools-0.2
unzip $PYTOOLS_VERSION.zip
cd $PYTOOLS_VERSION
sudo python setup.py install
sudo cp -R ./msp430 /usr/local/lib/python2.7/dist-packages
cd ..
sudo rm -r $PYTOOLS_VERSION
cd ..

echo '************************************'
echo '**   add python pyserial module  ***'
echo '************************************'
PYSERIAL_VERSION=2.5
wget http://sourceforge.net/projects/pyserial/files/pyserial/$PYSERIAL_VERSION/pyserial-$PYSERIAL_VERSION.tar.gz
tar -xvzf pyserial-$PYSERIAL_VERSION.tar.gz 
cd pyserial-$PYSERIAL_VERSION/
sudo python setup.py install
cd ..
sudo rm -rf pyserial-$PYSERIAL_VERSION*

echo '***********************************'
echo '****    install done!!!!!!!!   ****' 



