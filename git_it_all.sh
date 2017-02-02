#!/bin/zsh

# git_it_all
# 
# A simple and lazy way to resursively check which Git repositories in the
# input directory has uncommitted changes
# 
# Usage:
#   ./git_it_all.sh dir_path


function parse_git_dirty {
    [[ "$(git status 2> /dev/null | tail -n1)" == "nothing to commit"* ]] && echo "*"
}

function go_back {
    cd $ABS_PATH    
}

ABS_PATH=$(pwd)
DIR_TREE=$(find $1 -type d -not -path "*.git*" -not -path "*.venv*")
MENU_STR="Contents of $1:"
MENU_LEN=$(expr length $MENU_STR)
RED_TEXT="\033[33;31m"

cd "$1"
printf "$MENU_STR\n"
printf "=%.0s" {1..$MENU_LEN}
printf "\n\n$(ls -d */)\n\n"
go_back

for repo in ${(f)DIR_TREE}
do
    cd $repo
    if [[ $(parse_git_dirty) != "*" && -d ".git" ]]; then
        echo -e "$RED_TEXT$repo has uncommitted changes"
    fi
    go_back
done
