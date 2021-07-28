FLAGS=--toc -s -N

PDF_VARS=--pdf-engine=xelatex -V documentclass=scrartcl -V classoption=11pt -V papersize=a4
FONT_VARS=-V mainfont='Linux Libertine' -V sansfont='Linux Biolinum' -V monofont='Source Code Pro'

.PHONY: all clean

all: funcprog.epub funcprog.pdf

funcprog.epub: funcprog.md
	pandoc $^ -t epub $(FLAGS) -o funcprog.epub

funcprog.pdf: funcprog.md
	pandoc $^ $(FONT_VARS) $(FLAGS) $(PDF_VARS) -o funcprog.pdf

clean:
	rm -f funcprog.epub funcprog.pdf
