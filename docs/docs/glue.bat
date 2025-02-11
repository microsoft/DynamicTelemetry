@echo off
call cdocs-pandoc *.md -o biggie.md
call cdocs-render biggie.md
