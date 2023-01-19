# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000000000
SAVEHIST=1000000000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
#
# The following lines were added by compinstall
zstyle :compinstall filename '/home/chris/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

alias cat=bat
alias ls=exa
alias burn="rm -rf"
alias gs="git status"
alias gl="git log"
alias gll="git ll"
alias gd="git diff"

export PROMPT='%m %~> '
