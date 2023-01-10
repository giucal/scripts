#!/bin/sh

# alt -- run a command found on an alternative PATH

PROG=$(basename "$0")

usage() {
    echo >&2 "Usage: $PROG [-h] [--] <command> [<argument> ...]"
    [ "$1" = -h ] && cat <<'HELP'
Run a command found on an alternative PATH.

Environment variables:
    ALT_PATH    The alternative PATH where to search for <command>.

This utility looks up <command> as if $ALT_PATH were the search path.
HELP
    exit 2
}

getopts h o && usage "-$o"
[ "$1" = -- ] && shift
[ $# -gt 0 ] || usage

error() {
    printf >&2 '%s: %s\n' "$PROG" "$*"
    exit 1
}

name=$(
    # Set/unset PATH to match ALT_PATH.
    [ -z "${ALT_PATH+set}" ] && unset PATH || PATH=$ALT_PATH
    command -v "$1"
) || error "command not found: $1"

shift

# If $name is a regular command, don't spawn another process.
case $name in
    (/*) exec "$name" "$@"
esac

# $name should be a special built-in (or function, if supported).
"$name" "$@"
