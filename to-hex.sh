#!/bin/sh

# to-hex -- convert to hexadecimal

encode() {
    od -An -vtxC | tr -d ' \n'
}

usage() {
    echo >&2 "Usage: $(basename "$0") [-h] [--] [<string>]"
    exit 2
}

getopts 'h' _ && usage
[ "$1" = "--" ] && shift
[ $# -gt 1 ] && usage

if [ -n "$1" ]
then
    printf '%s' "$1" | encode
else
    encode
fi
