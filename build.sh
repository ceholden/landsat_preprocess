#!/bin/bash
###
#
# Build script for IPython notebook outputs
#
###

for ipynb in $(find ./ -name '*ipynb'); do
    # Ignore checkpoints
    dn=$(basename $(dirname $ipynb))
    if [ "$dn" == ".ipynb_checkpoints" ]; then
        continue
    fi

    ipython nbconvert $ipynb
    ipython nbconvert --to=latex --post=PDF $ipynb
done

echo "Done!"
