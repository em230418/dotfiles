#!/usr/bin/env bash
shopt -s expand_aliases
source ~/.bash_aliases
while read line; do
    yd $line
done < "${1:-/dev/stdin}"
