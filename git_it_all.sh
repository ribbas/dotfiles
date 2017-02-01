#!/bin/zsh

# git_it_all
# A simple and lazy way to check which Git repositories in the input directory
# has uncommitted changes
# Usage:
#   ./git_it_all.sh {DIR_NAME}


function parse_git_dirty {
  [[ "$(git status 2> /dev/null | tail -n1)" != "no changes"* ]] && echo "*"
}

cd "$1"

MENU_STR="Contents of $1:"
PURDY_MENU=$(expr length $MENU_STR)

echo $MENU_STR
printf '=%.0s' {1..$PURDY_MENU}
echo "\n"
ls -d */
echo "\n"

for entry in "$search_dir"*
do
    if [[ -d $entry ]]; then
        cd "$entry"
        if [[ $(parse_git_dirty) != "*" ]]; then
            echo "$entry has uncommitted changes"
        fi
        cd ..
    fi
done
