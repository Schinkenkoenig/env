#!/usr/bin/env bash

if [[ -z $STOW_FOLDERS ]]; then
    STOW_FOLDERS="zsh,tmux"
fi

for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do 
    echo "stow $folder"
    stow -D $folder 
    stow $folder 
done 
