rm -f git.html
rm -f git.pdf

pandoc -S -s --toc \
    --variable title=Git \
    --variable author="Patrick Bucher" \
    git.md -o git.html

pandoc -S -s --toc \
    --variable title=Git \
    --variable author="Patrick Bucher" \
    --variable papersize=a4 \
    --variable documentclass=scrartcl \
    --variable fontfamily=times \
    git.md -o git.pdf
