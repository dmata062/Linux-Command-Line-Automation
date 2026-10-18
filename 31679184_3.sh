echo "Enter a directory path: "
read path

if [ -d "$path" ]; then
    cd "$path"
else
    echo "Error: Directory does not exist."
    exit 1
fi

echo
echo "Analyzing directory: $path"
total_size=0
items=0

sizes=$(ls -l "$path" | tail -n+2 | tr -s ' ' | cut -f5 -d' ')


for size in $sizes; do
	total_size=$((total_size+size))
	items=$((items+1))
done

echo
echo "Files and their sizes: "
echo
echo "$(ls -l | tail -n+2 | tr -s ' ' | cut -f5,9 -d' ')"

echo
echo "Average Size: $((total_size/items)) bytes"
echo
echo "Files larger than average"


files=$(ls -l "$path" | tail -n+2 | tr -s ' ' | cut -f5,9 -d' ' | tr ' ' ':')

count=0
for file in $files; do
    size=$(echo "$file" | cut -d':' -f1)
    name=$(echo "$file" | cut -d':' -f2)

    if [ "$size" -gt "$((total_size / items))" ]; then
        echo "$name: $size bytes"
	count=$((count+1))
    fi
done

echo
echo "Total Items above average: $count out of $items"
