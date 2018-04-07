#!/usr/bin/env zsh
set -o errexit

# highlight
#
# A simple one-liner to highlight tokens in files
#
# Usage:
#   ./highlight "token1|token2" file1 file2

grep --color -iE "$1|$" "${@:2}";
