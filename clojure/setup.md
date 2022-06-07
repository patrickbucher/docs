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

# Links

- [Clojure](https://clojure.org/)
- [Leiningen](https://leiningen.org/)
