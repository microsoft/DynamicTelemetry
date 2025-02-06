#!/bin/sh

echo "                   Intercepted private (debug/local) CDoc.Launcher.sh"
echo "                   pandoc $@"
echo "                   -------------------------------------------------------------------------------------------"
echo


# echo "ARGS[$@]"
cd /data
cd $1
shift
# echo "ARGS_post_pop[$@]"


pandoc $@

pandoc_ret=$?

if [ $pandoc_ret -ne 0 ]; then
    echo
    echo "PANDOC FAILED: when called as follow. Exiting to console for debugging"
    echo "     pandoc $@"
    echo
    bash
fi
