#!/bin/bash

get_input() {
    echo "#############################################################"
    echo "This is file extractor script located at /usr/local/bin "
    echo "#############################################################"
    read -p "Enter the directory path, Enter . for current dir: " dir_path
    read -p "Enter the name of the output file, default (output.txt): " output_file

    if [ -z "$output_file" ]; then
        output_file="output_file.txt"
        touch "$output_file"
    else
        touch "$output_file"
    fi
}


create_tree_structure() {
    echo "Creating directory structure..."
    echo "##############################################################################" >> "$output_file"
    echo "This File has been generated using extractor script located at /usr/local/bin " >> "$output_file" 
    echo "##############################################################################" >> "$output_file"
    echo "Directory structure of $dir_path is as follow " > "$output_file"
    tree -L 10 "$dir_path" >> "$output_file"
    echo "#######################################" >> "$output_file"
}


list_file_contents() {
    echo "Listing contents of all files in subdirectories..."
    find "$dir_path" -type f | while read -r file; do
        echo "#######################################" >> "$output_file"
        echo "Contents of file: $file" >> "$output_file"
        echo "#######################################" >> "$output_file"
        cat "$file" >> "$output_file"
    done
}


main() {
    get_input
    create_tree_structure
    list_file_contents
    echo "Process completed. The output is saved in $output_file"
}


main
