Scripts
=======

Scripts I needed more than one time on different machines.
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
and maintenance scripts outside 'PATH'.

Installation
------------

The default installation prefix is `~/.local/bin`.

To install all of them:

    % make install                        # to ~/.local/bin
    % PREFIX=${YOUR_PREFIX} make install  # to ${YOUR_PREFIX}

To install some of them, DIY:

    % install ${SCRIPT_NAME}.sh ${YOUR_PREFIX}/${SCRIPT_NAME}
