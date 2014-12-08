# used for handling common errors

function_error_noFile_declared () { 
	# if no $1 is set by user, then prompt for a file
	if [ "$1" == "" ] ; then
	function_userPrompt_selectFile
	fi
}

