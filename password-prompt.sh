#!/bin/sh

# This script prompts for a password using built-in shell capabilities.

usage() {
    echo >&2 "password-prompt: [-h] [-0c] [-p <prompt>]"
    [ "$1" = '-h' ] && echo >&2 "
Options:
    -0  Terminate the password with a null character.
    -c  Check password. (Ask twice.)
    -P <prompt>
        Prompt message. Default is 'Password: '."
    exit 2
}

message='Password: '
null_terminated=
check=

while getopts "hc0i:P:p:" opt; do
    case $opt in
        (c) check=t             ;;
        (P) message=$OPTARG     ;;
        (0) null_terminated=t   ;;
        (h) usage -h            ;;
        (*) usage               ;;
    esac
done

prompt() {
    printf '%s' "$1" > /dev/tty
    stty -echo
    IFS= read -r "$2"
    echo > /dev/tty
    stty echo
}

while true; do
    prompt "$message" password
    [ -z "$check" ] && break

    # Check password.
    prompt 'Retype: ' password_check
    # shellcheck disable=SC2154
    [ "$password" = "$password_check" ] && break ||
        echo >&2 "$(basename "$0"): Passwords differ. Retry..."
done

printf '%s' "$password"
[ -n "$null_terminated" ] && printf "\0"
