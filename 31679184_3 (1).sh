#!/bin/bash

if [ $# -gt 1 ] || [ $# -eq 0 ]; then
	echo "Error: Invalid amount of arguments"
	exit 1
fi

dir="$1"

if [ ! -e "$dir" ]; then
	echo "Error path/dir does not exist"
	exit 1
fi

if [ ! -d "$dir" ]; then
        echo "Error directory does not exist"
	exit 1
fi

filenames=()
paths=()
count=0
duplicate_files=0

function traverse() {

        if [ ! -d "$1" ]; then
                return
        fi

        if [ $(ls -l "$1" | wc -l) -eq 0 ]; then
                return
        fi

        entries=("$1"/*)
        for entry in "${entries[@]}"; do
		if [ -d "$entry" ]; then
			traverse "$entry"

		elif [ -f "$entry" ] && [ ! -L "$entry" ]; then
			count=$((count+1))
			filename=$(basename "$entry")
			duplicate=0
			for i in "${!filenames[@]}"; do
				if [ "$filename" = "${filenames[$i]}" ]; then
					duplicate_files=$((duplicate_files+1))
					duplicate=1
					original="${paths[$i]}"
					break
				fi
			done

			if [ "$duplicate" -eq 1 ]; then
				echo "Original file: $original"
				echo "Duplicate: $entry"
				while true; do
					echo "Do you want to remove $entry? (y/n)"
					read answer
					case "${answer,,}" in
						yes|y)
							rm "$entry"
							echo "Removed $entry"
							break
							;;
						no|n)
							echo "File $entry kept"
							break
							;;
						*)
							echo "Invalid response enter yes or no"
							;;
					esac
				done
			else
				filenames+=("$filename")
                		paths+=("$entry")
			fi
		fi
        done
}

traverse "$dir"

echo "Files Processed: $count"
echo "Duplicates Found: $duplicate_files"
