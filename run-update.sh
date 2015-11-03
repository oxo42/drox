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

if [[ -d ~/.vim  && ! -L ~/.vim ]] ; then 
    echo Backing up .vim
    mv ~/.vim ~/.vim.bak  
fi
if ! [[ -d ~/.vim && -L ~/.vim ]] ; then
    echo Symlinking .vim
    ln -s ~/.drox/vim ~/.vim
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

echo "Checking tmux config"
# Symlink .tmux.conf
if [[ -f ~/.tmux.conf && ! -L ~/.tmux.conf ]] ; then
    mv ~/.tmux.conf ~/.tmux.conf.bak
fi
if ! [[ -L ~/.tmux.conf ]] ; then
    echo Symlinking .tmux.conf
    ln -s ~/.drox/tmux.conf ~/.tmux.conf
fi
