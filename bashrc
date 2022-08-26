# .bashrc

if grep --silent 'xr TMOUT' /etc/profile.d/tmout.sh; then
    # Avoid sourcing /etc/bashrc to avoid sourcing tmout.sh, which sets TMOUT to
    # 900, read-only
    SHELL=/bin/bash
    # Only display echos from profile.d scripts if we are no login shell
    # and interactive - otherwise just process them to set envvars
    for i in /etc/profile.d/*.sh; do
        if [ "$i" != "/etc/profile.d/tmout.sh" ]; then
            if [ -r "$i" ]; then
                if [ "$PS1" ]; then
                    . "$i"
                else
                    . "$i" >/dev/null
                fi
            fi
        fi
    done
    export TMOUT=0
else
    # No read-only TMOUT present, so source away
    if [ -f /etc/bashrc ]; then
           . /etc/bashrc
    fi
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
git_status()
{
    if git rev-parse --is-inside-work-tree 1> /dev/null 2>&1
    then
        git_status=$(git status --short)
        modified=$(echo $git_status | grep 'M\b' -c)
        untracked=$(echo $git_status | grep "??" -c)
        deleted=$(echo $git_status | grep 'D\b' -c)
        renamed=$(echo $git_status | grep 'R\b' -c)
        spacer=""
        modifiedTracker=""
        untrackedTracker=""
        deletedTracker=""
        renamedTracker=""
        if test $modified -gt 0
        then
            modifiedTracker="M"
            spacer=" "
        fi
        if test $untracked -gt 0
        then
            untrackedTracker="U"
            spacer=" "
        fi
        if test $deleted -gt 0
        then
            deletedTracker="D"
            spacer=" "
        fi
        if test $renamed -gt 0
        then
            renamedTracker="R"
            spacer=" "
        fi
        echo "($(git branch --show-current)$spacer$modifiedTracker$deletedTracker$renamedTracker$untrackedTracker)"
    fi
}

currently_local()
{
    if test $(echo $SSH_CONNECTION | wc -m) -gt 1
    then
        return 1
    else
        return 0
    fi
}

if $(currently_local)
then
    PS1="\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$(git_status)\$ "
else
    PS1="\[\033[01;32m\]\u\[\033[01;35m\]@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$(git_status)$ "
fi
PS2="\033[01;31m>\033[00m"

#### Mouse buttons
# 1 - left click
# 2 - middle click
# 3 - right click

### if Kensington Orbit is connected
if xinput --list | grep --quiet "Primax Kensington Eagle Trackball"
then
    xinput --set-prop --type=int --format=8 "Primax Kensington Eagle Trackball" "Evdev Middle Button Emulation" "1"
fi

### if Kensington Master is connected
if xinput --list | grep --quiet "Kensington      Kensington Expert Mouse"
then
    ### Sideways
    xinput --set-button-map "Kensington      Kensington Expert Mouse" 3 1 2 4 5 6 7 8 9 10 11 12
    ### upside down
    # xinput --set-button-map # 2 3 8 4 5 6 7 1 9 10 11 12

    ### property 290 inverts the mouse input
    ### property 292 swaps the left/right and up/down axes
    ### for upside down
    # xinput --set-prop # 290 1, 1
    ### for sideways
    xinput --set-prop "Kensington      Kensington Expert Mouse" 290 0, 1
    xinput --set-prop "Kensington      Kensington Expert Mouse" 292 1
fi

export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
ibus-daemon -d
export EDITOR=vim

export PATH=$PATH:$HOME/.cargo/bin

alias burn="rm -rf"
alias gs="git status"
alias gl="git log"
alias gll="git ll"
alias gd="git diff"
alias yums="yum list | fzf --preview='echo {} | cut -d \" \" -f1 | xargs yum info' --preview-window=hidden --bind '?:toggle-preview' -m | cut -d \" \" -f1 | xargs sudo yum install -y"
if type bat >/dev/null 2>&1
then
    alias cat=bat
fi
if type lsd >/dev/null 2>&1
then
    alias ls=lsd
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
