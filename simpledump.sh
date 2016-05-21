#!/bin/bash

# Simple script to dump contents of Blackvue's recorded videos to a local folder
# NOTE, no support for the following, though I'd like to add these things and make the tool more useful in future!
# - GPS data (can't find this anywhere on the HTTP interface)
# - Deleting old files
# - Selecting NF/PF/EF/MF files separately and treating them in different ways 

BASE_URL=http://{URL}:{PORT}

# Basically the solution does this:
# {get download of folder structure} | {look for 'Record' to weed out file names} |
# {remove the other fields in csv} | {get rid of the N: prefix} | {Append URL back in} |
# {Download these files, resuming and not replacing if we already have the file}
wget $BASE_URL/blackvue_vod.cgi -q -O - | grep Record | awk -F, '{print $1}' | awk -F: '{print $2}' | xargs -i wget -q -c -N $BASE_URL'{}'
