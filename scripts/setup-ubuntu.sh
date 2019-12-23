#!/bin/sh
set -o errexit

source ./setupgit
source ./setuppython
source ./installzsh
source ./setupsubl

print_help () {
    echo "Good luck lol"
    exit 0
}

essentials () {
    # GCC and Makefile
    echo "Installing GNU tools..."
    sudo apt install gcc make curl wget -y
    sudo apt install build-essential libssl-dev libffi-dev -y
    sudo apt install apt-transport-https ca-certificates software-properties-common -y
    # Gnome tweaks and extensions
    echo "Installing Gnome tweaks..."
    sudo apt install gnome-tweaks gnome-shell-extensions chrome-gnome-shell -y
}

extra_configs () {
    # wrapping up extra configurations
    echo "Setting up extra configurations..."
    # git clone https://github.com/sabbirahm3d/dotfiles .dotfiles
    ln -f ../sublime/* $HOME/.config/sublime*/Packages/User/
    ln -f ../zsh/.aliases $HOME/.aliases
    ln -f ../zsh/.zshrc $HOME/.zshrc
    sudo ln toc.py /usr/bin/toc
}

while [ ! $# -eq 0 ]
do
    case "$1" in

        --all)
            essentials
            setup_git
            setup_subl
            setup_zsh
            py_dev
            extra_configs
            ;;

        --help | -h | --please-help | --wtf-is-this)
            print_help
            ;;

        --vm)
            # VM guest tools
            echo "Installing VM Tools..."
            sudo apt install open-vm-tools-desktop -y
            ;;

        --sys)
            essentials
            ;;

        --git)
            setup_git
            ;;

        --subl)
            setup_subl
            ;;

        --zsh)
            setup_zsh
            ;;

        --python)
            py_dev
            ;;

        --config)
            extra_configs
            ;;

        *)
            echo "Invalid args"
            exit 1
            ;;

    esac
    shift
done
