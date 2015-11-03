# Supplemental bashrc scripts

export EDITOR=vim

if [ -f ~/.drox/bash-git-prompt/gitprompt.sh ] ; then
    GIT_PROMPT_START="_LAST_COMMAND_INDICATOR_ \[\033[0;33m\]$(hostname -s):\w\[\033[0;0m\]"
    GIT_PROMPT_THEME=Solarized
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

eval $(dircolors ~/.drox/dircolors.solarized.ansi-dark)

alias ls='ls --color=auto -F'

if [ -f ~/.bashrc.local ] ; then 
    source ~/.bashrc.local
fi
