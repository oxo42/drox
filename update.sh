#!/bin/bash

# This script updates the repository then starts the actual update 
# so the most recent logic is called, not the logic at the time of 
# running the script.

basedir=$(dirname $0)
cd $basedir

echo "Starting drox update at $(date)"
git pull
echo "Check git submodule"
git submodule update --recursive --init

./run-update.sh

echo "Finished at $(date)"
