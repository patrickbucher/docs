#!/bin/sh

input="shell.md"
title="Shell Cheat Sheet"
author="Patrick Bucher"
date="`date +%Y-%m-%d`"

pandoc -s -S --toc -t latex "$input" -o shell.pdf \
    -V title="$title" \
    -V author="$author" \
    -V date="$date" \
    -V papersize=a4 \
    -V documentclass=scrartcl \
    -V classoption=11pt \
    -V fontfamily='times' \
    -V lang='en' \

pandoc -s -S --toc -t html5 "$input" -o shell.html -c style.css \
    -V title="$title" \
    -V author="$author" \
    -V date="$date" \
    -V lang='en'
