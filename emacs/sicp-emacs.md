# SICP and Emacs

In order to work through
[SICP](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book.html)
comfortably, the emacs plugin [geiser](https://www.nongnu.org/geiser/) helps a
lot. Here's how to set it up and how to use it.

## Prerequisites

Install `emacs`:

    # pacman -S emacs-nox

Install `mit-scheme` from [Arch AUR](https://aur.archlinux.org/packages/mit-scheme):

    $ git clone https://aur.archlinux.org/mit-scheme.git
    $ cd mit-scheme
    $ makepkg -si

You might need to add a missing GPG key using `gpg --recv-keys [fingerprint]`:

    $ gpg --recv-key C9E40BAAFD0CB132

Then `mit-scheme` should be installed under `/usr/bin/scheme`:

    $ which scheme
    /usr/bin/scheme
    $ scheme --version
    MIT/GNU Scheme 11.2
    [...]

## Install Geiser

In order to install `geiser`, add the following package archive to your `~/.emacs` file:

    (require 'package)
    (add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
    (package-initialize)

Save the file (`C-c C-s`) and evaluate it (`M-x eval-buffer`).

Run `M-x package-install RET geiser RET` to install `geiser`.

And, run `M-x package-install RET geiser-mit RET` to install `geiser-mit`.

## Configure geiser

Extend your `/.emacs` configuration by defining the binary file for
`mit-scheme` (use `which mit-scheme` to find the path), and by setting `mit` as
the only active Scheme implementation to be used for geiser:

    (setq geiser-mit-binary "/usr/bin/mit-scheme")
    (setq geiser-active-implementations '(mit))

Save (`C-c C-s`) and close (`C-c C-x`) emacs.

## Use geiser

Open a new emacs buffer:

    $ emacs foo.scm

Type in the following definition:

    (define (once x) (* x 1))

Now run geiser (with MIT Scheme) by typing `M-x run-mit`. The REPL is
activated. Change back to your buffer using `C-c C-z`. Now run `C-c C-b` to
evaluate the buffer. After switching back to the REPL (`C-c C-z`), the
definition `once` should be available:

    => (once 3)
    ;Value: 3

See the [geiser cheat
sheet](https://www.nongnu.org/geiser/Cheat-sheet.html#Cheat-sheet) for further
usage information.
