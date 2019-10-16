#!/bin/sh
set -o errexit

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

print_help () {
    echo "Good luck lol"
    exit 0
}

vm_tools () {
    # VM guest tools
    echo "${GREEN}Installing VM Tools...${NC}"
    sudo apt install open-vm-tools-desktop
}

sys_tools () {
    # GCC and Makefile
    echo "${GREEN}Installing GNU tools...${NC}"
    sudo apt install gcc make
}

gnome_extensions () {
    # Gnome tweaks and extensions
    echo "${GREEN}Installing Gnome tweaks...${NC}"
    sudo apt install gnome-tweaks gnome-shell-extensions chrome-gnome-shell
}

setup_git() {

    # Git
    echo "${GREEN}Installing and setting up Git...${NC}"
    if [ -z $1 ] || [ -z $2 ]
      then
        echo "${RED}Please provide both your GitHub username and email\nExample: \`username email\`${NC}"
    else
        sudo apt install git
        git config --global user.name $1
        git config --global user.email $2
        git config --global credential.helper store
    fi

}

misc_apt () {
    # APT repos and other HTTP processes
    echo "${GREEN}Installing APT libraries...${NC}"
    sudo apt install curl wget apt-transport-https ca-certificates software-properties-common
}

setup_subl () {
    # Sublime Text
    echo "${GREEN}Installing Sublime Text...${NC}"
    curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
    sudo add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"
    sudo apt update && sudo apt install sublime-text
}

setup_zsh () {
    # ZSH and other shell configs
    echo "${GREEN}Installing ZSH...${NC}"
    sudo apt install zsh
    touch .zshrc
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    echo 'if [ -t 1 ]; then\n\texec zsh\nfi' | cat - .bashrc > temp && mv temp .bashrc

    # customized ls
    echo "${GREEN}Installing colorls...${NC}"
    sudo apt install ruby-full
    sudo gem install colorls

    # download ccat from https://github.com/jingweno/ccat/releases
    echo "${GREEN}Installing ccat...${NC}"
    curl -sL https://github.com/jingweno/ccat/releases/download/v1.1.0/linux-amd64-1.1.0.tar.gz | tar xz
    sudo mkdir -p /usr/share/ccat
    sudo mv linux-amd64-1.1.0/ccat /usr/share/ccat/ccat
    rm -rf linux-amd64-1.1.0

    # custom fonts
    echo "${GREEN}Installing custom fonts...${NC}"
    curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/DejaVuSansMono.zip -o DejaVuSansMono.zip
    unzip DejaVuSansMono.zip -d $HOME/.fonts
    rm -rf DejaVuSansMono.zip

    # PowerLevel9K theme for ZSH
    echo "${GREEN}Installing PowerLevel9K...${NC}"
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
}

py_dev () {
    # Python
    echo "${GREEN}Installing Python development tools...${NC}"
    sudo apt install build-essential libssl-dev libffi-dev python-dev python3-venv python3-pip
}

extra_configs () {
    # wrapping up extra configurations
    echo "${GREEN}Setting up extra configurations...${NC}"
    git clone https://github.com/sabbirahm3d/dotfiles .dotfiles
    ln -f .dotfiles/zsh/.zshrc $HOME/.zshrc
    cp .dotfiles/sublime/* $HOME/.config/sublime*/Packages/User/
    sudo ln scripts/toc.py /usr/bin/toc
}

while [ ! $# -eq 0 ]
do
    case "$1" in

        --all)
            sys_tools
            gnome_extensions
            misc_apt
            setup_subl
            setup_zsh
            py_dev
            extra_configs
            ;;

        --help | -h | --please-help | --wtf-is-this)
            print_help
            ;;

        --vm)
            vm_tools
            ;;

        --sys)
            sys_tools
            ;;

        --gnome-ext)
            gnome_extensions
            ;;

        --git)
            echo "Usage: $0 --git=username email"
            exit 1
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
