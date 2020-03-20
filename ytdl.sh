#!/bin/sh

# Extract the audio from videos.

[ $# -ne 1 ] && echo >&2 "Usage: ytdl <URL>"

youtube-dl "${1}" \
	--no-overwrites \
	--extract-audio \
	--audio-format=m4a \
	--audio-quality=0
