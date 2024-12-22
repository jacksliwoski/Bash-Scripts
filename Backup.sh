#!/bin/bash
# the purpose of this script is to backup files into a backup folder

echo "Welcome to the Backup Script"

function Backup_Sequence() {
  # prompt for preferred backup location 
    echo "Input backup directory"
    read BackupDir
    
    # check if backup directory exists, if not create it
    if [ ! -d "$BackupDir" ]
      then
        mkdir -p "$BackupDir"
    fi
}

# prompt user for directory to backup
echo "Input directory of files you'd like to backup"
read SourceDir

#check if source directory exists, if not notify user and exit script
if [ ! -d "$SourceDir" ]
  then
    echo "Error: '$SourceDir' does not exist or is not a directory."
    exit 1
fi

# go through files in to be backed up dir 
for filename in "$SourceDir"/*
  #list files
  do 
    echo $filename
done

# make sure user wants all or a certain type of file backed up
echo "Would you like to backup all of these files or just a certain type? (1 for all)/(2 for specify type)"
read AllorType

# sequence for all files
if [ $AllorType -eq 1 ]
  then
    # prompt for preferred backup location & check if backup directory exists, if not create it
    Backup_Sequence

    #backup all files to backup location
    cp "$SourceDir"/* "$BackupDir"

    #verify backup contents
    cd "$BackupDir"
    echo "Backup Directory Contains:"
    ls

  # sequence for only specific file type
  elif [ $AllorType -eq 2 ]
    then
    # prompt for ext type of files they'd like to backup i.e. .txt
    echo "Input the file extension of the type of files you'd like to backup - ex. txt for text files"
    read extension

    # prompt for preferred backup location & check if backup directory exists, if not create it
    Backup_Sequence

    # backup specified file type to backup dir
    cp "$SourceDir"/*."$extension" "$BackupDir"

    #verify backup contents
    cd "$BackupDir"
    echo "Backup Directory Contains:"
    ls
    
  else
    echo "You have exited this script"
fi
