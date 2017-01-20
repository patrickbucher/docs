#!/bin/bash

for f in *.md; do
    name="`basename -s '.md' $f`"
    pandoc -s -o "$name.pdf" $f
    pandoc -s -o "$name.html" $f
done
