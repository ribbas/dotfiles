#!/usr/bin/env zsh
set -o errexit

# bump
# 
# A convenient way to bump the version string in Python projects utilizing
# semantic versioning.
# A version can be bumped manually by providing the increment as an argument
# (major, minor or patch). If no argument is provided, the script will attempt
# to parse the last git commit message to increment.
# 
# NOTE: This script grabs the VERSTR from `$basename*version.py`
# If the version string is located elsewhere, modify VERPATH.
# 
# Usage:
#   ./bump.sh <major|minor|patch>

# find version files
VERPATH=$(find . -path "*/.venv" -prune -o -name $basename"*version.py" -print)
VERSTR="__version__"  # version string variable

# in case of multiple results
if [[ -z ${VERPATH} ]] || [[ $(echo ${VERPATH} | wc -l) != 1 ]]; then
    echo "Multiple version files found, please execute this script in a" \
        "directory closest to the version file, or modify the path here.";
    exit 1;

else
    echo "Version file found at ${VERPATH}"

fi

incr () {

    # grab the version line
    ver_line=$(cat ${VERPATH} | grep "${VERSTR}")

    # grab the nth integer of the version string, and increment it
    incr_bump=$(expr $(echo ${ver_line} | grep -o -E "[0-9]+" | sed "$1q;d") \
        + 1)

}

bump () {

    incr $1;

    case "$1" in

        "1")
            # replace all the integers with 0, then the first integer with the
            # incremented version
            new_ver=$(echo ${ver_line} | sed "s/\([0-9]\+\)/0/g" | \
                sed "0,/\([0-9]\+\)/s/\([0-9]\+\)/${incr_bump}/")

            ;;
        "2")
            # replace the last integer with 0, then the second integer with the
            # incremented version
            new_ver=$(echo ${ver_line} | sed "s/\(.*[0-9]\.\)[0-9]*/\10/" | \
                sed "s/\(\.*[0-9]\.\)[0-9]*/\1${incr_bump}/")
            ;;

        "3")
            # replace the last integer with the incremented version
            new_ver=$(echo ${ver_line} | sed "s/\(.*[0-9]\.\)[0-9]*/\1${incr_bump}/")
            ;;

    esac

    # replace the version in the file
    sed -i "/${VERSTR}/ c ${new_ver}" ${VERPATH}

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

    commit_msg=$(<.git/COMMIT_EDITMSG);

    if echo "${commit_msg}" | grep "major" &> /dev/null; then
        bump 1;

    elif echo "${commit_msg}" | grep "minor" &> /dev/null; then
        bump 2;

    else
        bump 3;

    fi

    # edit last commit by updating version file
    git add ${VERPATH}
    git commit --amend --no-edit

fi
