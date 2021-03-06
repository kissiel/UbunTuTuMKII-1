#!/bin/bash
#
# A script to reset trust-store permission
# Author: Po-Hsu Lin <po-hsu.lin@canonical.com>
# 

function errorMsg(){
    echo "$@"
}

for name in $@
do
    dbPath='/home/phablet/.local/share/'$name'/trust.db'

    # Make sure the $dbPath exist
    if [ `adb shell "if [ -e $dbPath ]; then echo 1; fi"` ]; then
        adb shell sqlite3 $dbPath "delete from requests"
        echo "Reset trust-store permission for $name"
    else
        errorMsg "Error: $name Not found, typo?"
    fi
done

