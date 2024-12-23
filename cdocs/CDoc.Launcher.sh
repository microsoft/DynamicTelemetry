#!/bin/sh

echo .
echo .
echo "--------------------------------------------------------------------------------"
echo "Intercepted (debug) Pandoc.launcher.sh"
echo "     pandoc $@"
echo "--------------------------------------------------------------------------------"
echo .


echo "ARGS[$@]"
cd /data
cd $1
shift
echo "ARGS_post_pop[$@]"


pandoc $@

pandoc_ret=$?

if [ $pandoc_ret -ne 0 ]; then
    echo .
    echo "PANDOC FAILED: when called as follow. Exiting to console for debugging"
    echo "     pandoc $@"
    echo .
    bash
else
    echo .
    echo "PANDOC SUCCESS: when called as follow"
    echo "     pandoc $@"
    echo .
fi