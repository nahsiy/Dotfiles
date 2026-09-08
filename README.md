# Dotfiles

Un environnement de terminal personnel pour Linux et macOS :
Zsh, tmux, Vim / Neovim, WezTerm et Starship.

La version publique privilégie des réglages portables et des dépendances
facultatives. Zsh démarre sans Homebrew, fzf ou Starship ; tmux fonctionne
sans gestionnaire de plugins.

## Ce qui est fourni

| Composant | Choix |
| --- | --- |
| Zsh | Historique partagé, complétion, alias Git, outils facultatifs détectés |
| tmux | Préfixe `Ctrl+a`, souris, découpes dans le dossier courant, thème intégré |
| Vim / Neovim | Numérotation, recherche, indentation, aucun plugin obligatoire |
| WezTerm | Tokyo Night, police JetBrainsMono Nerd Font, shell habituel au démarrage |
| Starship | Prompt compact avec contexte Git, langages et heure |
| Ansible | Aperçu, sauvegarde des fichiers remplacés, exécutions idempotentes |
| Homebrew | Liste explicite des paquets et casks, installation séparée |

## Prérequis

Pour installer les fichiers : Python 3.11+, Ansible Core et Bash.
Sur macOS, Homebrew est nécessaire seulement pour l'étape facultative des
paquets. Sous Linux, utilisez votre gestionnaire de paquets.
tmux nécessite la version 3.2 ou supérieure.

```bash
git clone https://github.com/nahsiy/Dotfiles.git
cd Dotfiles
```

### 1. Paquets macOS, si nécessaire

Avec [Homebrew](https://brew.sh) déjà installé et disponible dans le PATH :

```bash
bash OSX/install.sh --packages
```

Cette commande utilise [OSX/Brewfile](OSX/Brewfile), installe notamment Ansible,
WezTerm et la police, puis s'arrête. Elle ne déploie aucun dotfile et ne lance
pas de mise à niveau des paquets déjà présents. Le dépôt n'installe pas
Homebrew à votre place.

### 2. Aperçu

```bash
bash OSX/install.sh
# équivalent à :
bash OSX/install.sh --check
```

L'aperçu ne remplace aucun dotfile et ne crée pas la destination. Ansible peut
utiliser ses propres fichiers temporaires. Les contenus existants ne sont pas
affichés dans les logs.

### 3. Installation explicite

```bash
bash OSX/install.sh --apply
```

Les fichiers différents sont remplacés après sauvegarde horodatée par Ansible.
Un second passage sans changement n'écrit rien. Les chemins gérés sont :

- `~/.zshrc`, `~/.tmux.conf`, `~/.vimrc`, `~/.wezterm.lua` ;
- `~/.config/starship.toml` et `~/.config/nvim/init.vim`.

L'installateur utilise `.config` sous la destination. Si vous utilisez un
`XDG_CONFIG_HOME` différent, adaptez les destinations du playbook avant
installation. Un fichier ou dossier cible qui est un lien symbolique est
refusé afin de préserver une installation gérée par un autre outil.

Pour tester sans toucher à votre configuration :

```bash
dotfiles_demo="$(mktemp -d)"
bash OSX/install.sh --check --target-dir "$dotfiles_demo"
bash OSX/install.sh --apply --target-dir "$dotfiles_demo"
```

Le chemin du dépôt et celui de la destination peuvent contenir des espaces.
Le script peut être lancé depuis un autre répertoire.

## Personnalisation et retour arrière

Ajoutez vos réglages privés dans `~/.zshrc.local` et `~/.tmux.conf.local`.
Ces fichiers ne sont pas versionnés ni remplacés. L'identité Git, les
identifiants, les accès SSH et les paramètres professionnels restent à part.

L'installation ne change pas votre shell de connexion, ne demande pas sudo,
ne modifie pas `/private/tmp` et ne lance pas tmux automatiquement.
Pour utiliser Zsh ou tmux : lancez `zsh` ou `tmux new-session -A -s main`.

En cas de besoin, retrouvez la sauvegarde horodatée à côté du fichier remplacé
et recopiez-la sur ce fichier après vérification. Les fichiers créés pour la
première fois n'ont pas de sauvegarde antérieure. Les paquets Homebrew sont
gérés séparément.

## Vérifications

```bash
make verify   # ShellCheck, syntaxes, démarrage Vim/Neovim, playbook
make test     # inclut les tests réels dans des dossiers temporaires
```

Outils de validation : ShellCheck, Zsh, Lua (`luac`), tmux, Vim, Neovim,
Ansible Core, Python et Make.

Les tests couvrent l'aperçu, l'installation, l'idempotence, les sauvegardes,
les liens symboliques, les chemins invalides, le démarrage minimal de Zsh
et un serveur tmux isolé. Le workflow GitHub Actions exécute ces contrôles
sous Linux. L'installation Homebrew et le rendu graphique complet ne sont
pas couverts par ces tests.

## Organisation

Les fichiers à la racine restent disponibles pour une reprise manuelle.
Le playbook utilise leurs copies dans `OSX/files/` ; un test empêche leur
divergence. Le dossier `OSX` est conservé pour les anciens liens, mais le
déploiement des fichiers fonctionne également sous Linux.

Le dépôt `fastfetch/` reste un exemple indépendant, non installé par le script.
L'[aperçu historique](OSX/show.png) documente l'ancienne apparence du terminal.

## Sources

- [Sauvegardes et mode check Ansible](https://docs.ansible.com/projects/ansible/latest/collections/ansible/builtin/copy_module.html)
- [WezTerm](https://wezterm.org/config/files.html)
- [Intégration shell fzf](https://github.com/junegunn/fzf#setting-up-shell-integration)
- [tmux](https://github.com/tmux/tmux/wiki/Getting-Started)

[Profil GitHub](https://github.com/nahsiy) ·
[Portfolio](https://christophe-massieu.com/)
