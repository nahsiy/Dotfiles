#!/bin/bash

# Request sudo privileges at the beginning
sudo -v

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not detected, installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$(whoami)/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install Ansible if not already installed
if ! command -v ansible &> /dev/null; then
    echo "Ansible not detected, installing via Homebrew..."
    brew install ansible
fi

# Install the Ansible homebrew collection
echo "Installing Ansible homebrew collection..."
ansible-galaxy collection install community.general

# Run the Ansible playbook
echo "Running Ansible playbook..."
ansible-playbook -i localhost, -c local playbook.yml --ask-become-pass

# Check for success
if [ $? -eq 0 ]; then
    echo "Configuration complete. Restart your terminal to apply the changes."
else
    echo "Error: Ansible playbook execution failed."
fi