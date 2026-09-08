# Shell interactif portable, sans téléchargement au démarrage.
[[ -o interactive ]] || return 0
typeset -g dotfiles_zdotdir="${ZDOTDIR:-$HOME}"
HISTFILE="$dotfiles_zdotdir/.zsh_history"
HISTSIZE=20000
SAVEHIST=10000
setopt append_history share_history hist_ignore_dups hist_ignore_space
setopt hist_expire_dups_first extended_history interactive_comments
bindkey -e
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

typeset -g dotfiles_brew_prefix=""
if (( $+commands[brew] )); then
  dotfiles_brew_prefix="$(brew --prefix 2>/dev/null)"
elif [[ -x /opt/homebrew/bin/brew ]]; then
  dotfiles_brew_prefix=/opt/homebrew
elif [[ -x /usr/local/bin/brew ]]; then
  dotfiles_brew_prefix=/usr/local
fi
typeset -U path fpath
path=("$HOME/.local/bin" $path)
if [[ -n "$dotfiles_brew_prefix" ]]; then
  path=("$dotfiles_brew_prefix/bin" "$dotfiles_brew_prefix/sbin" $path)
  if [[ -d "$dotfiles_brew_prefix/share/zsh-completions" ]]; then
    fpath=("$dotfiles_brew_prefix/share/zsh-completions" $fpath)
  fi
fi
export PATH
autoload -Uz compinit
# Ignore les répertoires non sûrs sans désactiver le contrôle.
compinit -i -d "$dotfiles_zdotdir/.zcompdump"

alias ..='cd ..'
alias ...='cd ../..'
alias g='git'
alias gs='git status -sb'
alias gd='git diff'
alias gds='git diff --staged'
alias glog='git log --oneline --graph --decorate -15'
if (( $+commands[eza] )); then
  alias ls='eza --icons=auto --group-directories-first'
  alias ll='eza -l --icons=auto --group-directories-first'
  alias la='eza -la --icons=auto --group-directories-first'
else
  alias ll='ls -l'
  alias la='ls -la'
fi
(( $+commands[bat] )) && alias catp='bat --paging=never'
(( $+commands[lazygit] )) && alias lg='lazygit'
# grep, find, cat et ssh conservent leur interface habituelle.
mkcd() { [[ $# -eq 1 ]] && mkdir -p -- "$1" && builtin cd -- "$1"; }
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"
if (( $+commands[fzf] )); then
  # --zsh nécessite fzf >= 0.48 ; les versions anciennes sont ignorées.
  typeset dotfiles_fzf_init
  if dotfiles_fzf_init="$(fzf --zsh 2>/dev/null)"; then
    eval "$dotfiles_fzf_init"
  fi
  unset dotfiles_fzf_init
fi
if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
else
  PROMPT='%n@%m %~ %# '
fi
# Réglages privés hors du dépôt.
[[ -r "$dotfiles_zdotdir/.zshrc.local" ]] && source "$dotfiles_zdotdir/.zshrc.local"
# Coloration après l'initialisation des widgets.
if [[ -n "$dotfiles_brew_prefix" ]]; then
  for dotfiles_plugin in zsh-autosuggestions zsh-syntax-highlighting; do
    dotfiles_plugin_file="$dotfiles_brew_prefix/share/$dotfiles_plugin/$dotfiles_plugin.zsh"
    [[ -r "$dotfiles_plugin_file" ]] && source "$dotfiles_plugin_file"
  done
fi
unset dotfiles_plugin dotfiles_plugin_file
true
