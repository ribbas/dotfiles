# ZSH config file

# Path to your oh-my-zsh installation.
export ZSH=/home/sabbir/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
ZSH_THEME="bullet-train"

# Hyphen-insensitive completion. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for
# completion.
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# adds option to change directory to dirname of file
cd() {
  [[ ! -e $argv[-1] ]] || [[ -d $argv[-1] ]] || argv[-1]=${argv[-1]%/*}
  builtin cd "$@"
}

# Aliases
# For a full list of active aliases, run `alias`.

cdthere() {
  cd "$(history | grep "mv" | tail -n1 | grep -oE '[^ ]+$')";
}
alias cdthere="cdthere"

# directory to custom aliases
EXTRA_ALIASES=$HOME/.extra-configs

alias bump="$EXTRA_ALIASES/scripts/bump.sh"
alias highlight="$EXTRA_ALIASES/scripts/highlight.sh"
alias pdf="$EXTRA_ALIASES/scripts/pdf.sh"
alias prettyjson="python -m json.tool"
alias pyup="$EXTRA_ALIASES/scripts/pyup.sh"
alias search="$EXTRA_ALIASES/scripts/search.sh"
alias sysupdate="sudo apt update && sudo apt upgrade -y && sudo apt autoremove && sudo apt autoclean"
alias xclip="xclip -selection c"
alias cat="/usr/share/ccat/ccat -G String='darkgreen' -G Plaintext='blue' -G Comment='darkyellow' -G HTMLTag='purple' -G Literal='darkred' -G Tag='Fuscia'"

# Do menu-driven completion.
zstyle ':completion:*' menu select

# Color completion for some things.
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# Completers for custom aliases
zstyle ':completion:*:*:pdf*:*' file-patterns '*.pdf *(-/)'
zstyle ':completion:*:*:prettyjson*:*' file-patterns '*.json *(-/)'

# configs for work machine (work-vm01)
if [ $(hostname) = "work-vm01" ]; then

    # temporary SST configs
    export SST_CORE_HOME=$HOME/local/sstcore-8.0.0
    export SST_ELEMENTS_HOME=$HOME/local/sstelements-8.0.0

    # add bins to PATH
    # SST
    export PATH=$SST_CORE_HOME/bin:$PATH
    # Clion
    export PATH=/opt/clion-2018.2.5/bin:$PATH

fi
