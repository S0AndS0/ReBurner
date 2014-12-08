#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin ; export PATH 

echo "Setting variables"
# set user and home variables
 : ${USER?} ${HOME?}
# find the name of this script and store it to a variable
main_scriptPath="$(readlink -f $0)"
# delete last component from the above variable and store to another variable
main_scriptDirectory="$(dirname $main_scriptPath)"
# now $main_scriptDirectory can be used in file paths to inport fuctions from other files
# inport ALL functions from the Functions directory
#./$main_scriptDirectory/*

# $1 is set by running this script with a file declaired
# ./reburner.sh <fileName>
# Original author of one liners was found at http://www.commandlinefu.com/commands/by/nixnax
# Be sure to thank them
fileTo_beReburned="$1"

echo "Translating file into Bitcoin privet keys..."

# wallet functions
function b58encode () { local b58_lookup_table=({1..9} {A..H} {J..N} {P..Z} {a..k} {m..z}); bc<<<"obase=58;ibase=16;${1^^}"|(read -a s; for b58_index in "${s[@]}" ; do printf %s ${b58_lookup_table[ 10#"$b58_index" ]}; done); }

function wallet_exponent () { hexdump -v -e '/1 "%02X"' $fileTo_beReburned | sed 's/.\{64\}/&\n/g' | while read x ; do echo -n "$x" | sha256sum ; done | sed 's/  -//g' ; }
function wallet_checksum () { hexdump -v -e '/1 "%02X"' $fileTo_beReburned | sed 's/.\{64\}/&\n/g' | while read x ; do echo -n "$x" | sha256sum ; done | sed 's/  -//g' | sed 's/^/x80/' | $o ) | $o | sha256sum|cut -b1-8 ); }
#	o='openssl sha256 -binary'; 
#	p='printf';
#	(
#		$p %b "\x80";$p %s "$@"|$o
#		)|$o|sha256sum|cut -b1-8
#	); }
#	# %b = Print the associated argument while interpreting backslash escapes in there
#	# %s = Print the associated argument as unsigned hexadecimal number with lower-case hex-digits (a-f)

# bellow command neads to be wrapped in a looping expression like above... hopefully this works.
while read x ; do (b58encode 80$( wallet_exponent "" )$( wallet_checksum "" )) | tee -a $main_scriptDirectory/keyDir/reburnerKeys.txt ; done


