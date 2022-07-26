#!/usr/bin/env sh

# Synopsis:
# Normalizes *.dpr filenames

# Arguments: 
# $1 (optional): path to the .dpr

# Description: 
# Changes names of .dpr files to the CamelCased version of their 
# superfolders' names. 
# Please ensure that each folder contains only one .dpr file, 
# otherwise script will try to rename all of them to the same name.

# Examples:
# two-fer/twofer.dpr becomes two-fer/TwoFer.dpr
# etl/ETL.dpr becomes etl/Etl.dpr
# isbn-verifier/ISBNVerifier.dpr becomes isbn-verifier\IsbnVerifier.dpr

for i in $(find $1 -type f -name "*.dpr" -print)
do

    FullPath="$(realpath "$i")"
    FolderPath="$(dirname "$FullPath")"
    CamelCasedDPRName=$(basename "$FolderPath"|sed -r 's/([^-]+)/\L\u\1/g;s/-//g')

    if [ "$(basename "$CamelCasedDPRName.dpr")" != "$(basename "$i")" ]; then
       git mv -f $i "$FolderPath/$CamelCasedDPRName.dpr"
    fi
    
done