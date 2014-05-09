#!/bin/bash

if [ -z "$1" ]; then
    echo "Error - please specify a directory with Landsat images and checksums. Usage:"
    echo "    $0 <directory>"
    exit 1
fi

here=$1

cd $here

# Loop over cksum files
for checksum in $(find ./ -name 'L*.cksum'); do
    # Find basename of file and remove extension to match up with archive
    bn=$(basename $checksum | awk -F '.' '{ print $1 }')
    
    # Test to see if archive exists
    archive=${bn}.tar.gz
    if [ ! -f $archive ]; then
        echo "$bn has no matching archive"
        continue
    fi
    
    # If archive exists, then validate checksum
    test=$(cksum $archive)
    if [ "$test" != "$(cat $checksum)" ]; then
        echo "!!!!! WARNING !!!!!"
        echo "$bn may be corrupted"
        echo "!!!!! WARNING !!!!!"
    else
        echo "$bn is OK"
    fi
done
