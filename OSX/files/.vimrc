" .vimrc de base

" Activer la numérotation des lignes
set number

" Activer la coloration syntaxique
syntax on

" Définir le type de fichier automatiquement
filetype on
filetype plugin on
filetype indent on

" Activer les indentations automatiques
set autoindent
set smartindent
set tabstop=4       " Afficher les tabulations comme 4 espaces
set shiftwidth=4    " Utiliser 4 espaces pour le niveau d'indentation
set expandtab       " Convertir les tabs en espaces

" Activer le mode recherche incrémentale
set incsearch
set hlsearch        " Surligner les résultats de la recherche

" Activer le mode visuel pour sélectionner des blocs de texte
set mouse=a         " Activer la souris dans tous les modes

" Activer la gestion des fichiers par buffer
set hidden          " Permet de changer de buffer sans sauvegarder

" Activer la barre d'état
set laststatus=2

" Améliorer les performances avec des fichiers volumineux
set lazyredraw      " Ne pas redessiner pendant l'exécution des macros
set ttyfast         " Plus rapide pour les terminaux rapides

" Activer le copier-coller avec le presse-papiers système
set clipboard=unnamedplus

" Afficher l'indentation avec des points
set list
set listchars=tab:»·,trail:·,extends:>,precedes:<

" Désactiver les sons d'alerte
set noerrorbells
set visualbell
set t_vb=

" Sauvegarder automatiquement les modifications toutes les 100 frappes
set updatetime=100

" Mettre a jour l ecran après 300ms d inactivite
set timeoutlen=300

" fzf
set rtp+=/opt/homebrew/opt/fzf
