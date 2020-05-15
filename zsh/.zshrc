# ZSH config file

# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

ZSH_THEME="powerlevel9k/powerlevel9k"

POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=false
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_beginning"

POWERLEVEL9K_TIME_BACKGROUND="black"
POWERLEVEL9K_TIME_FOREGROUND="249"
POWERLEVEL9K_TIME_FORMAT="\uf017 %D{%I:%M \uf073 %m/%d/%y}"

POWERLEVEL9K_STATUS_VERBOSE=false

POWERLEVEL9K_VCS_CLEAN_FOREGROUND="black"
POWERLEVEL9K_VCS_CLEAN_BACKGROUND="green"
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="black"
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="orangered1"
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="black"
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="darkorange"
POWERLEVEL9K_VCS_UNTRACKED_ICON="\uf059" 
POWERLEVEL9K_VCS_UNSTAGED_ICON="\uf06a"
POWERLEVEL9K_VCS_STAGED_ICON="\uf055"
POWERLEVEL9K_VCS_STASH_ICON="\uf01c "
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON="\uf01a "
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON="\uf01b "
POWERLEVEL9K_VCS_TAG_ICON="\uf02b "
POWERLEVEL9K_VCS_BOOKMARK_ICON="\uf461 "
POWERLEVEL9K_VCS_COMMIT_ICON="\ue729 "
POWERLEVEL9K_VCS_BRANCH_ICON="\uf126 "
POWERLEVEL9K_VCS_REMOTE_BRANCH_ICON="\ue728 "
POWERLEVEL9K_VCS_GIT_ICON="\uf1d3 "

POWERLEVEL9K_VIRTUALENV_FOREGROUND="black"
POWERLEVEL9K_VIRTUALENV_BACKGROUND="yellow"
POWERLEVEL9K_PYTHON_ICON="\ue73c"

POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND="black"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND="blue"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0

POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE=true
POWERLEVEL9K_STATUS_VERBOSE=false

POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{blue}\u256D\u2500%f"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{blue}\u2570\uf460%f "

POWERLEVEL9K_BATTERY_CHARGING="yellow"
POWERLEVEL9K_BATTERY_CHARGED="green"
POWERLEVEL9K_BATTERY_DISCONNECTED="$DEFAULT_COLOR"
POWERLEVEL9K_BATTERY_LOW_THRESHOLD="20"
POWERLEVEL9K_BATTERY_LOW_COLOR="red"
POWERLEVEL9K_BATTERY_ICON="\uf1e6"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir time battery virtualenv vcs root_indicator dir_writable status)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(background_jobs)
HIST_STAMPS="mm/dd/yyyy"

# Hyphen-insensitive completion. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

source $ZSH/oh-my-zsh.sh
source $(dirname $(gem which colorls))/tab_complete.sh

if [[ -a .private-configs/work ]]; then
    source .private-configs/work
fi

# User configuration

# adds option to change directory to dirname of file
cd() {
  [[ ! -e $argv[-1] ]] || [[ -d $argv[-1] ]] || argv[-1]=${argv[-1]%/*}
  builtin cd "$@"
}

# Aliases
# For a full list of active aliases, run `alias`.
source ~/.aliases

# colorize man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

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
