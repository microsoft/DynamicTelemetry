#!/bin/sh

mkdir ~/.local/mkdocs_python

python3 -m venv ~/.local/mkdocs_python

cd ~/.local/mkdocs_python/bin

./pip install mkdocs
./pip install mkdocs-mermaid2-plugin
./pip install mkdocs-material
./pip install mkdocs-minify-plugin
./pip install mkdocs-include-markdown-plugin
./pip install mkdocs-macros-plugin
./pip install mkdocs-video
./pip install mkdocs-markdown

cd ~/.local/bin
ln -s ../mkdocs_python/bin/mkdocs
