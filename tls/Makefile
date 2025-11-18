FLAGS=--toc -s

PDF_VARS=--pdf-engine=xelatex -V documentclass=scrartcl -V classoption=11pt -V papersize=a4
FONT_VARS=-V mainfont='Libertinus Serif' -V sansfont='Libertinus Sans' -V monofont='Fantasque Sans Mono'
LINK_OPTS=-V urlcolor=blue -V linkcolor=blue
DATE=-V date="`date +'%Y-%m-%d'`"

.PHONY: all clean

all: tls-mastery.epub tls-mastery.pdf

tls-mastery.epub: *.md
	pandoc *.md -t epub $(FLAGS) -o tls-mastery.epub

tls-mastery.pdf: *.md
	pandoc *.md $(FONT_VARS) $(FLAGS) $(PDF_VARS) $(LINK_OPTS) $(DATE) -o tls-mastery.pdf

clean:
	rm -f tls-mastery.epub tls-mastery.pdf
