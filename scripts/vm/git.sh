#!/bin/sh
set -o errexit

setup_git() {

    # Git
    echo "Installing and setting up Git..."
    read -p $'Enter your GitHub username: ' username
    read -p $'Enter your GitHub email: ' email
    if [ -z $username ] || [ -z $email ]; then
        echo "Provide both your GitHub username and email\nExample: \`username email\`"
    else
        git config --global user.name $username
        git config --global user.email $email
        git config --global credential.helper store
    fi

}
