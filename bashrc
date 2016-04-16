# Supplemental bashrc scripts

export EDITOR=vim

if [ -f ~/.drox/bash-git-prompt/gitprompt.sh ] ; then
    GIT_PROMPT_START="_LAST_COMMAND_INDICATOR_ \[\033[0;33m\]$(hostname -s):\w\[\033[0;0m\]"
    # GIT_PROMPT_THEME=Solarized
    export PROMPT_COMMAND='setLastCommandState;printf "\033]0;%s:%s\007" "${HOSTNAME%%.*}" "${PWD##*/}";setGitPrompt'
    source ~/.drox/bash-git-prompt/gitprompt.sh
fi

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
alias vim='vim -p' # Open multiple files in tabs

if [ -f ~/.bashrc.local ] ; then 
    source ~/.bashrc.local
fi

function prompt_callback {
    # Show jobs running if any
    if [ `jobs | wc -l` -ne 0 ]; then
        echo -n " jobs:\j"
    fi
}

# Color man
export LESS_TERMCAP_mb=$(printf '\e[01;31m') # enter blinking mode - red
export LESS_TERMCAP_md=$(printf '\e[01;35m') # enter double-bright mode - bold, magenta
export LESS_TERMCAP_me=$(printf '\e[0m') # turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_se=$(printf '\e[0m') # leave standout mode    
export LESS_TERMCAP_so=$(printf '\e[01;33m') # enter standout mode - yellow
export LESS_TERMCAP_ue=$(printf '\e[0m') # leave underline mode
export LESS_TERMCAP_us=$(printf '\e[04;36m') # enter underline mode - cyan

