#!/bin/bash

# Demander les droits sudo dès le début
sudo -v

# Fonction pour vérifier le succès de chaque étape
check_success() {
    if [ $? -ne 0 ]; then
        echo "Erreur : $1 a échoué. Abandon du script."
        exit 1
    fi
}

# Installation de Homebrew si non installé
if ! command -v brew &> /dev/null; then
    echo "Homebrew non détecté, installation en cours..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    check_success "Installation de Homebrew"

    # Ajouter Homebrew au PATH
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$(whoami)/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    check_success "Ajout de Homebrew au PATH"
fi

# Installation d'Ansible si non installé
if ! command -v ansible &> /dev/null; then
    echo "Ansible non détecté, installation via Homebrew..."
    brew install ansible
    check_success "Installation d'Ansible"
fi

# Installation de la collection Ansible homebrew
echo "Installation de la collection Ansible homebrew..."
ansible-galaxy collection install community.general
check_success "Installation de la collection Ansible homebrew"

# Exécution du playbook Ansible en local avec sudo
echo "Exécution du playbook Ansible..."
sudo ansible-playbook -i localhost, -c local playbook.yml
check_success "Exécution du playbook Ansible"

echo "Configuration terminée. Redémarre ton terminal pour appliquer les changements."