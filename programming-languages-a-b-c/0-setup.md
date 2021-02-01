# Setup

Install emacs and SML/NJ:

    # pacman -S emacs-nox smlnj

Add `/usr/lib/smlnj/bin/sml` to your `$PATH` (`~/.bashrc`):

    export PATH="$PATH:/usr/lib/smlnj/bin/sml"

Install [SML Mode for emacs](http://www.iro.umontreal.ca/~monnier/elisp/):

- open emacs
- press `M-x` and type `list-packages`, `[Return]`
- press `C-s` and search for `sml-mode`
    - if it is listed, it is already installed
    - otherwise, continue with next step
- press `M-x` and type `package-install`, `[Return]`
- type `sml-mode`, `[Return]`
- close emacs (`C-x C-c`) and re-open it
- create a new SML file (`C-x C-f test.xml`)
    - the mode indicator should display `SML`
    - type `val n = 1;` in the buffer, and check if the code is highlighted 
- press `C-c C-s`, `[Return]` to open the SML REPL in a separate window
- switch to the REPL and try some commands (e.g. `1+1;`)
- end the REPL with `C-d`, then open it again
- if stuck, interrupt by pressing `C-c C-c`
- scroll through input lines using `M-p` (previous) and `M-n` (next), respectively
- in the REPL, load your file using `use "test.sml";`

Effectively using the REPL:

- always start with `use "repl.sml"`
- use the REPL as needed
- do not invoke `use` to load any more files
- write things you want to re-use into the buffer `test.sml`, which can be loaded with `use`
- this allows you to save your REPL session (`repl.sml`) separately from your accumulated program (`test.sml`)
