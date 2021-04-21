# Project Idea

snipperia.ch: publish code snippets and find them again.

## Rationale

As you learn about some programming language, library, framework, algorithm,
design pattern, or other technique, you might want to write and save a minimal
code snippet for later reference. You might also want to add comments to a code
snippet, turning it into a small article. The goal of such an article is not to
_explain_ the snippet to some stranger, but to refresh the knowledge you once
acquired.

## Minimum Viable Program

The folder `snipperia.ch` contains the following:

- `snippets`: the actual code snippets written in Markdown with YAML annotations
- `html`: a statically generated web site based on the `snippets`
- `Makefile`: the rules to build the files within `html` based on the files
  within `snippets`

The `snippets` folder and the `Makefile` are managed using `git`. The `html`
folder can be uploaded to some web server.

For convenience, a `git push` triggers the build process on the web server,
updating the `html` folder, which is served from there.

## Snippet Example

A snippet stored under `snippets/hello-world-in-c.md` looks as follows:

```md
---
title: Hello World in C
author: Patrick Bucher
date: 2021-04-05
tags: hello-world, c
---

This code (`hello.c`):

    #include <stdio.h>

    int main(int argc, char *argv[])
    {
        printf("Hello, World!\n");

        return 0;
    }

Can be built and run as follows:

    $ cc hello.c -o hello && ./hello

Or using `make`:

    $ make hello && ./hello
```

Some program can be written to generate the boiler-plate based on the user's
name from the `git` config, today's date and some CLI options for title and
tags could be written later.

`make` will create the following:

1. `html/index.html`: a page listing all snippets by their title
2. `html/tags.html`: a page listing all snippets by their tag
3. `html/snippets/hello-world-in-c.html`: a page containing the actual snippet
   with tags
4. `html/tags/hello-world.html` and `html/tags/c.html`: tag pages listing all
   the articles belonging to a tag
