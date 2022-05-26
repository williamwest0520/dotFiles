# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
git_status()
{
    if git rev-parse --is-inside-work-tree 1> /dev/null 2>&1
    then
        modified=$(git status --short | grep 'M\b' -c)
        untracked=$(git status --short | grep "??" -c)
        deleted=$(git status --short | grep 'D\b' -c)
        renamed=$(git status --short | grep 'R\b' -c)
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
# xinput --set-prop --type=int --format=8 "Primax Kensington Eagle Trackball" "Evdev Middle Button Emulation" "1"
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
export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
ibus-daemon -d