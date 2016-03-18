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
