#!/bin/bash

# This script automatically decompresses a file with multiple levels of compression. When it reaches a readable form the contents are concatenated to the terminal.

# Function to check the file type and decompress if necessary
check_and_decompress() {
    local file=$1
    local count=1

    while true; do
        # Check the file type using the 'file' command
        file_type=$(file -b "$file")
        echo "File type: $file_type"

        # If the file is ASCII text, we can stop and cat the file
        if [[ "$file_type" == *ASCII* ]]; then
            echo "File is in ASCII format. Displaying content:"
            cat "$file"
            break
        fi

        # Handle different compression types
        if [[ "$file_type" == *gzip* ]]; then
            echo "File is gzip compressed. Decompressing..."
            # Use -c to write to stdout and redirect to a new file with number appended
            gunzip -c "$file" > "${file}_$count"
            file="${file}_$count"  # Update the file name after decompression
        elif [[ "$file_type" == *bzip2* ]]; then
            echo "File is bzip2 compressed. Decompressing..."
            bunzip2 -c "$file" > "${file}_$count"
            file="${file}_$count"  # Update the file name after decompression
        elif [[ "$file_type" == *XZ* ]]; then
            echo "File is xz compressed. Decompressing..."
            unxz -c "$file" > "${file}_$count"
            file="${file}_$count"  # Update the file name after decompression
        elif [[ "$file_type" == *zip* ]]; then
            echo "File is zip compressed. Decompressing..."
            unzip -p "$file" > "${file}_$count"  # Use -p for unzip to write to stdout
            file="${file}_$count"  # Update the file name after decompression
        elif [[ "$file_type" == *tar* ]]; then
            echo "File is tar compressed. Extracting..."
            tar -xOf "$file" > "${file}_$count"
            file="${file}_$count"  # Update the file name after decompression
        else
            echo "Unknown compression format or unrecognized file type. Exiting."
            exit 1
        fi

        # Increment count for the next decompressed file name
        ((count++))

        # Pause before checking again
        sleep 1
    done
}

# Check that the file exists
if [[ ! -f "$1" ]]; then
    echo "File $1 does not exist. Exiting."
    exit 1
fi

# Call the function with the provided file
check_and_decompress "$1"
