#!/bin/bash

if ! [ -d ~/.drox ] ; then
    # Clone from HTTP so we don't need auth
    git clone https://github.com/oxo42/drox.git ~/.drox
    
    cd ~/.drox

    # Set push to SSH so I can push with my ssh-key that's carried in from login
    git remote set-url --push origin git@github.com:oxo42/drox.git
else
    cd ~/.drox
    git pull --force
fi
~/.drox/update.sh
