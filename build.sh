#!/bin/bash
###
#
# Build script for IPython notebook outputs
#
###

if [ ! -d build ]; then
    mkdir build
fi

for ipynb in $(find ./ -name '*ipynb'); do
    # Ignore checkpoints
    dn=$(basename $(dirname $ipynb))
    if [ "$dn" == ".ipynb_checkpoints" ]; then
        continue
    fi

    # Basename minus extension of IPython notebook
    f=$(basename $ipynb .ipynb)

    ipython nbconvert $ipynb
#    ipython nbconvert --to=latex --post=PDF $ipynb

    # Move built HTML and/or PDF to build/ directory
    if [ -f ${f}.html ]; then
        mv ${f}.html build/
    fi
    if [ -f ${f}.pdf ]; then
        mv ${f}.pdf build/
    fi

    # remove tex files
    tex=${f}.tex
    if [ -f $tex ]; then
        rm $tex
    fi

done

echo "Done!"
