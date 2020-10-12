Obsolete scripts
================

Overview
--------

    base64url [-h] [-ed]

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

Few systems are supported:

  - Linux
  - Darwin (macOS)
  - FreeBSD
  - NetBSD
