# Commands

## File Handling

- `cat`: concatenate files and print on the standard output
- `cd`: change the working directory
    - `cd`: change to home directory
    - `cd ..`: change to parent directory
    - `cd /home/joe`: change to directory using a absolute path
    - `cd docs/letters`: change to directory using a relative path
- `chmod`
- `chown`
- `cp`: copy a file
- `ls`: list files in a directory
    - `ls -l` or `ll`: long version
- `mv`: rename (move) a file
- `pwd`: print the current working directory
- `rm`: remove (delete) a file
    - `rm -r [directory]`: delete a directory recursively

## Process Handling

- `kill`
- `killall`
- `ps`
- `top`

## String Handling

- `awk`
- `grep`
- `sed`
- `tr`

## Miscellaneous

- `apropos`: show manpages to a topic
- `ascii`: print asci table
- `basename`:
- `bc`: calculator (interactive command)
- `cut`
- `fmt`:
- `fold`:
- `join`:
- `lpr`: print a document
- `man`: read a manpage
- `pwgen`: generate passwords
- `sh`: run a shell
- `wc`: count characters, words and lines

# Programming

## Output Redirection

    wc -l * | sort -n -r
    wc -l >std-out 2>std.err

# Variables

- `$IFS`: internal field seperator
