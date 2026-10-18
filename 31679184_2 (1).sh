#!/bin/bash

if [ $# -gt 1 ]; then
	echo "Error: More than 1 argument provided"
	exit 1
fi


if [ $# -eq 0 ]; then
	dir=.
else
	dir="$1"
fi

if [ ! -d "$dir" ]; then
	echo "Directory or Path does not exist"
	exit 1
fi

files=0
removed=0

function traverse() {
        if [ ! -d "$1" ]; then
		files=$((files+1))
		if [ -f "$1" ] && [ ! -s "$1" ]; then
			echo "Removed zero-length file: $(pwd)/$1"
			rm "$1"
			removed=$((removed+1))
		fi

                return
        fi

        if [ $(ls -l "$1" | wc -l) -eq 0 ]; then
                return
        fi

        entries=("$1"/*)
        for entry in "${entries[@]}"; do
                traverse "$entry"
        done
}

traverse "$dir" #shell parameter --> dir

echo "Total Files Processed: $files"
echo "Zero-length Files Removed: $removed"
