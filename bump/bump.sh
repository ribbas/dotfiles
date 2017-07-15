#!/usr/bin/env zsh

# bump
# 
# A convenient way to bump the version string Python projects utilizing
# semantic versioning.
# A version can be bumped manually by providing the increment as an argument
# (major, minor or patch). If no argument is provided, the script will attempt
# to parse the last git commit message to increment.
# 
# NOTE: This script grabs the __version__ string from `$basename*version.py`
# If the version string is located elsewhere, modify VERPATH.
# 
# Usage:
#   ./bump.sh <major|minor|patch>

VERPATH=$(find . -path "*/.venv" -prune -o -name $basename"*version.py" -print)

# in case of multiple results
if [[ $($VERPATH | wc -l) != 1 ]]; then
    echo "Multiple version files found, please execute this script in a" \
        "directory closest to the version file, or modify the path here.";
    exit 1;

else
    echo "Version file found at $VERPATH"

fi

bump () {

    # grab the version line
    VERLINE=$(cat $VERPATH | grep "__version__")

    # grab the nth integer of the version string, and increment it
    BUMP=$(expr $(echo $VERLINE | grep -o -E "[0-9]+" | sed "$1q;d") + 1)

    # replace the version string with the incremented version
    NEWVERSION=$(echo $VERLINE | sed "s/[0-9]/$BUMP/$1")

    # replace the version in the file
    sed -i "/__version__/ c $NEWVERSION" $VERPATH

}

# if argument is provided as "major", "minor" or "patch"
if [[ $1 = "major" ]]; then
    bump 1;

elif [[ $1 = "minor" ]]; then
    bump 2;

elif [[ $1 = "patch" ]]; then
    bump 3;

# if no argument is provided, attempt to parse the last commit message
else

    COMMITMSG=$(<.git/COMMIT_EDITMSG);

    if echo "$COMMITMSG" | grep "major" &> /dev/null; then
        bump 1;

    elif echo "$COMMITMSG" | grep "minor" &> /dev/null; then
        bump 2;

    else
        bump 3;

    fi

    # edit last commit by updating version file
    git add $VERPATH
    git commit --amend --no-edit

fi
