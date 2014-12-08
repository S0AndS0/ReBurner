# used if required commandline options where not declaired or if an error is caught.

function_userPrompt_selectFile () {
	# request file to be converted if not selected on the command line
	ls
	echo -n "Select a file to be converted"
	read userInput_selectedFile
	echo "$userInput_selectedFile"
}

function_userPrompt_selectFormat () { 
	# select if file neads to be pre-converted; compressed and chopped or just converted to privet keys.
	
	
} 
