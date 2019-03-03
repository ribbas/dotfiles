#!/bin/bash
set -o errexit

print_help () {
    echo "Good luck lol"
    exit
}

vm_tools () {
    # VM guest tools
    sudo apt install open-vm-tools-desktop    
}

gnome_extensions () {
    # Gnome tweaks and extensions
    sudo apt install gnome-tweaks gnome-shell-extensions chrome-gnome-shell
}

setup_git() {

    # # Git
    if [ -z $1 ] || [ -z $2 ]
      then
        echo -e "Please provide both your GitHub username and email\nExample: \`username email\`"
    else
        sudo apt install git
        git config --global user.name ${git_user}
        git config --global user.email ${git_email}
        git config --global credential.helper store
    fi

}

misc_apt () {
    # APT repos and other HTTP processes
    sudo apt install curl wget apt-transport-https ca-certificates software-properties-common    
}

setup_subl () {
    # Sublime Text
    curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
    sudo add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"
    sudo apt update && sudo apt install sublime-text    
}

setup_zsh () {
    # ZSH and other shell configs
    sudo apt install zsh
    touch .zshrc
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    echo -e 'if [ -t 1 ]; then\n\texec zsh\nfi' | cat - .bashrc > temp && mv temp .bashrc
    # download ccat https://github.com/jingweno/ccat/releases
    curl -sL https://github.com/jingweno/ccat/releases/download/v1.1.0/linux-amd64-1.1.0.tar.gz | tar xz
    sudo mkdir -p /usr/share/ccat
    sudo mv linux-amd64-1.1.0/ccat /usr/share/ccat/ccat
    rm -rf linux-amd64-1.1.0
    sudo apt-get install fonts-powerline    
}

py_dev () {
    # Python
    sudo apt install build-essential libssl-dev libffi-dev python-dev python3-venv python3-pip
}

extra_configs () {
    # wrapping up extran configurations
    subl .
    git clone https://github.com/sabbirahm3d/.extra-configs
    cp config/zsh/.zshrc $HOME/.zshrc
    cp config/zsh/bullet-train.zsh-theme $HOME/.oh-my-zsh/themes/bullet-train.zsh-theme
    cp config/sublime/*.sublime-settings $HOME/.config/sublime*/Packages/User/
}

while [ ! $# -eq 0 ]
do
    case "$1" in

        --all)
            # vm_tools
            gnome_extensions
            misc_apt
            setup_subl
            setup_zsh
            python-dev
            extra_configs
            ;;

        --help | -h | --please-help | --wtf-is-this)
            print_help
            ;;

        --vm)
            vm_tools
            ;;

        --gnome-ext)
            gnome_extensions
            ;;

        --git=*)
            setup_git "${1#*=}" "${2#*=}"
            ;;

        --apt)
            misc_apt
            ;;

        --subl)
            setup_subl
            ;;

        --zsh)
            setup_zsh
            ;;

        --python)
            python-dev
            ;;

        --config)
            extra_configs
            ;;

    esac
    shift
done
