#!/bin/bash

if [ -d ~/.drox ] ; then
    git clone https://github.com/oxo42/drox.git ~/.drox
cd ~/.drox
./update.sh
