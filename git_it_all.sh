#!/bin/zsh

function parse_git_dirty {
  [[ "$(git status 2> /dev/null | tail -n1)" != "no changes"* ]] && echo "clean"
}


cd "$1"
echo "Contents of $1:" 
ls -d */
echo "\n"

for entry in "$search_dir"*
do
    if [[ -d $entry ]]; then
        cd "$entry"
        if [[ $(parse_git_dirty) != "clean" ]]; then
            echo "$entry has uncommitted changes"
        fi
        cd ..
    fi
done
