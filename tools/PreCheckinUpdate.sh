#!/bin/bash

#
# READ-WRITE Update Status and Probes
#
cd /data_rw/docs/docs

echo "Updating Status..."
python3 ../../tools/_CalculateStatus.py
../../tools/_CalculateStatus.gnuplot

echo "Rebuilding Probe Spider..."
../../tools/_BuildProbeSpider.gnuplot


#
# READ-ONLY: Do Binding and create content in docx/pdf/epub
#
cd /data/docs/docs

echo "Binding and generating TOC"
pwsh ../../tools/buildAsBook/bind.ps1


cd /out/bound_docs
dos2unix ./bind.files
pandoc -i $(cat ./bind.files) -o ./_bound.tmp.md

myDate=$(date +%b-%d-%H-%M-%S)
fileName="DynamicTelemetry-Draft-$myDate"

echo "---" > ./title.txt
echo "title: $fileName" >> ./title.txt
echo "author: Chris Gray at al" >> ./title.txt
echo "date: $myDate" >> ./title.txt
echo "---" >> ./title.txt

cat ./title.txt ./_bound.tmp.md | grep -v mp4 > ./bound.md

echo "Building bound contents; in docx, pdf, and epub"
pandoc ./bound.md --toc --toc-depth 6 --epub-cover-image=../orig_media/DynamicTelemetry.CoPilot.Image.png -o /out/bound/epub_$fileName.epub
pandoc ./bound.md -o /out/bound/$fileName.pdf  --toc --toc-depth 6 -N -V geometry:margin=0.25in -V papersize=a5
pandoc ./bound.md -o /out/bound/$fileName.docx

echo "Done!"