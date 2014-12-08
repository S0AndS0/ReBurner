

function_CompressEncryptKey_file () {
	# Compress and Encrypt a file or directory with a password
	# and convert that output directly into a file that can be used to generate
	# Bitcoin privet hex Keys
	tar c $userInput_selectedFile | opensssl enc -aes-256-cbc -e > BTCkeys_privetHex.tar.enc
}

function_SHA256convertHEXkeys_file () {
	# use the BTCkeys_privetHex.tar.enc.txt hex values
	# and calculate thier SHA256 Keys
	
}


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



