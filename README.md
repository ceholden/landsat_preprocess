Landsat Preprocessing Workflow
==================

#### About
This guide seeks to demonstrate and document "a workflow" for gathering and preprocessing large amounts Landsat data such that the data may be ingested into "data mining" or time series algorithms. Individuals may have difference preferences with regard to what preprocessing is performed and accomplishing any given workflow could be done using a multitude of software options. This workflow documents one approach to preprocessing done using freely available tools including:
- GDAL command line applications
- Command line applications (grep, sed, awk, etc.) avialable on Linux / Unix environments
- Custom Python command line applications written the author
- Bash shell to tie the data to these command line utilities

The guide is currently written for the GEO / SCC cluster at Boston University, but it would be simple enough to port these instructions to any other Linux cluster or workstation environment.

#### Access
This workflow is documented using the IPython notebook (despite there being almost no Python involved) because it nicely mixes text documentation and media with code input and output.

You can view the notebook by using IPython's "nbviewer" website:

http://nbviewer.ipython.org/github/ceholden/landsat_preprocess/tree/master/?create=1/

If you wish to have a copy for yourself offline, you can download the "Landsat_Preprocessing.html" HTML page and the "resources" folder containing the image and movie resources referenced in the HTML. I have been unable to figure out how to properly format a PDF from this HTML page, but a PDF copy may be available in the future.

#### About Landsat

The USGS has very recently developed a product generation system for atmospherically corrected and cloud masked Landsat data which make using Landsat data much easier. Information on this Landsat Surface Reflectance "Climate Data Record" (CDR) is available from their website:

https://landsat.usgs.gov/CDR_LSR.php

For more information on the LEDAPS algorithm and for documentation on this product, I refer you to the product guides and whitepapers linked to at the bottom of the Landsat Surface Reflectance CDR product website (not linked directly here to avoid out of date links).

Further details about other "science ready" data products from the Landsat sensor are available on the Landsat Climate Data Record (CDR) and Essential Climate Variable (ECV) website:

https://landsat.usgs.gov/CDR_ECV.php
