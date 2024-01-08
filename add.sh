#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <git-repo-clone-url>"
    exit
fi

BASENAME=$(echo -n "$1" | sed 's%^.*/\([^/]*\)\.git$%\1%g')
PTH="$HOME/.vim/pack/plugins/start/$BASENAME"

git submodule add --depth 1 "$1" "$PTH" && git config -f .gitmodules submodule."$PTH".shallow true
vim -u NONE -c "helptags $PTH/doc" -c q

