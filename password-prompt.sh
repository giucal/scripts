#!/bin/sh

# This script prompts for a password using built-in shell capabilities.

usage() {
    echo >&2 "password-prompt: [-h] [-0] [-p <prompt>]"
    [ "$1" = '-h' ] && echo >&2 "
Options:
    -0  Terminate the password with a null character.
    -P <prompt>
        Prompt message. Default is 'Password: '."
    exit 2
}

prompt='Password: '
null_terminated=

while getopts "h0i:P:p:" opt; do
    case $opt in
        (P) prompt=$OPTARG      ;;
        (0) null_terminated=t   ;;
        (h) usage -h            ;;
        (*) usage               ;;
    esac
done

printf '%s' "$prompt" > /dev/tty

stty -echo
IFS= read -r pw
stty echo

printf '%s' "$pw"
[ -n "$null_terminated" ] && printf "\0"
