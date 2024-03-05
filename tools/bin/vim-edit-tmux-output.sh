#! /usr/bin/env bash

file=`mktemp`
tmux capture-pane -e -pS - > $file
tmux new-window -n:vim-scrollback "nvim '+ normal G' '+ set nu&' '+set rnu&' '+ set clipboard=unnamedplus' '+ colorscheme quiet' '+ BaleiaColorize' '+ w' $file"
