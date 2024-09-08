# History configuration
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history           # Share history between sessions
setopt hist_expire_dups_first  # Remove older duplicates first
setopt hist_ignore_dups        # Ignore consecutive duplicates in history
setopt hist_verify             # Show command before execution for verification

# Shortcuts to navigate history with arrow keys
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Aliases
alias ls="eza --icons=always"  # Use eza to list files with icons

# ---- Zoxide (better cd command) ----
eval "$(zoxide init zsh)"  # Zoxide, a fast replacement for cd

# Fzf integration for completion
source <(fzf --zsh)

# Load plugins installed via Homebrew (without Oh My Zsh)
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Alias for 'thefuck', a command corrector
eval $(thefuck --alias)

# Add Visual Studio Code to PATH
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Function to rename the TMUX window with the remote hostname during an SSH connection
ssh() {
    if [ -n "$TMUX" ]; then
        tmux set-window-option automatic-rename off 1>/dev/null
        tmux rename-window "ssh: $(echo $@ | awk '{print $NF}' | sed 's/.*@//')"
        command ssh "$@"
        tmux set-window-option automatic-rename on 1>/dev/null
    else
        command ssh "$@"
    fi
}

# Function to update the TMUX window name with the current directory name
function update_tmux_window_name {
    if [ -n "$TMUX" ]; then
        tmux rename-window "$(basename $PWD)"
    fi
}
chpwd_functions+=(update_tmux_window_name)

# Configuration for Node Version Manager (NVM)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Add some additional paths
export PATH="$PATH:/Users/cmassieu/.local/bin"
export PATH="/opt/homebrew/opt/gawk/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"

# Initialize the Starship prompt (Starship fully manages the prompt)
eval "$(starship init zsh)"