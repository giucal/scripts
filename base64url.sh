#!/bin/sh

# base64url -- URL-safe base64 encoding

# To run a command quietly:
q() {
    "$@"
} >/dev/null

# Find a suitable base64 command.
if q command -v base64
then
    # On Linux and macOS, pick 'base64'. They're two different
    # commands, but both support the '--decode' flag.
    ENCODER=base64
    DECODER='base64 --decode'
elif q command -v b64encode
then
    # On BSDs pick 'b64{encode,decode}'.
    ENCODER=b64encode
    DECODER=b64decode
else
    exit 127
fi

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
