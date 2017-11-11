# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export TERM="xterm-256color"

# Path to your oh-my-zsh installation.
  export ZSH=/home/aissa/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="powerline"
ZSH_THEME="powerlevel9k/powerlevel9k"
DISABLE_UPDATE_PROMPT=true

# POWERLEVEL9K_MODE='awesome-patched'
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$'\uE0C0'
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=$'\uE0C2'
POWERLEVEL9K_STATUS_VERBOSE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context dir vcs root_indicator)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time background_jobs load virtualenv)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_OS_ICON_BACKGROUND="blue"
POWERLEVEL9K_OS_ICON_FOREGROUND="black"
POWERLEVEL9K_DIR_HOME_BACKGROUND="white"
POWERLEVEL9K_DIR_HOME_FOREGROUND="black"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="blue"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="black"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="green"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="black"
if [ "$USER" != "root" ]; then
	export DEFAULT_USER="$USER"
fi


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncommen tthe following line if you want to disable marking untracked files
export LANG=fr_FR.UTF-8
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=fr_FR.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
##############
# Mes Aliases #
###############

# Apt-get
alias maj='sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade'
alias up='sudo apt-get update'
alias install='sudo apt-get install'
alias autoremove='sudo apt-get autoremove'
alias autoclean='sudo apt-get autoclean'
alias cache='sudo apt-cache search'

# Moves
alias cddl="cd ~/Téléchargements"
alias cl='clear'
alias ll='ls -la'

# Network
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

# Archives
alias ntar="tar -cf"
alias gz="tar -zcvf"
alias bz="tar -jcvf"
alias zp="zip"
alias ugz="tar -zxf"
alias ubz="tar -jxf"
alias utar="tar -xf"
alias uzp="unzip"
alias ltar="tar -tf"
alias lbz="tar -jtf"
alias lgz="tar -ztf"
alias lzp="unzip -l"
alias llz="tar --lzma -tf"
alias ulz="tar --lzma -xf"
alias lz="tar --lzma -cvf"

#logs
alias syslog="tail -f /var/log/syslog | ccze -A"

# Files search
## fichiers modifiés dans les 48h
alias modifies="find . -mtime -1 -print | more"

# SSH
alias sshdedie="ssh yishan@163.172.221.136 -p 22000"


# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	        source /etc/profile.d/vte.sh
		fi
