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

alias grep="grep --color=auto"
alias cat=bat
alias ls=exa
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias burn="rm -rf"
alias gs="git status"
alias gl="git log"
alias gll="git ll"
alias gd="git diff"

### Used by prompts to tell whether or not the current terminal is ssh'd
currently_local()
{
    if test $(echo $SSH_CONNECTION | wc -m) -gt 1
    then
        return 1
    else
        return 0
    fi
}

export VISUAL=vim
export EDITOR=vim
export PATH=$PATH:~/bin

if $(currently_local)
then
    export PROMPT='%n %(!.#.)%4~> '
else
    export PROMPT='%n@%m %(!.#.)%4~> '
fi

function append-last-word { ((++CURSOR)); zle insert-last-word; zle vi-add-eol; }
zle -N append-last-word
bindkey -M vicmd . append-last-word

zle -A backward-delete-char vi-backward-delete-char
zle -A backward-kill-word vi-backward-kill-word

[ -f /opt/anaconda/etc/profile.d/conda.sh ] && source /opt/anaconda/etc/profile.d/conda.sh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
