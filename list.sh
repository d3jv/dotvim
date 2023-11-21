#!/bin/sh

cat .gitmodules | grep "url = " | sed -e 's|.*\.com/\(.*\)\.git|\t\1|' | sort
