#!/bin/bash


# This is because I used to have vim included in this repo with submodules 
# but it now lives in it's own repo.  The git pull wouldn't clean out the 
# submodules
if [[ -d vim ]] ; then 
    echo "Cleaning up old vim config"
    rm -rf vim
fi

echo "Checking vim config"
# Make ~/.vimrc source ~/.vim/vimrc
if [[ -f ~/.vimrc && ! -L ~/.vimrc ]] ; then 
    echo Backing up .vimrc
    mv ~/.vimrc ~/.vimrc.bak 
fi
if [[ ! -L ~/.vimrc ]] ; then 
    echo Symlinking .vimrc
    ln -s ~/.drox/dot.vimrc ~/.vimrc
fi

# Make sure that ~/.vim is a git repo and fully up to date
if [[ -L ~/.vim ]] ; then 
	rm ~/.vim
fi
if [[ -d ~/.vim ]] ; then
    cd ~/.vim
    if [[ $(git status 2> /dev/null) ]] ; then 
        git pull
        git submodule update --recursive --init
    else
        mv ~/.vim ~/.vim.bak
    fi
fi
if [[ ! -d ~/.vim ]] ; then
    git clone https://github.com/oxo42/vimrc.git ~/.vim
    cd ~/.vim
    git remote set-url --push origin git@github.com:oxo42/vimrc.git
    git submodule update --recursive --init
fi

echo "Checking git config"
# Symlink .gitconfig
if [[ -f ~/.gitconfig && ! -L ~/.gitconfig ]] ; then
    echo Backing up .gitconfig
    mv ~/.gitconfig ~/.gitconfig.bak
fi
if ! [[ -L ~/.gitconfig ]] ; then
    echo Symlinking .gitconfig
    ln -s ~/.drox/gitconfig ~/.gitconfig
fi
