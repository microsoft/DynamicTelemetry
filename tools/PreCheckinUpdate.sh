#!/bin/bash
set -e

#
# See if CDocs has been built; if not sync and build
#
if [ ! -d "/Source/CDocs" ]; then
    git clone https://github.com/chgray/CDocs /Source/CDocs
    cd /Source/CDocs
    git checkout user/chgray/update_ubuntu

    podman image pull docker.io/chgray123/chgray_repro:pandoc
    podman image pull docker.io/chgray123/chgray_repro:cdocs.mermaid
fi

cd /Source/CDocs/tools/CDocsMarkdownCommentRender
dotnet build .


#
# Setup the Python environment
#
if [ ! -d "/mkdocs_python" ]; then
    echo "ERROR: /mkdocs_python not found"
    exit 1
fi
source /mkdocs_python/bin/activate

#
# READ-WRITE Update Status Page, Probe Images, etc
#
cd /data/docs/docs

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

cd /data/docs/bound_docs
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

if [ ! -f /data/tools/buildAsBook/header.tex ]; then
    echo "ERROR: /data/tools/buildAsBook/header.tex not found"
    exit 1
fi

echo ""
echo ""
echo ""
echo "Building bound contents; in docx, pdf, and epub"

#fileName=testing_doc
inputFile=./bound.md


args="--toc --toc-depth 4 -N -V papersize=a5 --filter CDocsMarkdownCommentRender"
pandoc $inputFile -o /data/bound/epub_$fileName.epub --epub-cover-image=../orig_media/DynamicTelemetry.CoPilot.Image.png $args
pandoc $inputFile -o /data/bound/$fileName.pdf -H /data/tools/buildAsBook/header.tex $args
pandoc $inputFile -o /data/bound/$fileName.docx $args
pandoc ./bound.md -o /data/bound/$fileName.json $args

cp ./bound.md /data/bound
echo "Done!"
