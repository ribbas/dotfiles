#!/bin/sh
set -o errexit

setup_zsh () {
    # ZSH and other shell configs
    echo "Installing ZSH..."
    sudo apt install zsh -y
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended"
    echo -e "if [ -t 1 ]; then\nwhich zsh &>/dev/null && exec zsh\nfi" > ${HOME}/.bashrc

    # customized ls
    echo "Installing colorls..."
    sudo apt install ruby-full -y
    sudo gem install colorls

    # download ccat from https://github.com/jingweno/ccat/releases
    echo "Installing ccat..."
    curl -sL https://github.com/jingweno/ccat/releases/download/v1.1.0/linux-amd64-1.1.0.tar.gz | tar xz
    sudo mkdir -p /usr/share/ccat
    sudo mv linux-amd64-1.1.0/ccat /usr/share/ccat/ccat
    rm -rf linux-amd64-1.1.0

    # custom fonts
    echo "Installing custom fonts..."
    curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/DejaVuSansMono.zip -o DejaVuSansMono.zip
    unzip DejaVuSansMono.zip -d ${HOME}/.fonts
    rm -rf DejaVuSansMono.zip

    ZSH_CUSTOM=${HOME}/.oh-my-zsh/custom

    # PowerLevel9K theme for ZSH
    echo "Installing PowerLevel9K..."
    git clone https://github.com/bhilburn/powerlevel9k.git ${ZSH_CUSTOM}/themes/powerlevel9k

    # zsh-autosuggestions plugin for ZSH
    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions

}
