# This code was auto generated by with these options:
# http://andrewray.me/bash-prompt-builder/#git=1&color-git=3&git-prefix=1&color-git-prefix=3&git-ahead=1&color-git-ahead=6b&git-modified=1&color-git-modified=3&git-conflicted=1&color-git-conflicted=1&color-git-revno=3&git-bisect=1&color-git-bisect=5&option-submodule=1&color-option-submodule=5&git-ontag=1&color-git-ontag=3&hg=1&color-hg=5&hg-prefix=1&color-hg-prefix=5&hg-modified=1&color-hg-modified=5&hg-conflicted=1&color-hg-conflicted=1&hg-revno=1&color-hg-revno=5&hg-bisect=1&color-hg-bisect=3&hg-patches=1&color-hg-patches=3&svn=1&color-svn=6&color-svn-modified=6&color-svn-revno=6&option-modified=%E2%96%B3&option-conflict=%E2%98%A2&color-option-conflict=3&max-conflicted-files=2&option-nobranch=no%20branch!&color-option-nobranch=1&bisecting-text=bisecting&submodule-text=%5Bsubmodule%5D%20

MAX_CONFLICTED_FILES=2
DELTA_CHAR="△"
CONFLICT_CHAR="☢"
BISECTING_TEXT="bisecting"
NOBRANCH_TEXT="no branch!"
REBASE_TEXT="✂ ʀebase"
SUBMODULE_TEXT="[submodule] "

# Colors for prompt
COLOR_RED=$(tput sgr0 && tput setaf 1)
COLOR_GREEN=$(tput sgr0 && tput setaf 2)
COLOR_YELLOW=$(tput sgr0 && tput setaf 3)
COLOR_BLUE=$(tput sgr0 && tput setaf 4)
COLOR_MAGENTA=$(tput sgr0 && tput setaf 5)
COLOR_CYAN=$(tput sgr0 && tput setaf 6)
COLOR_GRAY=$(tput sgr0 && tput setaf 7)
COLOR_WHITE=$(tput sgr0 && tput setaf 7 && tput bold)
COLOR_LIGHTRED=$(tput sgr0 && tput setaf 1 && tput bold)
COLOR_LIGHTGREEN=$(tput sgr0 && tput setaf 2 && tput bold)
COLOR_LIGHTYELLOW=$(tput sgr0 && tput setaf 3 && tput bold)
COLOR_LIGHTBLUE=$(tput sgr0 && tput setaf 4 && tput bold)
COLOR_LIGHTMAGENTA=$(tput sgr0 && tput setaf 5 && tput bold)
COLOR_LIGHTCYAN=$(tput sgr0 && tput setaf 6 && tput bold)

COLOR_RESET=$(tput sgr0)

#if [ -z "`echo $(hg prompt \"abort\" 2>&1) | grep abort`" ]; then
    #echo "hg-prompt not installed. Suggest http://sjl.bitbucket.org/hg-prompt/installation/"
#fi

_hg_dir=""
function _hg_check {
    [ -d ".hg" ] && _hg_dir=`pwd`
    base_dir="."
    while [ -d "$base_dir/../.hg" ]; do base_dir="$base_dir/.."; done
    if [ -d "$base_dir/.hg" ]; then
        _hg_dir=`cd "$base_dir"; pwd`
        return 0
    else
        return 1
    fi
}

_svn_dir=""
function _svn_check {
    parent=""
    grandparent="."

    while [ -d "$grandparent/.svn" ]; do
        parent=$grandparent
        grandparent="$parent/.."
    done

    if [ ! -z "$parent" ]; then
        _svn_dir=`cd "$parent"; pwd`
        return 0
    else
        return 1
    fi
}

_git_dir=""
_git_svn_dir=""
function _git_check {
    _git_dir=`git rev-parse --show-toplevel 2> /dev/null`
    if [[ "$_git_dir" == "" ]]; then
        return 1
    else
        _gsvn_check=`cd "$_git_dir"; ls .git/svn/.metadata 2> /dev/null`

        if [[ ! -z "$_gsvn_check" ]]; then
            _git_svn_dir=$_git_dir
        fi
        return 0
    fi
}

function is_submodule() {
    local parent_git=`cd "$_git_dir/.." && git rev-parse --show-toplevel 2> /dev/null`
    if [[ -n $parent_git ]]; then
        local submodules=`cd "$parent_git" && git submodule --quiet foreach 'echo $path'`
        for line in $submodules; do
            cd "$parent_git/$line"
            if [[ `pwd` = $_git_dir ]]; then return 0; fi
        done
    fi
    return 1
}

dvcs_function="
    # Figure out what repo we are in
    _git_check \
        || _hg_check \
        || _svn_check

    # Build the prompt!
    prompt=\"\"

    # If we are in git ...
    if [ -n \"\$_git_dir\" ]; then
        # find current branch
        gitBranch=\$(git symbolic-ref HEAD 2> /dev/null)
        gitStatus=\`git status\`

        # Figure out if we are rebasing
        if [[ -d \"\$_git_dir/.git/rebase-apply\" || -d \"\$_git_dir/.git/rebase-merge\" ]]; then
            is_rebase=1
        fi

        # Figure out current branch, or if we are bisecting, or lost in space
        bisecting=\"\"
        if [ -z \"\$gitBranch\" ]; then
        if [ -n \"\$is_rebase\" ]; then
            rebase_prompt=\" \\[\$COLOR_LIGHT_CYAN\\]\"
            rebase_prompt=\$rebase_prompt\"\\[`tput sc`\\]  \\[`tput rc`\\]\\[\$REBASE_TEXT\\] \"
            rebase_prompt=\$rebase_prompt\"\\[\$COLOR_YELLOW\\]\"
        else
            bisect=\$(git rev-list --bisect 2> /dev/null | cut -c1-7)
            if [ -z \"\$bisect\" ]; then
            gitBranch=\"\\[\$COLOR_RED\\]\$NOBRANCH_TEXT\\[\$COLOR_LIGHTBLUE\\]\"
        else
            bisecting=\"\\[\$COLOR_MAGENTA\\]\$BISECTING_TEXT:\"\$bisect\"\\[\$COLOR_LIGHTBLUE\\]\"
            gitBranch=\"\"
        fi
        fi
        fi
        gitBranch=\${gitBranch#refs/heads/}
        #: git-svn
        if [ -z \"\$bisect\" ]; then
            if [ -n \"\$_git_svn_dir\" ]; then
                gitBranch=\"\\[\$COLOR_DARK_BLUE\\]git-svn\\[\$COLOR_YELLOW\\] \$gitBranch\"
            fi
        fi

            
        if [ -z \"\$is_rebase\" ]; then
            # changed *tracked* files in local directory?
            gitChange=\$(echo \$gitStatus | ack 'modified:|deleted:|new file:')
            if [ -n \"\$gitChange\" ]; then
                gitChange=\"\\[\$COLOR_LIGHTBLUE\\] \\[`tput sc`\\]  \\[`tput rc`\\]\\[\$DELTA_CHAR\\]\"
            fi
        fi

            # output the branch and changed character if present
            prompt=\$prompt\"\\[\$COLOR_LIGHTBLUE\\] (\"

            if is_submodule; then
                prompt=\$prompt\"\\[\$COLOR_MAGENTA\\]\$SUBMODULE_TEXT\\[\$COLOR_LIGHTBLUE\\]\"
            fi

            prefix=\"\\[\$COLOR_LIGHTBLUE\\]git:\\[\$COLOR_LIGHTBLUE\\]\"
            prompt=\$prompt\$prefix\$gitBranch\$bisecting
            tag=\`git describe --tags --exact 2> /dev/null\`
            if [ -n \"\$tag\" ]; then
                prompt=\"\$prompt\\[\$COLOR_YELLOW\\] \\\"\$tag\\\"\\[\$COLOR_LIGHTBLUE\\]\"
            fi
            prompt=\$prompt\"\$gitChange\\[\$COLOR_LIGHTBLUE\\])\\[\$COLOR_RESET\\]\"

            # How many local commits do you have ahead of origin?
            num=\$(echo \$gitStatus | grep \"Your branch is ahead of\" | awk '{split(\$0,a,\" \"); print a[13];}') || return
            if [ -n \"\$num\" ]; then
                prompt=\$prompt\"\\[\$COLOR_CYAN\\] +\$num\"
            fi

            # any conflicts? (sed madness is to remove line breaks)
            files=\$(git ls-files -u | cut -f 2 | sort -u | sed '$(($MAX_CONFLICTED_FILES+1)),1000d' | sed -e :a -e '\$!N;s/\\\n/, /;ta' -e 'P;D')
        fi

    # If we are in mercurial ...
    if [ -n \"\$_hg_dir\" ]; then
        hgBranch=\`cat \"\$_hg_dir/.hg/branch\"\`

        hgPrompt=\"s\"
        hgPrompt=\"\$hgPrompt{status|modified}\"

        hgPrompt=\"\$hgPrompt n\"
        hgPrompt=\"\$hgPrompt{node}\"

        hgPrompt=\"\$hgPrompt p\"
        hgPrompt=\"\$hgPrompt{patches|hide_unapplied|join(,)}\"

        promptOptions=(\`hg prompt \"\$hgPrompt\" | tr -s ':' ' '\`)

        hgm=\${promptOptions[0]:1}
        if [ -n \"\$hgm\" ]; then
            hgChange=\"\\[\$COLOR_PURPLE\\] \\[`tput sc`\\]  \\[`tput rc`\\]\\[\$DELTA_CHAR\\]\"
        fi

        # output branch and changed character if present
        prompt=\$prompt\"\\[\$COLOR_MAGENTA\\] (\"
        
        prefix=\"\\[\$COLOR_MAGENTA\\]hg:\\[\$COLOR_MAGENTA\\]\"
        prompt=\$prompt\"\${prefix}\${hgBranch}\"

        bisecting=\$(hg bisect 2> /dev/null | head -n 1)
        bisecting=\${bisecting:20:7}

        if [ -z \"\$bisecting\" ]; then
            prompt=\$prompt
            prompt=\$prompt\":\${promptOptions[1]:1:7}\"
        else
            prompt=\"\$prompt\\[\$COLOR_YELLOW\\]:\$BISECTING_TEXT:\"\$bisecting\"\\[\$COLOR_MAGENTA\\]\"
        fi
        prompt=\$prompt\"\$hgChange\"
        patches=\${promptOptions[2]:1}
        if [ -n \"\$patches\" ];then
            prompt=\$prompt\"\\[\$COLOR_YELLOW\\] [\$patches]\\[\$COLOR_MAGENTA\\]\"
        fi
        prompt=\$prompt\")\"

    # Conflicts?
        files=\$(hg resolve -l | grep \"U \" | sed '$(($MAX_CONFLICTED_FILES+1)),1000d' | awk '{split(\$0,a,\" \"); print a[2];}') || return
    fi

    # If we are in subversion ...
    if [ -n \"\$_svn_dir\" ]; then

        # changed files in local directory? NOTE: This command is the slowest of the bunch
        svnChange=\$(svn status | ack \"^M|^!\" | wc -l)
        if [[ \"\$svnChange\" != \"       0\" ]]; then
            svnChange=\"\\[\$COLOR_CYAN\\] \\[`tput sc`\\]  \\[`tput rc`\\]\\[\$DELTA_CHAR\\] \"
        else
            svnChange=\"\"
        fi

        # revision number (instead of branch name, silly svn)
        revNo=\`svnversion --no-newline\`
        prompt=\$prompt\"\\[\$COLOR_CYAN\\] (svn\"
        prompt=\$prompt\"\$svnChange)\\[\$COLOR_RESET\\]\"
    fi

    # Show conflicted files if any
    if [ -n \"\$files\" ]; then
        prompt=\$prompt\" \\[\$COLOR_RED\\](\\[\$COLOR_YELLOW\\]\"
        prompt=\$prompt\"\\[`tput sc`\\]  \\[`tput rc`\\]\\[\$COLOR_YELLOW\\]\\[\$CONFLICT_CHAR\\] \"
        prompt=\$prompt\"\\[\$COLOR_RED\\] \${files})\"
    fi

    echo -e \$prompt"
# End code auto generated by http://andrewray.me/bash-prompt-builder/index.html

PS1="\[\033[0;33m\]$(hostname -s):\w\[$COLOR_RESET\]\$(${dvcs_function})\[$COLOR_RESET\] \n\[\033[0;37m\]$(date +%H:%M)\[\033[0;0m\] \\$ "




# Bash Git Prompt
## function prompt_callback {
##     # Show jobs running if any
##     if [ `jobs | wc -l` -ne 0 ]; then
##         echo -n " jobs:\j"
##     fi
## }

## if [ -f ~/.drox/bash-git-prompt/gitprompt.sh ] ; then
##     GIT_PROMPT_START="_LAST_COMMAND_INDICATOR_ \[\033[0;33m\]$(hostname -s):\w\[\033[0;0m\]"
##     # GIT_PROMPT_THEME=Solarized
##     export PROMPT_COMMAND='setLastCommandState;printf "\033]0;%s:%s\007" "${HOSTNAME%%.*}" "${PWD##*/}";setGitPrompt'
##     source ~/.drox/bash-git-prompt/gitprompt.sh
## fi
