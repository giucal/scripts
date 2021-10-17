#!/bin/sh

# Run a command with a timeout.

usage() {
	echo >&2 "Usage: $(basename "$0") [-h] <timeout> <command> [<argument> ...]"
	[ "$1" = "-h" ] && cat <<-END
		Runs a command with a timeout.

		The <timeout> argument follows the same format as sleep(1)'s argument.
	END
	exit 2
}

getopts 'h' opt && usage "$opt"
[ "$1" = '--' ] && shift
[ "$#" -lt 2 ] && usage

timeout=$1; shift

(
	sleep "$timeout"
	kill -9 -$$
) & timer=$!

"$@" & wait $!; status=$?
kill -9 $timer
exit $status
