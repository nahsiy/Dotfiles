#!/bin/bash

# Installation de Homebrew si non installé
if ! command -v brew &> /dev/null; then
    echo "Homebrew non détecté, installation en cours..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Installation d'Ansible si non installé
if ! command -v ansible &> /dev/null; then
    echo "Ansible non détecté, installation via Homebrew..."
    brew install ansible
fi

# Installation de la collection Ansible homebrew
echo "Installation de la collection Ansible homebrew..."
ansible-galaxy collection install community.general

# Clonage du dépôt Dotfiles
if [ ! -d "$HOME/Dotfiles" ]; then
    echo "Clonage du dépôt Dotfiles..."
    git clone https://github.com/nahsiy/Dotfiles.git "$HOME/Dotfiles"
fi

# Déplacement dans le répertoire Dotfiles
cd "$HOME/Dotfiles" || exit

# Exécution du playbook Ansible en local
echo "Exécution du playbook Ansible..."
ansible-playbook -i localhost, -c local playbook.yml

echo "Configuration terminée avec succès."
echo "Redémarre ton terminal ou ta session pour appliquer les changements."