
# This bash script is used to backup a user's home directory to /Users/$user/Documents = /Users/minghanchu/Documents = $HOME/Documents Note $HOME is equivalent to /Users/minghanchu

#My understanding regarding with variables: $(variable) is like a string therefore can be replaced with "name"
user=$(whoami)

#Observations: a. counting number of directories includes the current directory
test_dir=$HOME/Documents/Zoom

input=$HOME/Documents

#input=/Users/minghanchu/Documents

#Note even though the .tar.gz is not a directory but it is a location where
#content can be written into. It can be dealt with using command ls for listing files.
#output for tar command ends up with a file location
#while input ends up with a dirctory

output=/Users/$user/Desktop/${user}_home_$(date +%Y-%m-%d_%H%M%S).tar.gz

function total_files {
	find $1 -type f | wc -l
}

function total_directories {

	find $1 -type d | wc -l
}


#If the user wants to save into the /tmp/ directory
#output=/tmp/${user}_home_$(date +%Y-%m-%d_%H%M%S).tar.gz

tar -czf $output $input 2> /dev/null

echo -n "Files to be included:"
total_files $output 


echo -n "Directories to be included:"
total_directories $output 
 
echo "Backup of $input completed! Details about the output backup file:"
ls -l $output
