#! /usr/bin/env bash

emacsExe=`find /c/Program\ Files/Emacs/ -name "emacs.exe"`
echo "emacsExe = $emacsExe"
echo "crap"
if [ -z "$emacsExe" ]; then
    echo "No winders emacs found"
else
    echo "winders emacs found"
    emacsDir="$(dirname "$emacsExe")"
    echo "more crap"
    echo "emacsDir = $emacsDir"
    echo "even more crap"
    #export PATH=$PATH:$emacsDir
fi
#echo "PATH=$PATH"
