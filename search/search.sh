#!/usr/bin/env zsh
set -o errexit

# search
#
# A simple one-liner to search for token recursively through directories and
# output number of occurrences in each file
#
# Usage:
#   ./search "token1" file1 file2 dir1/ dir2/

grep -irnc ${@:2} -e $1 | grep -v ":0$";
