# Hugo Howto

Using the website [paedubucher.ch](https://paedubucher.ch) as an example.

## Basic Setup

Create a new site:

    $ hugo new site paedubucher.ch

Which creates the following structure:

    $ tree paedubucher.ch
    paedubucher.ch/
    ├── archetypes
    │   └── default.md
    ├── config.toml
    ├── content
    ├── data
    ├── layouts
    ├── static
    └── themes

- `archetypes`: Markdown templates for different kinds of content
- `config.toml`: configuration for building the site
- `content`: raw content, in Markdown or HTML format
- `data`: raw data, in YAML, JSON, or TOML format
- `layouts`: look and feel definition
- `static`: CSS, JavaScript, images, and other assets
- `themes`: downloaded or individually created themes

Adjust `config.toml` as follows:

```toml
baseURL = "https://paedubucher.ch/"
languageCode = "en-us"
title = "paedubucher.ch"
```

The `baseURL` is important if _not_ working with relative URLs. The `title` will
be used for the layouts.

Layout and templates on one side, and pages and data objects (like lists) on the
other side can be combined to produce output.

## Home Page

Create a page under `layouts/index.html` for the home page:

```html
<!DOCTYPE html>
<html>
    <head>
        <title>{{ .Site.Title }}</title>
        <meta charset="utf-8">
        <meta name="author" content="Patrick Bucher">
        <meta name="description" content="Personal website of Patrick Bucher with articles on various topics in German and English.">
        <meta name="viewport" content="width=device-width, initial-scale=1">
    </head>
    <body>
        <h1>{{ .Site.Title }}</h1>
        <p class="slogan"><cite>Move slow and try to understand things</cite></p>
        {{ .Content }}
    </body>
</html>
```

[Go Templates](https://pkg.go.dev/html/template) are used to define dynamic
elements such as `{{ .Site.Title }}` or `{{ .Content }}`. (The `Site` context
contains overall website information, whereas `Content` is only about the
individual page.)

The content for `layouts/index.html` is taken from `content/_index.md`.

To run the site (visit [localhost:1313](http://localhost:1313)):

    $ hugo server

## Adding Pages

Based on a (slightly extended) `archetypes/default.md`:

```md
---
title: "{{ replace .Name "-" " " | title }}"
subtitle: 
author: Patrick Bucher
date: {{ .Date }}
lang: en
draft: true
---
```

Pages can be added using the `new` command:

    $ hugo new hello.md

Which creates:

```md
---
title: "Hello"
subtitle: 
author: Patrick Bucher
date: 2021-08-07T20:11:11+02:00
lang: en
draft: true
---
```
