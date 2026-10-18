#!/bin/bash

echo "Enter the name of a file: "
read file

if [ ! -e "$file" ]; then
	echo "Error: File does not exist"
	exit 1
fi

if [ ! -f "$file" ]; then
        echo "Error: Not a regular file"
        exit 1
fi

frequency=$(sort "$file" | uniq -c)

echo "Word Frequency:"
echo "---------------"
echo "$frequency" | sort -k1,1nr -k2,2

echo "Summary:"
echo "Total Unique Words: $(echo "$frequency" | wc -l)"
