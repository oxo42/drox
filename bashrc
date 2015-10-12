# Supplemental bashrc scripts

export EDITOR=VIM

if [ -f ~/.drox/bash-git-prompt/gitprompt.sh ] ; then
    GIT_PROMPT_START="_LAST_COMMAND_INDICATOR_ \[\033[0;33m\]$(hostname -s):\w\[\033[0;0m\]"
    source ~/.drox/bash-git-prompt/gitprompt.sh
fi
