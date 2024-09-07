# Chemin de Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Plugins Oh My Zsh
plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-completions
    docker
    kubectl
    terraform
    ansible
    tmux
    extract
    history-substring-search
    sudo
    z
)

# Charger Oh My Zsh et les plugins
source $ZSH/oh-my-zsh.sh

# Configuration de l'historique
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history           # Partage l'historique entre les sessions
setopt hist_expire_dups_first  # Supprime les doublons les plus anciens en premier
setopt hist_ignore_dups        # Ignore les doublons successifs dans l'historique
setopt hist_verify             # Affiche la commande avant de l'exécuter pour validation

# Raccourcis pour naviguer dans l'historique avec les flèches
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Aliases
alias ls="eza --icons=always"  # Utilise eza pour lister les fichiers avec des icônes

# ---- Zoxide (meilleur cd) ----
eval "$(zoxide init zsh)"  # Zoxide, un remplacement rapide pour cd

# Alias pour utiliser la version installée par Homebrew de TMUX
alias tmux='/opt/homebrew/bin/tmux'

# Intégration de fzf pour la complétion
source <(fzf --zsh)

# Charger les plugins installés via Homebrew
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH/plugins/history-substring-search/zsh-history-substring-search.zsh

# Alias pour 'thefuck', un correcteur de commandes
eval $(thefuck --alias)

# Ajouter Visual Studio Code à PATH
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Fonction pour renommer la fenêtre TMUX avec le hostname distant lors d'une connexion SSH
ssh() {
    if [ -n "$TMUX" ]; then
        # Désactiver le renommage automatique
        tmux set-window-option automatic-rename off 1>/dev/null
        # Renommer la fenêtre TMUX avec le nom de la machine distante
        tmux rename-window "ssh: $(echo $@ | awk '{print $NF}' | sed 's/.*@//')"
        # Exécuter la commande SSH
        command ssh "$@"
        # Réactiver le renommage automatique après la connexion
        tmux set-window-option automatic-rename on 1>/dev/null
    else
        command ssh "$@"
    fi
}

# Fonction pour mettre à jour le nom de la fenêtre TMUX avec le nom du répertoire courant
function update_tmux_window_name {
    if [ -n "$TMUX" ]; then
        tmux rename-window "$(basename $PWD)"
    fi
}

# Ajouter la fonction de mise à jour du nom de la fenêtre lors du changement de répertoire
chpwd_functions+=(update_tmux_window_name)

# Configuration pour Node Version Manager (NVM)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Charge nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Charge nvm bash_completion

# Add somes paths
export PATH="$PATH:/Users/cmassieu/.local/bin"
export PATH="/opt/homebrew/opt/gawk/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"


# Initialiser le prompt Starship
eval "$(starship init zsh)"