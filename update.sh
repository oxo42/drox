#!/bin/bash

log() {
    echo $1
}

basedir=$(dirname $0)

pushd $basedir > /dev/null

log Updating
git pull 

log "check vim"
log "check git"
log "check bash"


popd > /dev/null
