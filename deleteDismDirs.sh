#! /usr/bin/env bash

find . -maxdepth 2 -name "DismHost.exe" | sed 's/\/DismHost\.exe//' | xargs -n 5 rm -rf
