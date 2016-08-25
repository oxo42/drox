function mv_to_local() {
    local f=$1
    mv $f ~/local
    ln -s ~/local/$f
}
