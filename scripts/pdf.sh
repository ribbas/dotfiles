#!/usr/bin/env zsh
set -o errexit

# pdf
#
# A simple one-liner to execute and disown evince. This function is binded with
# zsh autocompletions to be executed on only *.pdf files
#
# Usage:
#   ./pdf file1.pdf

evince "$@" &> /dev/null & disown;
