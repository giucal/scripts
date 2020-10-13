#!/bin/sh

# buffer -- retains the output of a command until it completes successfully

getopts 'h' _ && {
    echo >&2 "Usage: $(basename "$0") [-h] [--] <command> [<argument> ...]"
    exit 2
}

[ "$1" = '--' ] && shift

buffer=$(mktemp buffer.XXXXXXXXXXXXXXXXXXXX)

# Long-running commands would keep $buffer around, so we unlink it now.
# (The OS will keep the file alive until the program terminates.)
exec 3>"$buffer" # Write descriptor.
exec 4<"$buffer" # Read descriptor.
unlink "$buffer"

# Execute the given command and redirect its output to $buffer.
# If the command fails, discard the output; if it succeeds, copy
# the output to stdout.
"$@" >&3 && <&4
