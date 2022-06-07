# Setup

Install Clojure and Leiningen (on Arch Linux):

    # pacman -S clojure leiningen

Create a sample project (called `demo`) and run it:

    $ lein new app demo
    $ cd demo
    $ lein run

Create an executable "uberjar" and execute it:

    $ lein uberjar
    $ java -jar target/uberjar/demo-0.1.0-SNAPSHOT-standalone.jar

Start a REPL and start the `-main` function from it:

    $ lein repl
    => (-main)

# Emacs

Install Emacs (on Arch Linux, without X components):

    # pacman -S emacs-nox

Setup the MELPA package repository in `~/.emacs`:

    (require 'package)
    (add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
    (package-initialize)

Re-open emacs and install `clojure-mode` and CIDER with nrepl as follows:

    M-x package-install [RET] clojure-mode [RET]
    M-x package-install [RET] cider [RET]

Use another shell to start your repl:

    $ cd demo
    $ lein repl
    nREPL server started on port 39711 on host 127.0.0.1 - nrepl://127.0.0.1:39711

Back in Emacs, connect to the REPL using the indications given by Leiningen:

    M-x cider-connect [RET] localhost [RET] 39711
# Links

- [Clojure](https://clojure.org/)
- [Leiningen](https://leiningen.org/)
