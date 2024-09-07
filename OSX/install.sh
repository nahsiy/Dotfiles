#!/bin/bash

# Demander les droits sudo dès le début
sudo -v

# Installation de Homebrew si non installé
if ! command -v brew &> /dev/null; then
    echo "Homebrew non détecté, installation en cours..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Ajouter Homebrew au PATH
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$(whoami)/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Installation d'Ansible si non installé
if ! command -v ansible &> /dev/null; then
    echo "Ansible non détecté, installation via Homebrew..."
    brew install ansible
fi

# Installation de la collection Ansible homebrew
echo "Installation de la collection Ansible homebrew..."
ansible-galaxy collection install community.general

# Exécution du playbook Ansible en local
echo "Exécution du playbook Ansible..."
ansible-playbook -i localhost, -c local playbook.yml

echo "Configuration terminée. Redémarre ton terminal pour appliquer les changements."