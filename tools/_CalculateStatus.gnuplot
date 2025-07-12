#!/usr/bin/gnuplot -persist

# Set the output to a PNG file
set terminal pngcairo size 800,600 enhanced font 'Verdana,10'
set output '../docs/orig_media/DocumentStatus.png'

# Set the title and labels
set title "Document Completion Status"
set xlabel "Status"
set ylabel "Number of Documents"

# Set style for the bars
set style data histograms
set style fill solid 1.00 border -1

# Set grid
set grid ytics

# Read data from the CSV file
set datafile separator ","
plot '../docs/bound_docs/Status.csv' using 2:xtic(1) title 'Data' linecolor rgb "blue"