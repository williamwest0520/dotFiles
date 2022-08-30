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
LS_COLORS='rs=0:di=38;5;27:ln=38;5;51:mh=44;38;5;15:pi=40;38;5;11:so=38;5;13:do=38;5;5:bd=48;5;232;38;5;11:cd=48;5;232;38;5;3:or=48;5;232;38;5;9:mi=05;48;5;232;38;5;15:su=48;5;196;38;5;15:sg=48;5;11;38;5;16:ca=48;5;196;38;5;226:tw=48;5;10;38;5;16:ow=48;5;10;38;5;21:st=48;5;21;38;5;15:ex=38;5;34:*.tar=38;5;9:*.tgz=38;5;9:*.arc=38;5;9:*.arj=38;5;9:*.taz=38;5;9:*.lha=38;5;9:*.lz4=38;5;9:*.lzh=38;5;9:*.lzma=38;5;9:*.tlz=38;5;9:*.txz=38;5;9:*.tzo=38;5;9:*.t7z=38;5;9:*.zip=38;5;9:*.z=38;5;9:*.Z=38;5;9:*.dz=38;5;9:*.gz=38;5;9:*.lrz=38;5;9:*.lz=38;5;9:*.lzo=38;5;9:*.xz=38;5;9:*.bz2=38;5;9:*.bz=38;5;9:*.tbz=38;5;9:*.tbz2=38;5;9:*.tz=38;5;9:*.deb=38;5;9:*.rpm=38;5;9:*.jar=38;5;9:*.war=38;5;9:*.ear=38;5;9:*.sar=38;5;9:*.rar=38;5;9:*.alz=38;5;9:*.ace=38;5;9:*.zoo=38;5;9:*.cpio=38;5;9:*.7z=38;5;9:*.rz=38;5;9:*.cab=38;5;9:*.jpg=38;5;13:*.jpeg=38;5;13:*.gif=38;5;13:*.bmp=38;5;13:*.pbm=38;5;13:*.pgm=38;5;13:*.ppm=38;5;13:*.tga=38;5;13:*.xbm=38;5;13:*.xpm=38;5;13:*.tif=38;5;13:*.tiff=38;5;13:*.png=38;5;13:*.svg=38;5;13:*.svgz=38;5;13:*.mng=38;5;13:*.pcx=38;5;13:*.mov=38;5;13:*.mpg=38;5;13:*.mpeg=38;5;13:*.m2v=38;5;13:*.mkv=38;5;13:*.webm=38;5;13:*.ogm=38;5;13:*.mp4=38;5;13:*.m4v=38;5;13:*.mp4v=38;5;13:*.vob=38;5;13:*.qt=38;5;13:*.nuv=38;5;13:*.wmv=38;5;13:*.asf=38;5;13:*.rm=38;5;13:*.rmvb=38;5;13:*.flc=38;5;13:*.avi=38;5;13:*.fli=38;5;13:*.flv=38;5;13:*.gl=38;5;13:*.dl=38;5;13:*.xcf=38;5;13:*.xwd=38;5;13:*.yuv=38;5;13:*.cgm=38;5;13:*.emf=38;5;13:*.axv=38;5;13:*.anx=38;5;13:*.ogv=38;5;13:*.ogx=38;5;13:*.aac=38;5;45:*.au=38;5;45:*.flac=38;5;45:*.mid=38;5;45:*.midi=38;5;45:*.mka=38;5;45:*.mp3=38;5;45:*.mpc=38;5;45:*.ogg=38;5;45:*.ra=38;5;45:*.wav=38;5;45:*.axa=38;5;45:*.oga=38;5;45:*.spx=38;5;45:*.xspf=38;5;45:'
export LS_COLORS
