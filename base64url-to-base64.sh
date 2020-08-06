#!/bin/sh

# URL-safe base64 to base64 conversion.

getopts 'h' _ && {
    echo >&2 "Usage: $(basename "$0") [-h]"
    exit 2
}

tr '_-' '/+'
