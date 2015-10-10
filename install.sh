#!/bin/bash

if ! [ -d ~/.drox ] ; then
    git clone https://github.com/oxo42/drox.git ~/.drox
else
    git pull --force
fi
cd ~/.drox
./update.sh

