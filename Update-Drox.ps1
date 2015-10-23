#!/bin/bash

Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)


echo "Starting drox update at $(date)"
git pull --force
echo "Check git submodule"
git submodule update --recursive --init

echo "Finished at $(date)"


Pop-Location
