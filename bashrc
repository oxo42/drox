# Supplemental bashrc scripts

export EDITOR=vim

if hash thefuck 2> /dev/null ; then
    eval "$(thefuck --alias)"
else
    alias fuck="install_thefuck"
fi

install_thefuck() {
    echo -n "Do you want to install thefuck? [N/y] "
    read -N 1 REPLY
    echo
    if test "$REPLY" = "y" -o "$REPLY" = "Y"; then
        wget -O - https://raw.githubusercontent.com/nvbn/thefuck/master/install.sh | sh - && $0
        unalias fuck
        eval "$(thefuck --alias)"
    else
        echo "Cancelled by user"
    fi
}

if hash dircolors 2> /dev/null ; then
    eval $(dircolors)
fi

alias ls='ls --color=auto -F'
alias d='ls -l | grep -E "^d"'
alias ..='cd ..'

if [ -f ~/.bashrc.local ] ; then
    source ~/.bashrc.local
fi

source ~/.drox/fbprompt.sh

shopt -s histappend
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'

export PROMPT_COMMAND="history -a"
