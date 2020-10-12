#!/bin/bash

#Comment: This shell script can produce multiple zip files given the specified directory by the user: due to the fact that 
#this shell script is just a start-up for testing for (shell reserved word) loop functioning a lot more work needs to be 
#done to make it more efficient.
#currently this shell script is constrained to zipping the any folders under the directory: /Users/minghanchu/Documents/(), 
#inside the brackets the user can assign the interested folder name for being compressed. (I have tested Zoom and test folders)




# This bash script is used to backup a user's home directory to /Users/$user/Documents = /Users/minghanchu/Documents = $HOME/Documents Note $HOME is equivalent to /Users/minghanchu
function backup {

	path=$1 #it is ok to have more number of positional parameters than user input arguments. The missing input arguments for its corresponding positional parameters will be automatically ignored.
	echo "the input path is $path."

	# The following if statement: -z returns true if the variable $1 has a zero-string length, then set name of variable user be whoami. 
	if [ -z $1 ]; then
		user=$(whoami) #This is not suitable but just left it to be corrected/modified in the future

		#My understanding regarding with variables: $(variable) refers to a existing variable name, which can be replaced with "name" also serving as the dedicated name for variable
		else
		#Exclamation ! acts as a negator. -d option returns true if the directory exists, threfore ! -d just reverts the logic, that is, ture if the directory does not exist and false if the directory exists
									  #Note:Quotation mark is used to describe a path. 
		if [ ! -d "/Users/minghanchu/Documents/$path" ]; then 
			echo "Requested $path user minghanchu home directory doesn't exist."
			#1 here delibrately assigned exit value 1 (false) as opposed to 0 (true) meaning that the script exited with an error. Exit command causes script execuation.
			exit 1  
    	fi
		user=$path
	fi 



	#input=$HOME/Documents/Zoom/test

	# #user will take the command line arguments and assign to positional parameters, e.g. $1, stored as variables.  
	input=/Users/minghanchu/Documents/$user 


#Note even though the .tar.gz is not a directory but it is a location where
#content can be written into. It can be dealt with using command ls for listing files.
#output for tar command ends up with a file location
#while input ends up with a dirctory

	output=/Users/minghanchu/Desktop/${user}_$(date +%Y-%m-%d_%H%M%S).tar.gz

	#wc command lists number of files, just a number
	function total_files {
		find $1 -type f | wc -l
	}

	function total_directories {

		find $1 -type d | wc -l
	}

# /$ means all files under current directory, if only / is used nothing will be executed 
# grep /$ lists all directories
# grep -v /$ lists all files

	function total_archived_files {
		tar -tzf $1 | grep -v /$ | wc -l
	}

	function total_archived_directories {

		tar -tzf $1 | grep /$ | wc -l
	}


	tar -czf $output $input 2> /dev/null

#(content/name) brackets are added to enclose a function or command
	src_files=$( total_files $input )
	src_directories=$( total_directories $input )

	arch_files=$( total_archived_files $output )
	arch_directories=$( total_archived_directories $output )

	echo "############ $user ############"
	echo "Files to be included: $src_files"
	echo "Directories to be included: $src_directories"
	echo "Files archived: $arch_files"
	echo "Directories archived: $arch_directories"


#the following lines indicate that number of input files will be equal to that of individual files under their parent zip file
	if [ $src_files -eq $arch_files ]; then
		echo "Backup of $input completed!"
		echo "Details about the output backup file:"
		ls -l $output

	else 
		echo "Backup of $input failed!"
	fi

	}

for directory in $*; do
		backup $directory
		let all=$((all+arch_files+arch_directories)) #let command evaluates a mathematical expression and stores its result into a variable. In 
													 #this case, $all is the variable. Note $(()) form must be used or the error message: 
													 #syntax error: operand expected (error token is "+")
done;

		echo "TOTAL FILES AND DIRECTORIES: $all"

#The following lines are from older version
#echo -n "Files to be included:"
#total_files $output 


#echo -n "Directories to be included:"
#total_directories $output 
 
#echo "Backup of $input completed! Details about the output backup file:"
#ls -l $output

