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

# Aliases
# For a full list of active aliases, run `alias`.

# adds option to change directory to dirname of file
cd() {
  [[ ! -e $argv[-1] ]] || [[ -d $argv[-1] ]] || argv[-1]=${argv[-1]%/*}
  builtin cd "$@"
}

cdthere() {
  cd "$(history | grep "mv" | tail -n1 | grep -oE '[^ ]+$')";
}

EXTRA_CONFIGS=$HOME/.helper-scripts


alias bump="$EXTRA_CONFIGS/scripts/bump.sh"
alias highlight="$EXTRA_CONFIGS/scripts/highlight.sh"
alias cdthere="cdthere"
alias pdf="$EXTRA_CONFIGS/scripts/pdf.sh"
alias prettyjson="python -m json.tool"
alias pyup="$EXTRA_CONFIGS/scripts/pyup.sh"
alias search="$EXTRA_CONFIGS/scripts/search.sh"
alias sysupdate="sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove && sudo apt-get autoclean"

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
