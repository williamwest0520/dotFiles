# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
git_repo()
{
    if git rev-parse --is-inside-work-tree 1> /dev/null 2>&1
    then
        modified=$(git status --short | grep M -c)
        untracked=$(git status --short | grep ?? -c)
        spacer=""
        modifiedTracker=""
        untrackedTracker=""
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
        echo " ($(git branch --show-current)$spacer$modifiedTracker$untrackedTracker) "
    fi
}

PS1="\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$(git_repo)\$ "
PS2="\033[01;31m>\033[00m"
# xinput --set-prop --type=int --format=8 "Primax Kensington Eagle Trackball" "Evdev Middle Button Emulation" "1"
export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
ibus-daemon -d
