rm -f git.pdf
rm -f git.html
pandoc -S -s git.md -o git.pdf
pandoc -S -s git.md -o git.html
