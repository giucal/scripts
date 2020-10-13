Scripts
=======

Scripts I needed more than once on different machines.
Hopefully portable.

Overview
--------

    to-hex [-h] [--] {<string> | 0<}

Converts either stdin or, if given, `<string>` to haxadecimal.

As far as I can tell, none of the POSIX commands can turn a stream of
bytes into an hexadecimal string without intermixed spaces, counters
and other litter.
The simplest solution I could come up with is combining `od` and `tr`:

    od -An -vtxC | tr -d ' \n'

------------------------------------------------------------------------

    base64-to-base64url [-h] [--] {<string> | 0<}
    base64url-to-base64 [-h] [--] {<string> | 0<}

Filters to convert between base64 and URL-safe base64.

`base64-to-base64url` takes (optionally wrapped) base64 as input and writes
URL-safe base64 to stdout. Vice versa, `base64url-to-base64` takes URL-safe
base64 as input and writes (unwrapped) base64 to stdout.

The input is either stdin or, if given, `<string>`.

POSIX doesn't specify a base64 input converter; so you need to
combine these filters with the appropriate command for your system.

The implementation is unoriginal. Indeed, URL-safe base64 is gratis
if you have a base64 encoder: just apply the following transformation:

  | base64 | URL-safe base64 |
  |--------|-----------------|
  | /      | _ (underscore)  |
  | +      | - (hyphen)      |

------------------------------------------------------------------------

    recipe [-h] <recipe> [<argument> ...]

Finds and executes 'recipes' from a certain directory. The directory
is set with the `RECIPES_DIR` environment variable. Anything in the
recipes directory which is executable and doesn't start with a dot
is taken as a recipe.

This script lets you maintain a set of workflows, common invocations
and maintenance scripts outside `PATH`.

------------------------------------------------------------------------

    buffer [-h] [--] command [<argument> ...]

Runs a command but retains its output until it succeeds. If the command
fails, discards the output.

Envisioned use:

    buffer scrypt dec ciphertext > plaintext
    buffer nc -l 1234 > received.txt

Note that the redirections pertain to `buffer`; so the output of
`scrypt` (respectively, `nc`) is written to `plaintext` (`received.txt`)
only if `scrypt` (`nc`) succeeds, and otherwise discarded.

------------------------------------------------------------------------

    password-prompt

Asks for a password. It prompts on `/dev/tty`, reads the password from stdin,
and writes it back to stdout.

Example:

    # In a script, read a password from the terminal.
    password=$(password-prompt < /dev/tty)

------------------------------------------------------------------------

    random-password

Generates an ASCII random password. It takes the following options
in any combination:

  | Flag | The password _may_ include |
  | ---- | -------------------------- |
  | `-d` | decimal digits (0-9)       |
  | `-u` | upper-case letters (A-Z)   |
  | `-l` | lower-case letters (a-z)   |
  | `-p` | ASCII punctuation          |

If none is given, `random-password` assumes `-dulp`.

Installation
------------

The default installation prefix is `~/.local/bin`.

To install all of them:

    % make install                        # to ~/.local/bin
    % PREFIX=${YOUR_PREFIX} make install  # to ${YOUR_PREFIX}

To install some of them:

    % install ${SCRIPT_NAME}.sh ${YOUR_PREFIX}/${SCRIPT_NAME}
