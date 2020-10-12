#!/bin/sh

# Base64 to URL-safe base64 conversion.

getopts 'h' _ && {
    echo >&2 "Usage: $(basename "$0") [-h]"
    exit 2
}

tr -d '\n' | tr '/+' '_-'
