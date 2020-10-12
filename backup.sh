#!/bin/bash

#This bash script is used to backup a user's home directory to /Desktop

user=$(whoami)
input=/Users/$user/Documents
output=/Users/$user/Desktop/doc.tar.gz


tar -czf $output $input

echo "Backup of $input completed! Details about the output backup file:"
#ls -l $output



