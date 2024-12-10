#!/bin/bash
#the purpose of this script is to copy certain files from a source directory into a build directory for releasing a "build"

echo "Welcome to the Build Script"

#verify change log update

#create variable for file header containing version number
firstline=$(head -n 1 source/changelog.md)
#to remove markdown formatting 
read -a splitfirstline <<< $firstline

#accessing and saving only the vversion value we need to a variable
version=${splitfirstline[1]}

#print version 
echo "Build Version" $version

#verify correct build version with user
echo -e "Is the build version correct? \nType 1 for yes, Type 2 for no"
read versioncontinue
#if yes continue, if no quit
if [ $versioncontinue -eq 1 ]
  then
    echo "OK"
    #go through each file in source directory
    for filename in source/*
      do
      #list out files
      echo $filename
      #list if we will copy or not and copies it over to the build directory if we do
      if [ $filename == "source/secretinfo.md" ]
        then 
        echo "Not Copying" $filename
        else
        echo "Copying" $filename
        cp $filename build/. 
      fi
    done

    #ensure we have all of the right files in our build directory
    # first change directory to build
    cd build/
    #show contents of build directory
    echo "Build Version $version Contains:"
    ls
#if no on user input, quit
else 
  echo "Please come back when you are ready"
fi
