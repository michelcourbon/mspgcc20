#!/bin/bash
function error()
{
echo 'An error has occured'
echo 'Please check that the WiSMote is well connected to an jTAG supported by mspdebug'
echo '(olimex, FET430UIF...)'
echo 'hit a key to finish'
read -n 1 ch
exit
}

# injection script

echo '************************************************'
echo ' WiSMote Contiki tools'
echo ' UID in memory injection Script'
echo '************************************************'

trap error ERR

sudo mspdebug -q olimex "load ~/mspgcc20/BSL/uid-n2.txt"

echo 'UID has been successfully injected'
echo 'hit a key'
read -n 1 ch
