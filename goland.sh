#! /usr/bin/env bash

~/.local/share/JetBrains/Toolbox/scripts/goland "$1" > /dev/null 2>&1 &
disown
