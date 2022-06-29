# Setup

Prerequisites:

- OpenJDK
- Clojure

On Arch Linux:

    # pacman -S jdk-openjdk clojure

## Project

Create the project scaffolding:

    $ mkdir -p hello/src
    $ cd hello
    $ touch src/app.cljs

In `src/app.cljs`:

```clojurescript
(ns app)

(set! (.-innerHTML (.getElementById js/document "message")) "Hello, World!")
```

In `deps.edn`:

```edn
{:deps {org.clojure/clojurescript {:mvn/version "1.11.54"}}}
```

In `index.html`:

```html
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Hello, World!</title>
    </head>
    <body>
        <p id="message"></p>
        <script src="out/main.js"></script>
    </body>
</html>
```

Run it with a REPL:

    $ clj --main cljs.main --watch src --compile app --repl

Notice that the namespace (`(ns app)`), the file name (`app.cljs`), and the
compile target (`--compile app`) all use the name `app`.
