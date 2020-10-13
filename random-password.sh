#!/bin/sh

# Simple but portable password-generation script.

usage() {
    echo >&2 "Usage: $(basename "$0") [-h] [-dulp] <length>"
    [ "$1" = '-h' ] && echo >&2 "
Options:
    -d | -u | -l | -p
        Allow decimal digits (d), upper-case (u) and lower-case (l) letters,
        punctuation characters (p), or a combination thereof to appear in
        the generated password."
    exit 2
}

# Elementary charsets.
{
    d=1  # decimal digits
    l=2  # lower-case letters
    u=4  # upper-case letters
    p=8  # punctuation
}

# Takes the bitwise OR of some elementary charsets and
# returns an appropriate argument for 'tr'.
charset() {
    case $1 in
        (0)  echo ''                            ;;
        (1)  echo '[:digit:]'                   ;;
        (2)  echo '[:lower:]'                   ;;
        (3)  echo '[:digit:][:lower:]'          ;;
        (4)  echo '[:upper:]'                   ;;
        (5)  echo '[:digit:][:upper:]'          ;;
        (6)  echo '[:upper:][:lower:]'          ;;
        (7)  echo '[:digit:][:upper:][:lower:]' ;;
        (8)  echo '[:punct:]'                   ;;
        (9)  echo '[:digit:][:punct:]'          ;;
        (10) echo '[:lower:][:punct:]'          ;;
        (11) echo '[:digit:][:lower:][:punct:]' ;;
        (12) echo '[:upper:][:punct:]'          ;;
        (13) echo '[:digit:][:upper:][:punct:]' ;;
        (14) echo '[:upper:][:lower:][:punct:]' ;;
        (15) echo '[:graph:]'                   ;;
    esac
}

# Parse options.
cs=0  # charset
while getopts 'dulp' opt; do
    [ "$opt" = 'h' ] && usage -h
    [ "$opt" = '?' ] && usage
    cs=$(( cs | opt ))
done
# Drop parsed arguments.
shift $(( OPTIND - 1 ))

# Require password length.
[ $# -ne 1 ] && usage
# Default charset.
[ $cs -eq 0 ] && cs=$(( d|u|l|p ))

# Generate password with rejection.
LC_CTYPE=C tr -dc "$(charset $cs)" < /dev/urandom | head -c "$1"
