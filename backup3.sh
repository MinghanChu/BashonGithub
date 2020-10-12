#!/bin/bash

# This bash script is used to backup a user's home directory to /Users/$user/Documents = /Users/minghanchu/Documents = $HOME/Documents Note $HOME is equivalent to /Users/minghanchu

#My understanding regarding with variables: $(variable) is like a string therefore can be replaced with "name"
user=$(whoami)

#Observations: a. counting number of directories includes the current directory
test_dir=$HOME/Documents/Zoom

input=$HOME/Documents/Zoom/test

#input=/Users/minghanchu/Documents

#Note even though the .tar.gz is not a directory but it is a location where
#content can be written into. It can be dealt with using command ls for listing files.
#output for tar command ends up with a file location
#while input ends up with a dirctory

output=/Users/$user/Desktop/${user}_home_$(date +%Y-%m-%d_%H%M%S).tar.gz

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


#If the user wants to save into the /tmp/ directory
#output=/tmp/${user}_home_$(date +%Y-%m-%d_%H%M%S).tar.gz

tar -czf $output $input 2> /dev/null

#(content/name) brackets are added to enclose a function or command
src_files=$( total_files $input )
src_directories=$( total_directories $input )

arch_files=$( total_archived_files $output )
arch_directories=$( total_archived_directories $output )

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

#The following lines are from older version
#echo -n "Files to be included:"
#total_files $output 


#echo -n "Directories to be included:"
#total_directories $output 
 
#echo "Backup of $input completed! Details about the output backup file:"
#ls -l $output

