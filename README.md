Landsat Preprocessing Workflow
==================

## About
This guide seeks to demonstrate and document "a workflow" for gathering and preprocessing large amounts Landsat data such that the data may be ingested into "data mining" or time series algorithms. Individuals may have difference preferences with regard to what preprocessing is performed and accomplishing any given workflow could be done using a multitude of software options. This workflow documents one approach to preprocessing done using freely available tools including:
- GDAL command line applications
- Command line applications (grep, sed, awk, etc.) avialable on Linux / Unix environments
- Custom Python command line applications written the author
- Bash shell to tie the data to these command line utilities

The guide is currently written for the GEO / SCC cluster at Boston University, but it would be simple enough to port these instructions to any other Linux cluster or workstation environment.

## Access
This workflow is documented using the IPython notebook (despite there being almost no Python involved) because it nicely mixes text documentation and media with code input and output.

You can view the notebook directly by using IPython's "nbviewer" website:

###### [Introduction](http://nbviewer.ipython.org/github/ceholden/landsat_preprocess/blob/master/chapters/Chapter_0-Intro.ipynb)

1. [Chapter 1 - Search for images](http://nbviewer.ipython.org/github/ceholden/landsat_preprocess/blob/master/chapters/Chapter_1-Search.ipynb)
2. [Chapter 2 - Submit preprocessing order](http://nbviewer.ipython.org/github/ceholden/landsat_preprocess/blob/master/chapters/Chapter_2-Submit.ipynb)
3. [Chapter 3 - Download onto cluster](http://nbviewer.ipython.org/github/ceholden/landsat_preprocess/blob/master/chapters/Chapter_3-Download.ipynb)
4. [Chapter 4 - Organize and unzip images](http://nbviewer.ipython.org/github/ceholden/landsat_preprocess/blob/master/chapters/Chapter_4-Organize.ipynb)
5. [Chapter 5 - Create "Layer Stacks"](http://nbviewer.ipython.org/github/ceholden/landsat_preprocess/blob/master/chapters/Chapter_5-Stack.ipynb)
6. [Chapter 6 - Run Fmask on cluster](http://nbviewer.ipython.org/github/ceholden/landsat_preprocess/blob/master/chapters/Chapter_6-Fmask.ipynb)
7. [Chapter 7 - Subset images by extent or ROI](http://nbviewer.ipython.org/github/ceholden/landsat_preprocess/blob/master/chapters/Chapter_7-Subset.ipynb)
8. [Chapter 8 - Create "preview" JPEG/PNG images](http://nbviewer.ipython.org/github/ceholden/landsat_preprocess/blob/master/chapters/Chapter_8-Preview.ipynb)
9. [Chapter 9 - Summarize and document dataset](http://nbviewer.ipython.org/github/ceholden/landsat_preprocess/blob/master/chapters/Chapter_9-Summarize.ipynb)

If you wish to have a copy for yourself without the "nbviewer" utility, you can download the HTML files found in the "build" folder.

I have been unable to figure out how to properly format a PDF from this HTML page, but a PDF copy may be available in the future.

You also may, of course, download the IPython Notebook files and run an IPython notebook server for yourself.

## Script Files
I have taken several of the steps in the workflow and turned them into fully functioning scripts. These may be found in the "scripts" directory. They are labeled with a number to indicate the corresponding step in the workflow and include:

+ 3_checksum_test.sh
    + Check all in target directory tar.gz files against the checksum output in corresponding .cksum files
+ 4_unzip_archives.sh
    + Unzip all tar.gz archives in target directory and rename them to Landsat ID
+ 4_remove_L1G.sh
    + Check target directory for L1G images and move them into folder named "L1G"
+ 5_gdal_merge_LEDAPS.sh
    + Use gdal_merge.py to create "layer stacks" of all "lndsr*hdf" files within target directory

## About Landsat
The USGS has very recently developed a product generation system for atmospherically corrected and cloud masked Landsat data which makes using Landsat data much easier. Information on this Landsat Surface Reflectance "Climate Data Record" (CDR) is available from their website:

https://landsat.usgs.gov/CDR_LSR.php

For more information on the LEDAPS algorithm and for documentation on this product, I refer you to the product guides and whitepapers linked to at the bottom of the Landsat Surface Reflectance CDR product website (not linked directly here to avoid out of date links).

Further details about other "science ready" data products from the Landsat sensor are available on the Landsat Climate Data Record (CDR) and Essential Climate Variable (ECV) website:

https://landsat.usgs.gov/CDR_ECV.php
