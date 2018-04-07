#!/usr/bin/env zsh
set -o errexit

# highlight
#
# A simple one-liner to change directory to the most recent directory that was
# just used to move a file to.
#
# For example:
#   mv test1.foo /path/to/dir/newname.foo;
#   mvthere;
#
# Would change directory to /path/to/dir/
#
# Usage:
#   ./mvthere

cd "$(cat ~/."$(basename $(echo $SHELL))"_history | grep "mv" | tail -n2 | head -n1 | grep -oE '[^ ]+$')";
