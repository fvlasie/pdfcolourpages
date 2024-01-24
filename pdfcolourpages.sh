#! /bin/bash

# Usage: ./pdfcolourpages.sh filename.pdf
# Requires ghostscript installed via brew

# Getting the first page specifically scrambled the output so I am looping all the pages but exiting on the first run.

file="$1"

# Check if the file exists and is a PDF
if [ -f "$file" ] && [ "${1: -4}" == ".pdf" ]; then
# Get the CropBox values
cropbox=$(gs -dQUIET -dNOSAFER -sFileName="$file" -c "FileName (r) file runpdfbegin 1 1 pdfpagecount {pdfgetpage /CropBox get {=print ( ) print} forall (\\n) print exit} for quit")
# Use awk to convert points to inches and print the result
echo "$cropbox" | awk '{printf "Page size (Crop): %.2f x %.2f inches\n", $3/72, $4/72}'
# Get the MediaBox values
mediabox=$(gs -dQUIET -dNOSAFER -sFileName="$file" -c "FileName (r) file runpdfbegin 1 1 pdfpagecount {pdfgetpage /MediaBox get {=print ( ) print} forall (\\n) print exit} for quit")
# Use awk to convert points to inches and print the result
echo "$mediabox" | awk '{printf "Page size (Media): %.2f x %.2f inches\n", $3/72, $4/72}'
# Get the number of total pages
total_pages=$(gs -dNOSAFER -dQUIET -sFileName="$file" -c "FileName (r) file runpdfbegin pdfpagecount = quit")
echo "The number of total pages is: $total_pages"
# Add 2 to the total pages
total_pages_plus_2=$((total_pages + 2))
echo "The number of total pages + 2 is: $total_pages_plus_2"
# Get the number of color pages
color_pages=$(gs -o - -sDEVICE=inkcov "$file" | grep -v "^ 0.00000  0.00000  0.00000" | grep "^ " | wc -l)
echo "The number of color pages is: $color_pages"
else
# Print an error message
echo "Invalid file: $1"
fi

