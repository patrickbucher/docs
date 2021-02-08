# The System Administrator's Guide to Bash Scripting

## Introduction

### History of Bash

- initial shell: `/bin/sh` on Unix V6 (Ken Thompson, 1971)
    - acts outside of the kernel
    - redirection, piping, sequential/asynchronous commands 
- Bourne Shell: Unix V7 (Steven Bourne, 1977)
    - control structure, signal handling, command substitution
- Bourne Again Shell (Bash): GNU (Brian Fox)
    - default shell for most Linux distributions
    - combines features from the Bourne, Korn, and C shell
    - functions, regular expressions, associative arrays
    - released under GPL

## Core Concepts

### Bash Files: `.bash_profile`

- local to every user account
- similar to `.bashrc`, with subtle differences
- designed for execution upon login (via tty, `ssh`, `su`)
- unlike `.bashrc`, which executes every time a shell (terminal emulator) is started
- usually loads `.bashrc`, if it exists
- often used for setting `$PATH` and aliases

### Bash Files: `.bashrc`

- user specific aliases, functions, variables
- runs every time before a command prompt comes up
    - e.g. running `bash` in the shell
- sources global definitions from `/etc/bashrc` (or the like)
- allows to change things that do not affect the original login shell

### Bash Files: `.bash_history`

- captures bash commands executed
- last 100 commands by default
- use `$HISTCONTROL` to configure behaviour
    - `ignoredups`: do not track duplicates (like `cd ..`, `cd ..`, etc.)
    - `ignorespace`: do not track commands starting with a space character
    - use multiple values seperated by colons, extend like `$PATH`
    - `export HISTCONTROL="$HISTCONTROL:ignorespace"

### Bash Files: `.bash_logout`

- not always needed/used (empty)
- executed when executing `exit` or `logout` command, not when simply closing
- possible use case: `root` executes maintenance tasks when leaving

### What Makes a File a Shell Script

- shebang line: `#!/bin/bash`
- file extension is not relevant, but often `.sh` is used

## Conditional Statements

## Input and Output

## Debugging and Error Handling

## Functions

## Samples/Use Cases
