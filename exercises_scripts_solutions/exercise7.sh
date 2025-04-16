#!/bin/bash
#echo "Enter the path to a file: "
#read filepath
read -p "Enter the path to a file: " filepath
#if [ -f "$filepath" ]; then
if [ -e "$filepath" ] && [ -r "$filepath" ]; then
        echo "File is OK"
else
        echo "Error: file does  not exist or is not readable" >&2
fi 
