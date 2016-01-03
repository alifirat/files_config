# /etc/zsh/zshrc ou ~/.zshrc
# Fichier de configuration principal de zsh, lu au lancement des shells interactifs
# (et non des shells d'interprétation de fichier)
# Formation Debian GNU/Linux par Alexis de Lattre
# http://formation-debian.via.ecp.fr/

################
# 1. Les alias #
################

# Raccourci pour libreoffice
alias lib='libreoffice'

# Gestion du 'ls' : couleur & ne touche pas aux accents
alias ls='ls --classify --tabsize=0 --literal --color=auto --show-control-chars --human-readable'

# Demande confirmation avant d'écraser un fichier
alias cp='cp --interactive'
alias mv='mv --interactive'
alias rm='rm -i'
alias todo='/home/afk/dev/todo.txt_cli-2.9/todo.sh'

# Raccourcis pour 'ls'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

# Quelques alias pratiques
alias c='clear'
alias less='less --quiet'
alias df='df --human-readable'
alias du='du --human-readable'
alias mano='emacs -nw'
alias emacs='emacs -r'
alias ocaml='ledit ocaml'
alias lucien='ssh kilic@lucien.informatique.univ-paris-diderot.fr'
alias nivose='ssh -X kilic@nivose.informatique.univ-paris-diderot.fr'
alias go='gnome-open'
alias mysql='mysql -u root -p'
alias argouml='java -jar ~/bin/uml/argouml.jar'
# Charger les key binding à la emacs 
bindkey -e 

#######################################
# 2. Prompt et définition des touches #
#######################################

# Exemple : ma touche HOME, cf  man termcap, est codifiee K1 (upper left
# key  on keyboard)  dans le  /etc/termcap.  En me  referant a  l'entree
# correspondant a mon terminal (par exemple 'linux') dans ce fichier, je
# lis :  K1=\E[1~, c'est la sequence  de caracteres qui sera  envoyee au
# shell. La commande bindkey dit simplement au shell : a chaque fois que
# tu rencontres telle sequence de caractere, tu dois faire telle action.
# La liste des actions est disponible dans "man zshzle".

# Correspondance touches-fonction
bindkey ''    beginning-of-line       # Home
bindkey ''    end-of-line             # End
bindkey ''    delete-char             # Del
bindkey '[3~' delete-char             # Del
bindkey '[2~' overwrite-mode          # Insert
bindkey '[5~' history-search-backward # PgUp
bindkey '[6~' history-search-forward  # PgDn
bindkey ';5D'   backward-word           # Ctrl + left
bindkey ';5C'   forward-word            # Ctrl + right

# Prompt couleur (la couleur n'est pas la même pour le root et
# pour les simples utilisateurs)
if [ "`id -u`" -eq 0 ]; then
  export PS1="%{[36;1m%}%T %{[34m%}%n%{[3	3m%}@%{[37m%}%m %{[32m%}%~%{[33m%}%#%{[0m%} "
else
  export PS1="%{[33;1m%}> %{[32m%}%. %{[37;1m%}$%{[0m%} "
fi

export RPS1="%B[%*]%b"

# Prise en charge des touches [début], [fin] et autres
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}	
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char


# Titre de la fenêtre d'un xterm
case $TERM in
   xterm*)
       precmd () {print -Pn "\e]0;%n@%m: %~\a"}
       ;;
esac

# Gestion de la couleur pour 'ls' (exportation de LS_COLORS)
if [ -x /usr/bin/dircolors ]
then
  if [ -r ~/.dir_colors ]
  then
    eval "`dircolors ~/.dir_colors`"
  elif [ -r /etc/dir_colors ]
  then
    eval "`dircolors /etc/dir_colors`"
  else
    eval "`dircolors`"
  fi
fi


###########################################
# 3. Options de zsh (cf 'man zshoptions') #
###########################################

# Je ne veux JAMAIS de beeps
unsetopt beep
unsetopt hist_beep
unsetopt list_beep
# >| doit être utilisés pour pouvoir écraser un fichier déjà existant ;
# le fichier ne sera pas écrasé avec '>'
# unsetopt clobber
# Ctrl+D est équivalent à 'logout'
unsetopt ignore_eof
# Affiche le code de sortie si différent de '0'
#setopt print_exit_value
# Demande confirmation pour 'rm *'
unsetopt rm_star_silent
# Correction orthographique des commandes
# Désactivé car, contrairement à ce que dit le "man", il essaye de
# corriger les commandes avant de les hasher
#setopt correct
# Si on utilise des jokers dans une liste d'arguments, retire les jokers
# qui ne correspondent à rien au lieu de donner une erreur
setopt nullglob

# Schémas de complétion

# - Schéma A :
# 1ère tabulation : complète jusqu'au bout de la partie commune
# 2ème tabulation : propose une liste de choix
# 3ème tabulation : complète avec le 1er item de la liste
# 4ème tabulation : complète avec le 2ème item de la liste, etc...
# -> c'est le schéma de complétion par défaut de zsh.

# Schéma B :
# 1ère tabulation : propose une liste de choix et complète avec le 1er item
#                   de la liste
# 2ème tabulation : complète avec le 2ème item de la liste, etc...
# Si vous voulez ce schéma, décommentez la ligne suivante :
#setopt menu_complete

# Schéma C :
# 1ère tabulation : complète jusqu'au bout de la partie commune et
#                   propose une liste de choix
# 2ème tabulation : complète avec le 1er item de la liste
# 3ème tabulation : complète avec le 2ème item de la liste, etc...
# Ce schéma est le meilleur à mon goût !
# Si vous voulez ce schéma, décommentez la ligne suivante :
#unsetopt list_ambiguous
# (Merci à Youri van Rietschoten de m'avoir donné l'info !)

# Options de complétion
# Quand le dernier caractère d'une complétion est '/' et que l'on
# tape 'espace' après, le '/' est effacé
setopt auto_remove_slash
# Ne fait pas de complétion sur les fichiers et répertoires cachés
unsetopt glob_dots

# Traite les liens symboliques comme il faut
setopt chase_links

# Quand l'utilisateur commence sa commande par '!' pour faire de la
# complétion historique, il n'exécute pas la commande immédiatement
# mais il écrit la commande dans le prompt
setopt hist_verify
# Si la commande est invalide mais correspond au nom d'un sous-répertoire
# exécuter 'cd sous-répertoire'
setopt auto_cd
# L'exécution de "cd" met le répertoire d'où l'on vient sur la pile
setopt auto_pushd
# Ignore les doublons dans la pile
setopt pushd_ignore_dups
# N'affiche pas la pile après un "pushd" ou "popd"
setopt pushd_silent
# "pushd" sans argument = "pushd $HOME"
setopt pushd_to_home

# Les jobs qui tournent en tâche de fond sont nicé à '0'
unsetopt bg_nice
# N'envoie pas de "HUP" aux jobs qui tourent quand le shell se ferme
unsetopt hup


###############################################
# 4. Paramètres de l'historique des commandes #
###############################################

# Nombre d'entrées dans l'historique
export HISTORY=100000
export SAVEHIST=100000

# Fichier où est stocké l'historique
export HISTFILE=$HOME/.history

# Ajoute l'historique à la fin de l'ancien fichier
#setopt append_history

# Chaque ligne est ajoutée dans l'historique à mesure qu'elle est tapée
setopt inc_append_history

# Ne stocke pas  une ligne dans l'historique si elle  est identique à la
# précédente
setopt hist_ignore_all_dups

# Supprime les  répétitions dans le fichier  d'historique, ne conservant
# que la dernière occurrence ajoutée
#setopt hist_ignore_all_dups

# Supprime les  répétitions dans l'historique lorsqu'il  est plein, mais
# pas avant
setopt hist_expire_dups_first

# N'enregistre  pas plus d'une fois  une même ligne, quelles  que soient
# les options fixées pour la session courante
#setopt hist_save_no_dups

# La recherche dans  l'historique avec l'éditeur de commandes  de zsh ne
# montre  pas  une même  ligne  plus  d'une fois,  même  si  elle a  été
# enregistrée
setopt hist_find_no_dups

# EDITOR
export EDITOR="emacs -r"

###########################################
# 5. Complétion des options des commandes #
###########################################

zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}'
zstyle ':completion:*' max-errors 3 numeric
zstyle ':completion:*' use-compctl false

autoload -U compinit
compinit

export SVN_EDITOR='emacs -nw'

# OPAM configuration
. /home/afk/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

export PATH=$PATH:/home/afk/bin

# ZSH Theme - Preview: http://dl.dropbox.com/u/4109351/pics/gnzh-zsh-theme.png
# Based on bira theme
export SHELL=/bin/zsh
# load some modules
autoload -U colors zsh/terminfo # Used in the colour alias below
colors
setopt prompt_subst

# make some aliases for the colours: (could use normal escape sequences too)
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
  eval PR_$color='%{$fg[${(L)color}]%}'
done
eval PR_NO_COLOR="%{$terminfo[sgr0]%}"
eval PR_BOLD="%{$terminfo[bold]%}"

# Check the UID
if [[ $UID -ne 0 ]]; then # normal user
  eval PR_USER='${PR_GREEN}%n${PR_NO_COLOR}'
  eval PR_USER_OP='${PR_GREEN}%#${PR_NO_COLOR}'
  local PR_PROMPT='$PR_NO_COLOR➤ $PR_NO_COLOR'
else # root
  eval PR_USER='${PR_RED}%n${PR_NO_COLOR}'
  eval PR_USER_OP='${PR_RED}%#${PR_NO_COLOR}'
  local PR_PROMPT='$PR_RED➤ $PR_NO_COLOR'
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
    eval PR_HOST='${PR_YELLOW}%M${PR_NO_COLOR}' #SSH
else
    eval PR_HOST='${PR_GREEN}%M${PR_NO_COLOR}' # no SSH
fi

local return_code="%(?..%{$PR_RED%}%? ↵%{$PR_NO_COLOR%})"

local user_host='%{$PR_BOLD$PR_YELLOW%}${PR_USER}${PR_CYAN}@${PR_HOST}'
local current_dir='%{$PR_BOLD$PR_BLUE%}%~%{$PR_NO_COLOR%}'
local rvm_ruby=''
if ${HOME}/.rvm/bin/rvm-prompt &> /dev/null; then # detect local user rvm installation
  rvm_ruby='%{$PR_RED%}‹$(${HOME}/.rvm/bin/rvm-prompt i v g s)›%{$PR_NO_COLOR%}'
elif which rvm-prompt &> /dev/null; then # detect sysem-wide rvm installation
  rvm_ruby='%{$PR_RED%}‹$(rvm-prompt i v g s)›%{$PR_NO_COLOR%}'
elif which rbenv &> /dev/null; then # detect Simple Ruby Version management
  rvm_ruby='%{$PR_RED%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$PR_NO_COLOR%}'
fi

function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

local git_branch='$(git_prompt_info)%{$PR_NO_COLOR%}'

#PROMPT="${user_host} ${current_dir} ${rvm_ruby} ${git_branch}$PR_PROMPT "
PROMPT="╭─${user_host} [${current_dir}] ${git_branch}
╰─$PR_PROMPT"

RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$PR_YELLOW%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$PR_NO_COLOR%}"

## pour avoir l'heure à droite
RPROMPT="%{$PR_BOLD$PR_RED%}[%T]%{$PR_NO_COLOR%}"

# Commande pour entrer dans un répertoire fraichement crée
mkcd() {
	mkdir "$1"
	cd "$1"
}







