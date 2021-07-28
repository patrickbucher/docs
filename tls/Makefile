FLAGS=--toc -s

PDF_VARS=--pdf-engine=xelatex -V documentclass=scrartcl -V classoption=11pt -V papersize=a4
FONT_VARS=-V mainfont='Linux Libertine' -V sansfont='Linux Biolinum' -V monofont='Source Code Pro'

.PHONY: all clean

all: tls-mastery.epub tls-mastery.pdf

tls-mastery.epub: *.md
	pandoc *.md -t epub $(FLAGS) -o tls-mastery.epub

tls-mastery.pdf: *.md
	pandoc *.md $(FONT_VARS) $(FLAGS) $(PDF_VARS) -o tls-mastery.pdf

clean:
	rm -f tls-mastery.epub tls-mastery.pdf
