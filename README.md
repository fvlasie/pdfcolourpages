# pdfcolourpages
Bash script to extract information about colour pages from a PDF.

This script uses GhostScript to post the number of colour pages in a PDF. It is useful in a prepress context for determining cost of printing.

Requires GhostScript:

>  brew install ghostscript

Grant executive permissions:

> chmod a+x pdfcolourpages.sh

Run with a PDF as an argumanet:

> pdfcolourpages.sh silmarillion.pdf
