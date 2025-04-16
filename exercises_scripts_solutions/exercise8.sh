#!/bin/bash

read -p "Enter a directory path: " dirpath

# Check if directory is valid
if [ -d "$dirpath" ]; then
        # Loop through all .txt files
        for file in "$dirpath"/*.txt; do
        # Check if the file exists
        if [ -f "$file" ]; then
                size=$(stat -c%s "$file")
                echo "$size bytes"
        fi
        done
else
        echo "Error: Not valid directory " >&2
fi
