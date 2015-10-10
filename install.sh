#!/bin/bash

if ! [ -d ~/.drox ] ; then
    git clone --quiet https://github.com/oxo42/drox.git ~/.drox
else
    git pull -f
fi
cd ~/.drox
./update.sh

