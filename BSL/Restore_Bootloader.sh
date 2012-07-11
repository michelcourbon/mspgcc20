#!/bin/bash

function error()
{
echo 'An error has occured'
echo 'Please check that the WiSMote is well connected to an jTAG supported by mspdebug'
echo '(olimex, FET430UIF...)'

read -n 1 ch
exit
}

echo '************************************************'
echo 'Arago Systems - WiSMote Contiki tools'
echo 'WiSMote BSL restore Script'
echo '************************************************'

trap error ERR

sudo mspdebug -q olimex "prog /home/arago/backup/wismote_bootloader.2011.09.02.txt"

echo 'Bootloader has been successfully restored'
echo 'hit a key'

read -n 1 ch


echo '************************************************'
echo 'for further informations please contact Arago '
echo 'Systems at wismote@aragosystems.com'
