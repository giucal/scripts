#!/bin/sh

# URL-safe base64 to base64 conversion.

usage() {
    echo >&2 "Usage: $(basename "$0") [-h] [--] {<string> | 0<}"
    exit 2
}

filter() {
    tr '_-' '/+'
}

getopts 'h' _ && usage
[ "$1" = "--" ] && shift
[ $# -gt 1 ] && usage

if [ -n "$1" ]; then
    printf '%s' "$1" | filter
else
    filter
fi
