---
- hosts: localhost
  vars:
    ansible_python_interpreter: /opt/homebrew/bin/python3
  collections:
    - community.general

  tasks:
    # Ajouter le tap des polices Homebrew
    - name: Add homebrew/cask-fonts tap
      community.general.homebrew_tap:
        name: homebrew/cask-fonts
        state: present

    # Installer les packages Homebrew nécessaires
    - name: Install required brew packages
      community.general.homebrew:
        name: "{{ item }}"
        state: present
      loop:
        - wezterm
        - vim
        - git
        - tmux
        - zsh
        - zsh-autosuggestions
        - zsh-completions
        - zsh-syntax-highlighting
        - eza
        - fzf
        - starship
        - zoxide
        - thefuck

    # Installer les polices requises
    - name: Install required fonts
      community.general.homebrew:
        name: "{{ item }}"
        state: present
      loop:
        - fontconfig
        - font-fira-code-nerd-font
        - font-go-mono-nerd-font
        - font-hack-nerd-font
        - font-jetbrains-mono-nerd-font
        - font-meslo-lg-nerd-font
        - font-monaspace-nerd-font
        - font-noto-sans-symbols-2
        - font-sf-mono-nerd-font-ligaturized  # Correct version of SF Mono Nerd Font

    # Installer Oh My Zsh si non installé
    - name: Install Oh My Zsh if not installed
      shell: |
        if [ ! -d "$HOME/.oh-my-zsh" ]; then
          sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        fi

    # Supprimer l'ancien répertoire du plugin history-substring-search s'il existe
    - name: Remove existing history-substring-search directory if it exists
      file:
        path: "{{ ansible_env.HOME }}/.oh-my-zsh/plugins/history-substring-search"
        state: absent

    # Cloner les plugins Oh My Zsh nécessaires
    - name: Clone zsh-syntax-highlighting plugin
      git:
        repo: https://github.com/zsh-users/zsh-syntax-highlighting.git
        dest: "{{ ansible_env.HOME }}/.oh-my-zsh/plugins/zsh-syntax-highlighting"

    - name: Clone zsh-autosuggestions plugin
      git:
        repo: https://github.com/zsh-users/zsh-autosuggestions.git
        dest: "{{ ansible_env.HOME }}/.oh-my-zsh/plugins/zsh-autosuggestions"

    - name: Clone zsh-completions plugin
      git:
        repo: https://github.com/zsh-users/zsh-completions.git
        dest: "{{ ansible_env.HOME }}/.oh-my-zsh/plugins/zsh-completions"

    - name: Clone history-substring-search plugin
      git:
        repo: https://github.com/zsh-users/zsh-history-substring-search.git
        dest: "{{ ansible_env.HOME }}/.oh-my-zsh/plugins/history-substring-search"

    # Assurer que le répertoire ~/.config existe
    - name: Ensure ~/.config directory exists
      file:
        path: ~/.config
        state: directory
        mode: '0755'

    # Copier les configurations
    - name: Copy WezTerm config
      copy:
        src: files/.wezterm.lua
        dest: ~/.wezterm.lua
        mode: 0644

    - name: Copy Tmux config
      copy:
        src: files/.tmux.conf
        dest: ~/.tmux.conf
        mode: 0644

    - name: Copy Starship config
      copy:
        src: files/starship.toml
        dest: ~/.config/starship.toml
        mode: 0644

    - name: Copy Vim config
      copy:
        src: files/.vimrc
        dest: ~/.vimrc
        mode: 0644

    - name: Copy Zsh config
      copy:
        src: files/.zshrc
        dest: ~/.zshrc
        mode: 0644