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

[ -f ~/.bashrc.local ] && source ~/.bashrc.local

source ~/.drox/fbprompt.sh

### History

# Unlimited history
export HISTFILESIZE=

# Tell the history builtin command to display history with a timestamp
export HISTTIMEFORMAT='%F %T  '

# But only keep a certain number of lines in memory
export HISTSIZE=10000

# Don't clutter the file with trivial one and two character commands
export HISTIGNORE="?:??:history*:"


# Flush after each command -- guarantee that almost everything is kept
export PROMPT_COMMAND="history -a"

# Don't overwrite history
shopt -s histappend

# Don't clutter the file with consecutively repeated commands
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups

# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
