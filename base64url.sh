#!/bin/sh

# base64url -- URL-safe base64 encoding

# Pick the right encoder and decoder.
case $(uname) in
    (Darwin|Linux)
        # On both Linux and macOS, 'base64' supports the '--decode' flag.
        ENCODER='base64'
        DECODER='base64 --decode'
        ;;
    (FreeBSD)
        ENCODER='base64 -e'
        DECODER='base64 -d'
        ;;
    (NetBSD)
        ENCODER='base64'
        DECODER='base64 -d'
        ;;
    (*)
        echo >&2 "Unsupported/unknown system"
        exit 1
        ;;
esac

safe_encode() {
    $ENCODER | tr '/+' '_-' | tr -d '\n'
}

safe_decode() {
    tr '_-' '/+' | $DECODER
}

while getopts 'hed' opt
do
    [ "$opt" = e ] && break
    [ "$opt" = d ] && safe_decode && exit

    echo >&2 "Usage: $(basename "$0") [-h] [-ed]"
    [ "$opt" = h ] && echo >&2 "
URL-safe base64 encoding as described in RFC 4648.

Options:
    -e      encode (default)
    -d      decode
    -h      show this message"
    exit 2
done

safe_encode
