# vim: ft=zsh:
function mv_to_local() {
  local f=$1
  mv $f ~/local
  ln -s ~/local/$f
}

showcolors() {
  for i in {0..255} ; do
    printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"
    if (( i == 15 )) || (( i > 15 )) && (( (i-15) % 6 == 0 )); then
      printf "\n";
    fi
  done
}

# History Search
hs() {
  fc -ilm $1 0
}

