#!/bin/bash

basedir=$(dirname $0)

echo "Starting drox update at $(date)"
git pull
echo "Check git submodule"
git submodule update --recursive --init

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

if [[ -f ~/.gitconfig && ! -L ~/.gitconfig ]] ; then
    echo Backing up .gitconfig
    mv ~/.gitconfig ~/.gitconfig.bak
fi
if ! [ -L ~/.gitconfig ] ; then
    echo Symlinking .gitconfig
    ln -s ~/.drox/gitconfig ~/.gitconfig
fi

echo "Finished at $(date)"
