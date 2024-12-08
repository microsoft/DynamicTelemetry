#!/bin/sh

echo .
echo .
echo "--------------------------------------------------------------------------------"
echo "Intercepted (debug) Pandoc.launcher.sh"
echo "     pandoc $@"
echo "--------------------------------------------------------------------------------"
echo .

cd /data
pandoc "$@"

pandoc_ret=$?

if [ $pandoc_ret -ne 0 ]; then
    echo .
    echo "PANDOC FAILED: when called as follow. Exiting to console for debugging"
    echo "     pandoc $@"
    echo .
    echo .
    bash
fi