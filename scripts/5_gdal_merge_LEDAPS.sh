#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Error - please specify a directory with LEDAPS results and bands to stack. Usage:"
    echo "    $0 <directory> <bands>"
    echo ""
    echo "        note: remember to quote the bands so they all come as $2"
    exit 1
fi

here=$1

cd $here

# Bands of interest
bands=$2

# Define "extent" function (from https://github.com/dwtkns/gdal-cheat-sheet)
function gdal_extent() {
    if [ -z "$1" ]; then 
        echo "Missing arguments. Syntax:"
        echo "  gdal_extent <input_raster>"
        return
    fi
    EXTENT=$(gdalinfo $1 |\
        grep "Upper Left\|Lower Right" |\
        sed "s/Upper Left  //g;s/Lower Right //g;s/).*//g" |\
        tr "\n" " " |\
        sed 's/ *$//g' |\
        tr -d "[(,]")
    echo -n "$EXTENT"
}

# Define "subdataset" function
function get_sds() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Missing arguments. Usage:"
        echo "    get_sds <raster> <bands>"
        return
    fi

    sds_names=""
    for b in $2; do
        sds=$(gdalinfo $1 | grep "SUBDATASET_${b}_NAME" | awk -F '=' '{ print $2 }')
        sds_names="$sds_names $sds"
    done
    echo "$sds_names"
}

n_ledaps=$(find ./ -name 'lndsr*hdf' | wc -l)
if [ $n_ledaps -eq 0 ]; then
    echo "Error - could not find any LEDAPS results"
    exit 1
fi

# Define index so we only grab extent from first
i=0

# Loop through all image directories
for img in $(find ./ -maxdepth 1 -name 'L*' -type d); do
    echo "Creating layer stack for $img"
    
    # Find LEDAPS file
    lndsr=$(find $img -name 'lndsr*hdf')
    # Get subdatasets - quote bands so they're all sent as $2
    subdatasets=$(get_sds $lndsr "$bands")

    # Get extent of first image we find
    if [ $i -eq 0 ]; then
        # Extent
        sds=$(echo $subdatasets | awk '{ print $1 }')
        extent=$(gdal_extent $sds)
    fi
    
    # Find image Landsat ID for filename
    id=$(basename $img)
    
    output=$img/${id}_stack
    
    # Create layer stack
    gdal_merge.py -o $output -ul_lr $extent -separate -a_nodata -9999 $subdatasets

    if [ $? -ne 0 ]; then
        echo "Error creating stack for ID $img"
        exit 1
    fi

    # Iterate i and delete temp file
    let i+=1
done

echo "Done!"
