#!/bin/bash

if [ -z "$1" ]; then
    echo "Error - please specify a directory with Landsat archives. Usage:"
    echo "    $0 <directory>"
    exit 1
fi

here=$1

cd $here

# We want to find things ONLY in our current directory, not in any subfolders
#     So, we use -maxdepth 1 option
#     You could also just use "ls *tar.gz", 
#     but find is good to know because it gives you a lot of control
n=$(find ./ -maxdepth 1 -name '*tar.gz' | wc -l)
i=1

if [ $n -eq 0 ]; then
    echo "Error - could not find any Landsat archives"
    exit 1
fi

for archive in $(find ./ -maxdepth 1 -name '*tar.gz'); do
    echo "<----- $i / $n: $(basename $img)"
    
    # Create temporary folder for storage
    mkdir temp
    
    # Extract archive to temporary folder
    tar -xzvf $archive -C temp/
    
    # Find ID based on MTL file's filename
    mtl=$(find temp/ -name 'L*MTL.txt')
    
    # Test to make sure we found it
    if [ ! -f $mtl ]; then
        echo "Could not find MTL file for $archive"
        break
    fi
    
    # Use AWK to remove _MTL.txt
    id=$(basename $mtl | awk -F '_' '{ print $1 }')
    
    # Move archive into temporary folder
    mv $archive temp/
    
    # Rename archive
    mv temp $id
    
    # Iterate count
    let i+=1
done

echo "Done!"
