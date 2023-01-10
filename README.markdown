Scripts
=======

Scripts I needed more than once on different machines.
Hopefully portable.

Installation
------------

    make install

The default installation prefix is `~/.local`. So, exdcutables go into
`~/.local/bin` and man pages into `~/.local/share/man/man1`. Change the
prefix by setting `PREFIX`, e.g.:

    PREFIX=/usr/local make install
