#!/bin/bash

arr=("$@")

if [ $# -le 0 ]; then
	echo "Error: No arguments provided"
	exit 1
fi

echo "Original Array: ${arr[@]}"

#insertion sort

i=1
while [ "$i" -lt $# ]; do
	temp="${arr[$i]}"
	j=$((i-1))

	while [ $j -ge 0 ] && [ "${arr[$j]}" -gt "$temp" ]; do
		arr[$((j+1))]="${arr[$j]}"
		j=$((j-1))
	done
	arr[$((j+1))]="$temp"
	i=$((i+1))
done

echo "New Array: ${arr[@]}"
