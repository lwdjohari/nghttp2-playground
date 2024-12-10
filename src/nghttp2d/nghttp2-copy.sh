#!/bin/bash
echo "nghttp2 source file copy script"
echo "-------------------------------"
echo "This will copy all needed files from nghttp2.list file"
echo "author: Linggawasistha Djohari <linggawasistha.djohari@outlook.com>"
echo ""
echo "Usage: $0 <source_folder> <dest_folder> <file_list>"
# Check if the required parameters are provided
if [ "$#" -ne 3 ]; then
    
    echo ""
    echo "Use default value."
    echo "-------------------------------"

    source_folder="../../../deps/nghttp2-override/nghttp2/src"
    dest_folder="src"
    file_list="nghttp2.list"

     echo "Source: '$source_folder'."
     echo "Destination: '$dest_folder'."
     echo "File-list: '$file_list'."

    echo ""
else

    # Assign parameters to variables
    source_folder="$1"
    dest_folder="$2"
    file_list="$3"
fi


# Validate if source folder exists
if [ ! -d "$source_folder" ]; then
    echo "Error: Source folder '$source_folder' does not exist."
    exit 1
fi

# Validate if destination folder exists
if [ ! -d "$dest_folder" ]; then
    echo "Error: Destination folder '$dest_folder' does not exist."
    exit 1
fi

# Validate if the file list exists
if [ ! -f "$file_list" ]; then
    echo "Error: File list '$file_list' does not exist."
    exit 1
fi

# Initialize arrays for tracking copied and existing files
copied_files=()
existing_files=()

# Read the file list and process each file
while IFS= read -r line || [ -n "$line" ]; do
    # Trim leading and trailing spaces
    line=$(echo "$line" | xargs)

    # Skip empty lines
    [[ -z "$line" ]] && continue

    # Skip lines that start with '#' (even with spaces before the #)
    if [[ "$line" =~ ^\s*# ]]; then
        continue
    fi

    # Get the filename from the line
    filename="$line"
    source_file="$source_folder/$filename"
    dest_file="$dest_folder/$filename"

    # Check if the source file exists
    if [ ! -f "$source_file" ]; then
        echo "Warning: File '$filename' does not exist, skipping."
        continue
    fi

    # Check if the file already exists in the destination folder
     echo "Checking file '$filename'."
    if [ -f "$dest_file" ]; then
        existing_files+=("$filename")
    else
        # Copy the file to the destination folder
        cp "$source_file" "$dest_file"
        copied_files+=("$filename")
    fi
done < "$file_list"

# Display the results
echo ""
echo "=== Files Copied ==="
for file in "${copied_files[@]}"; do
    echo "$file"
done
echo ""
echo "=== Files Already Exist ==="
for file in "${existing_files[@]}"; do
    echo "$file"
done