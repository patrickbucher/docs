# Notes

## Commands and Options

### `cd`

change to previous working directory:

    $ cd -

change to the home directory of user `joe`:

    $ cd ~joe

### `cp`

preserve ownership information:

    $ cp -a
    $ cp --archive

only copy if newer or not exists:

    $ cp -u
    $ cp --update

### `ls`

list all files except `.` and `..`:

    $ ls -A
    $ ls --almost-all

list details of a directory, not its contents:

    $ ls -d
    $ ls --directory

list files with indicator character:

    $ ls -F
    $ ls --classify

list files sorted by file size (biggest first):

    $ ls -S

list files sorted by modification time (newest first):

    $ ls -t

show inodes:

    $ ls -i
    $ ls --inode

### `reset`

reset a shell scrambled by special characters:

    $ reset

## Wildcards

any listed in square brackets:

    [abcdef]

any not listed in square brackets:

    [!abcdef]

any character of a class:

    [[:class:]]

common classes:

- `alnum`
- `alpha`
- `digit`
- `lower`
- `upper`

## Help

- `help`: bash's help mechanism for builtins
    - `help cd`
- `--help`: individual program's builtin help message
    - `mkdir --help`
- `man`: manual pages for commands, programming interfaces, conventions, etc.
    - `man 1 passwd`
    - `man 5 passwd`
    - `man 3 sprintf`
    - `man -k [keyword]`: like `apropos [keyword]`
    - `man -l [file]`: display man page file
    - `man -t`: format using `troff`/`groff`
- `apropos`: show man pages by keywords
    - `apropos -s X passwd`: only show matching man pages from section X
- `whatis`: show one-line command description
    - `whatis gcc`
- `info`: GNU's alternative to manpage (hierarchical, with hyperlinks)
    - `info emacs`
    - commands:
        - PG-UP/Backspace: previous page
        - PG-DOWN/Space: next page
        - n: next entry
        - p: previous entry
        - U: parent entry
        - Return/Enter: follow hyperlink under cursor
        - q: quit
- `REAMDE` files in `/usr/share/doc`

## Misc

### Aliases

set an alias:

    $ alias ll='ls -l'

unset an alias:

    $ unalias ll

list all available aliases:

    $ alias

### Redirection

truncate a file (`out.txt`):

    $ >out.txt

redirect both `stdout` and `stderr` to `out.txt` (classic style):

    $ ls >out.txt 2>&1

redirect both `stdout` and `stderr` to `out.txt` (bash style):

    $ ls &>out.txt
