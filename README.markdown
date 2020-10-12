Scripts
=======

Scripts I needed more than once on different machines.
Hopefully portable.

Overview
--------

    to-hex [-h] [--] [<string>]

As far as I can tell, none of the POSIX commands can turn a stream of
bytes into an hexadecimal string without intermixed spaces, counters
and other litter.
The simplest solution I could come up with is combining `od` and `tr`:

    od -An -vtxC | tr -d ' \n'

------------------------------------------------------------------------

    base64-url [-h] [-ed]

URL-safe base64 encoder/decoder. Supports wrapped base64 input,
but always produces a single base64 line.

URL-safe base64 is gratis if you have a base64 encoder.
The problem is that POSIX doesn't specify a base64 input converter.
This scripts selects one of the installed base64 commands and applies
the mapping:

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

    password-prompt

Asks for a password. It prompts on `/dev/tty`, reads the password from stdin,
and writes it back to stdout.

Example:

    # In a script, read a password from the terminal.
    password=$(password-prompt < /dev/tty)

Installation
------------

The default installation prefix is `~/.local/bin`.

To install all of them:

    % make install                        # to ~/.local/bin
    % PREFIX=${YOUR_PREFIX} make install  # to ${YOUR_PREFIX}

To install some of them:

    % install ${SCRIPT_NAME}.sh ${YOUR_PREFIX}/${SCRIPT_NAME}
