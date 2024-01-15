# Forwarding

[Source](https://learning.lpi.org/de/learning-materials/101-500/103/103.4/103.4_01/)

- `noclobber`: throw error instead of overwriting files with forwarding (`>`),
  but appending (`>>`) is still allowed
    - activate: `set -o noclobber` or `set -C`
    - deactivate: `set +o noclobber` or `set +C`

## Here Document

Read until sequence `EOF` with `<<`:

    wc -c <<EOF
    Foo
    Bar
    Qux
    EOF

## Here String

Read a one-line string with `<<<`:

    wc -c <<<"Foo Bar Qux"

# Pipes

[Source](https://learning.lpi.org/de/learning-materials/101-500/103/103.4/103.4_02/)

- `tee -a`: append to file (not truncating it)
- `xargs -n N`: consume `N` arguments per invocation
- `xargs -L N`: consume `N` lines per invocation
- `xargs -0`: use `NULL` as delimiter to separate arguments
    - use with `find … -print0`
