#!/bin/bash
set -e

export CDOCS_MARKDOWN_RENDER_PATH=$(pwd)/../../CDocs
export DT_BOUND_DIR=$(pwd)/../docs/bound_docs
export DT_DOCS_DIR=$(pwd)/../docs/docs
export DT_ORIG_MEDIA_DIR=$(pwd)/../docs/orig_media


# Check for required environment variable
if [ -z "${CDOCS_MARKDOWN_RENDER_PATH}" ]; then
    echo "ERROR: CDOCS_MARKDOWN_RENDER_PATH environment variable must be set"
    exit 1
fi
export PATH=${CDOCS_MARKDOWN_RENDER_PATH}/tools/CDocsMarkdownCommentRender/bin/Debug/net8.0:$PATH$

# Verify the path exists and contains the required binary
if [ ! -f "${CDOCS_MARKDOWN_RENDER_PATH}/tools/CDocsMarkdownCommentRender/bin/Debug/net8.0/CDocsMarkdownCommentRender" ]; then
    echo "ERROR: CDocsMarkdownCommentRender binary not found in CDOCS_MARKDOWN_RENDER_PATH: ${CDOCS_MARKDOWN_RENDER_PATH}"
    exit 1
fi

dotnet build ${CDOCS_MARKDOWN_RENDER_PATH}/tools/CDocsMarkdownCommentRender

if [ -z "${DT_BOUND_DIR}" ]; then
    echo "ERROR: DT_BOUND_DIR environment variable must be set"
    exit 1
fi

if [ -z "${DT_DOCS_DIR}" ]; then
    echo "ERROR: DT_DOCS_DIR environment variable must be set"
    exit 1
fi

if [ -z "${DT_ORIG_MEDIA_DIR}" ]; then
    echo "ERROR: DT_ORIG_MEDIA_DIR environment variable must be set"
    exit 1
fi


if [ ! -d "${DT_BOUND_DIR}" ]; then
    echo "ERROR: ${DT_BOUND_DIR} not found"
    mkdir ${DT_BOUND_DIR}
fi

if [ ! -d "${DT_ORIG_MEDIA_DIR}" ]; then
    echo "ERROR: ${DT_ORIG_MEDIA_DIR} not found"
    mkdir ${DT_ORIG_MEDIA_DIR}
fi

#
# See if the pandoc image exists; if not, pull it
#
set +e
podman image exists docker.io/chgray123/chgray_repro:pandoc

if [ $? -ne 0 ]; then
    set -e
    echo "Pulling pandoc image..."
    podman image pull docker.io/chgray123/chgray_repro:pandoc
fi

set +e
podman image exists chgray123/chgray_repro:cdocs.mermaid

if [ $? -ne 0 ]; then
    set -e
    echo "Pulling cdocs.mermaid image..."
    podman image pull docker.io/chgray123/chgray_repro:cdocs.mermaid
fi
set -e

#
# Setup the Python environment
#
# if [ ! -d "/mkdocs_python" ]; then
#     echo "ERROR: /mkdocs_python not found"
#     exit 1
# fi
# source /mkdocs_python/bin/activate

#
# READ-WRITE Update Status Page, Probe Images, etc
#
cd ../docs/docs
ls

echo "Updating Status..."
python3 ../../tools/_CalculateStatus.py

#
# use a container to call gnuplot
#
echo "Update Status with GNU Plot"
../../tools/_CalculateStatus.gnuplot

echo "Rebuilding Probe Spider..."
gnuplot ../../tools/_BuildProbeSpider.gnuplot



#
# READ-ONLY: Do Binding and create content in docx/pdf/epub
#
cd "$DT_DOCS_DIR"
ls

echo "Binding and generating TOC"
python ../../tools/buildAsBook/bind.py

echo "Changing to dir : $DT_BOUND_DIR"
cd "$DT_BOUND_DIR"
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

header_path="$DT_DOCS_DIR/../../tools/buildAsBook/header.tex"
if [ ! -f "$header_path" ]; then
    echo "ERROR: header.tex not found at: $header_path"
    exit 1
fi

echo ""
echo ""
echo ""
echo "Building bound contents; in docx, pdf, and epub"

inputFile=$DT_BOUND_DIR/bound.md

if [ ! -f "$inputFile" ]; then
    echo "ERROR: $inputFile not found"
    exit 1
fi

echo "  INPUT_FILE : $inputFile"
echo "DT_BOUND_DIR : $DT_BOUND_DIR"

args="--toc --toc-depth 4 -N -V papersize=a5"
# --filter CDocsMarkdownCommentRender"

pandoc $inputFile -o "$DT_BOUND_DIR/epub_$fileName.epub" --epub-cover-image=../orig_media/DynamicTelemetry.CoPilot.Image.png $args
pandoc $inputFile -o "$DT_BOUND_DIR/$fileName.pdf" -H "$header_path" $args
pandoc $inputFile -o "$DT_BOUND_DIR/$fileName.docx" $args
pandoc ./bound.md -o "$DT_BOUND_DIR/$fileName.json" $args

echo "Done!"
