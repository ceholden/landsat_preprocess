#!/bin/bash

if [ -z "$1" ]; then
    echo "Error - please specify a directory with extraced Landsat archives. Usage:"
    echo "    $0 <directory>"
    exit 1
fi

here=$1

cd $here

n_mtl=$(find ./ -name 'L*MTL.txt' | wc -l)
if [ $n_mtl -eq 0 ]; then
    echo "Error - cannot find any MTL files"
    exit 1
fi

if [ ! -d L1G ]; then
    mkdir L1G/
fi

for mtl in $(find ./ -name 'L*MTL.txt'); do
    id=$(basename $(dirname $mtl))
    
    l1t=$(grep "L1T" $mtl)
    
    if [ "$l1t" == "" ]; then
        echo "$id is not L1T"
        mv $(dirname $mtl) L1G
    else
        echo "$id is L1T"
    fi
    
done

echo "Done!"
