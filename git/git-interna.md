# Git Interna

Git is a _content-addressable_ filesystem with a VCS user interface on top of
it. It has "plumbing" (internal, low-level) and "porcelain" (user-facing,
high-level) commands.

The `.git` directory, created as a sub-directory within the current working
directory when running `git init`, contains the following files and folders:

    $ mkdir demo
    $ cd demo
    $ git init
    $ ls -F .git
    config  description  HEAD  hooks/  info/  objects/  refs/

- `config`: repository-specific Git configuration
- `description`: textual description for GitWeb
- `HEAD`: reference to the currently checked-out branch
- `hooks/`: client- and server-side hook scripts
- `info/`: global exclude patterns (similar go `.gitignore`)
- `objects/`: content of the Git repository
- `refs/`: pointer into commit objects (branches)

## Git as a Key-Value Store

Git is a _key-value store_. As content is written into the repository, a key to
later retrieve that content is generated and returned.

The `hash-object` command stores data inside the repository and returns the
generated key:

    $ echo 'hello' | git hash-object -w --stdin
    ce013625030ba8dba906f756967f9e9ca394464a

Using the `-w` flag, the contente is actually written into the repository.
Without it, only the hash would be printed.

With the `--stdin` flag, the content to be written is expected from standard
input. It's also possible to write the content of files into the repository:

    $ echo 'world' > hello.txt
    $ git hash-object -w hello.txt
    cc628ccd10742baea8241c5924df992b5c019f71

In this case, the content is stored under the following specific paths:

    .git/objects/ce/013625030ba8dba906f756967f9e9ca394464a
    .git/objects/cc/628ccd10742baea8241c5924df992b5c019f71

In general, the object written with the hash `abcdefgh…` is stored under
`.git/objects/ab/cdefgh…`: The SHA1 hash consisting of 40 characters is split
up into a two-character prefix and a 38 suffix.

Content can retrieved from the repository using the `cat-file` command:

    $ git cat-file -p ce013625030ba8dba906f756967f9e9ca394464a
    hello
    $ git cat-file -p cc628ccd10742baea8241c5924df992b5c019f71
    world

The `-p` flag makes sure the content is printed properly according to its file
type. The `-t` flag is used to determine the type of an object:

    $ git cat-file -t ce013625030ba8dba906f756967f9e9ca394464a
    blob

Note that the file name is _not_ stored with the object.

## Trees

TODO
