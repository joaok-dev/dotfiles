# ~/.zshrc Configuration File

# Load dependencies
[ -f "${ZDOTDIR}/aliasrc" ] && source "${ZDOTDIR}/aliasrc"
[ -f "${ZDOTDIR}/optionrc" ] && source "${ZDOTDIR}/optionrc"
[ -f "${ZDOTDIR}/pluginrc" ] && source "${ZDOTDIR}/pluginrc"

# History configuration
HISTSIZE=110000
SAVEHIST=100000
HISTTIMEFORMAT='[%F %T]'
HISTFILE=~/.histfile

# XDG Base Directory specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Set default editor to nvim
export VISUAL=/usr/local/bin/nvim
export EDITOR=/usr/local/bin/nvim

# Key bindings for history substring search (non-vi mode only)
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[OA' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OB' history-substring-search-down

# Enable colors
autoload -U colors && colors

# Basic completion and theming
autoload -U compinit && compinit
autoload -U zcalc

# Tab completion settings
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' list-colors "${(s.:.)--color=auto}"
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R

# Completion configuration
zstyle :compinstall ~/.config/zsh/.zshrc
autoload -Uz compinit && compinit

# FZF
# Source fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Use ripgrep (rg) with fzf for file search
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

# fzf options
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Function to open files with preview using bat
fzf_preview_file() {
  local file
  file=$(fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

# FZF with Ripgrep
fzf_rg() {
  local file
  file=$(rg --files --hidden --follow --glob "!.git/*" | fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

# Initialize zoxide
eval "$(zoxide init zsh)"

# Starship prompt initialization
eval "$(starship init zsh)"

# asdf
. /opt/asdf-vm/asdf.sh

# Rust environment setup
. "/home/joaok/.asdf/installs/rust/1.79.0/env"

# End of .zshrc

