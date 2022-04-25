#!/bin/sh

# by-size -- du|sort the given files (or the current directory)

usage() {
	echo >&2 "Usage: $(basename "$0") [-h] [--] [<file> ...]"
	exit 2
}

getopts 'h' _ && usage
[ "$1" = '--' ] && shift

du -hd1 -- "$@" 2>/dev/null | sort -hr
