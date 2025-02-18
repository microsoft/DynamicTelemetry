#!/bin/bash

cd ../docs/docs

echo "Updating Status..."
python3 ../../tools/_CalculateStatus.py
../../tools/_CalculateStatus.gnuplot

echo "Rebuilding Probe Spider..."
../../tools/_BuildProbeSpider.gnuplot

echo "Binding and generating TOC"
pwsh ../../tools/buildAsBook/bind.ps1

cd /data/docs/bound_docs
dos2unix ./bind.files
pandoc -i $(cat ./bind.files) -o ./_bound.tmp.md

fileName=$(date +DynamicTelemetry-Draft-%b-%d-%H-%M-%S)

echo "---" > ./title.txt
echo "Title:$fileName" >> ./title.txt
echo "Author:Chris Gray at al" >> ./title.txt
echo "---" >> ./title.txt


cat ./title.txt ./_bound.tmp.md | grep -v mp4 > ./bound.md

pandoc ./bound.md -o ./$fileName.epub
pandoc ./bound.md -o ./$fileName.pdf
pandoc ./bound.md -o ./$fileName.docx

ls -l ./bound*