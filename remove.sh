#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <path-to-submodule>"
    exit
fi

git rm "$1" && rm -rf .git/modules/"$1" && git config --remove-section submodule."$1"
