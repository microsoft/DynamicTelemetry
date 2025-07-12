#!/bin/bash
set -e

SCRIPT_PATH=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
echo "Script path: $SCRIPT_PATH"

export CDOCS_MARKDOWN_RENDER_PATH=$(realpath ${SCRIPT_PATH}/../../CDocs)
export DT_BOUND_DIR=$(realpath ${SCRIPT_PATH}/../docs/bound_docs)
export DT_DOCS_DIR=$(realpath ${SCRIPT_PATH}/../docs/docs)
export DT_ORIG_MEDIA_DIR=$(realpath ${SCRIPT_PATH}/../docs/orig_media)

# Check for required environment variable
if [ ! -d "${CDOCS_MARKDOWN_RENDER_PATH}" ]; then
    git clone --branch user/chgray/update_ubuntu http://github.com/chgray/CDocs ${CDOCS_MARKDOWN_RENDER_PATH}
fi

export PATH=${CDOCS_MARKDOWN_RENDER_PATH}/tools/CDocsMarkdownCommentRender/bin/Debug/net8.0:$PATH$
export | grep CDOCS
export | grep DT

# Verify the path exists and contains the required binary
if [ ! -f "${CDOCS_MARKDOWN_RENDER_PATH}/tools/CDocsMarkdownCommentRender/bin/Debug/net8.0/CDocsMarkdownCommentRender" ]; then
    echo "ERROR: CDocsMarkdownCommentRender binary not found in CDOCS_MARKDOWN_RENDER_PATH: ${CDOCS_MARKDOWN_RENDER_PATH}"
    dotnet build ${CDOCS_MARKDOWN_RENDER_PATH}/tools/CDocsMarkdownCommentRender
fi
if [ ! -f "${CDOCS_MARKDOWN_RENDER_PATH}/tools/CDocsMarkdownCommentRender/bin/Debug/net8.0/CDocsMarkdownCommentRender" ]; then
    echo "ERROR: CDocsMarkdownCommentRender binary not found in CDOCS_MARKDOWN_RENDER_PATH: ${CDOCS_MARKDOWN_RENDER_PATH}"
    exit 1
fi

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
echo "Determining if we're using docker or podman, docker preferred"
if command -v docker &> /dev/null; then
    echo "Using Docker."
    container_tool="docker"
elif command -v podman &> /dev/null; then
    echo "Using podman"
    container_tool="podman"
else
    echo "Either docker or podman are required"
    exit 1
fi

set +e
${container_tool} image exists docker.io/chgray123/chgray_repro:pandoc

if [ $? -ne 0 ]; then
    set -e
    echo "Pulling pandoc image..."
    ${container_tool} image pull docker.io/chgray123/chgray_repro:pandoc
fi

set +e
${container_tool} image exists chgray123/chgray_repro:cdocs.mermaid

if [ $? -ne 0 ]; then
    set -e
    echo "Pulling cdocs.mermaid image..."
    ${container_tool} image pull docker.io/chgray123/chgray_repro:cdocs.mermaid
fi
set -e

# Start in our script directory
cd ${SCRIPT_PATH}

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
pwd
echo "Updating Status..."
python3 ./_CalculateStatus.py

#
# use a container to call gnuplot
#
echo "Update Status with GNU Plot"
gnuplot ./_CalculateStatus.gnuplot

echo "Rebuilding Probe Spider..."
gnuplot ./_BuildProbeSpider.gnuplot

cd ../docs/docs


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

args="--toc --toc-depth 4 -N --filter CDocsMarkdownCommentRender"

export CDOCS_FILTER=1
pandoc $inputFile -o "$DT_BOUND_DIR/epub_$fileName.a5.epub" --epub-cover-image=../orig_media/DynamicTelemetry.CoPilot.Image.png -V papersize=a5 $args
pandoc $inputFile -o "$DT_BOUND_DIR/epub_$fileName.a8.epub" --epub-cover-image=../orig_media/DynamicTelemetry.CoPilot.Image.png -V papersize=a8 $args
pandoc $inputFile -o "$DT_BOUND_DIR/$fileName.a5.pdf" -H "$header_path" -V papersize=a5 $args
pandoc $inputFile -o "$DT_BOUND_DIR/$fileName.a8.pdf" -H "$header_path" -V papersize=a8 $args
pandoc $inputFile -o "$DT_BOUND_DIR/$fileName.a5.docx" -V papersize=a5 $args
pandoc $inputFile -o "$DT_BOUND_DIR/$fileName.a8.docx" -V papersize=a8 $args
pandoc ./bound.md -o "$DT_BOUND_DIR/$fileName.json" $args

echo "Done!"
