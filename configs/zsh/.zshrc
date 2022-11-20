# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ZSH config file

# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

plugins=(zsh-autosuggestions last-working-dir)
ZSH_AUTOSUGGEST_USE_ASYNC=true

ZSH_THEME="powerlevel10k/powerlevel10k"

# Hyphen-insensitive completion. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

source ${ZSH}/oh-my-zsh.sh
source $(dirname $(gem which colorls))/tab_complete.sh

# User configuration

# adds option to change directory to dirname of file
cd() {
  [[ ! -e $argv[-1] ]] || [[ -d $argv[-1] ]] || argv[-1]=${argv[-1]%/*}
  builtin cd "$@"
}

# adds preprocessing to saving command history
zshaddhistory() {
  setopt RE_MATCH_PCRE
  1=$(echo ${1} | sed 's@~@'${HOME}'@g')
  if [[ ${1} =~ "(?<=\W|^)(cp|mv)(?=\s)" ]]; then

    _file1=$(echo ${1} | awk 'NF>1{ print $(NF-1) }')
    _file2=$(echo ${1} | awk 'NF>1{ print $(NF) }')
    [[ "${_file1}" != "${HOME}"* ]] && _file1="${PWD}/${_file1}"
    [[ "${_file2}" != "${HOME}"* ]] && _file2="${PWD}/${_file2}"
    export LAST_CMD="${match[1]} ${_file1} ${_file2}"
    export UNDO=

  elif [[ ${1} =~ "(?<=\W|^)(mkdir)(?=\s)" ]]; then

    _files=("${(@s/ /)$(echo ${1} | awk -F"${match[1]} " '{print $(NF)}')}")
    for ((i = 1; i <= $#_files; i++)); do
      [[ "${_files[i]}" != "${HOME}"* ]] && _files[i]="${PWD}/${_files[i]}"
    done
    export LAST_CMD="${match[1]} ${_files}"
    export UNDO=

  fi

  return 0
}

# Aliases
if [[ -d ${HOME}/.aliases ]]; then
  for file in ${HOME}/.aliases/.*; do
    source "$file"
  done
fi

# Private configs
if [[ -f ${HOME}/.private-configs ]]; then
  source "${HOME}/.private-configs"
fi

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
zstyle ':completion:*:*:llatex*:*' file-patterns '*.tex *(-/)'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
