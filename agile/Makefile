DOC_OPTS=--toc -N -s
PDF_OPTS=--pdf-engine=xelatex -V documentclass=scrartcl -V papersize=a4 -V urlcolor=blue
FONT_OPTS=-V mainfont='Linux Libertine' -V sansfont='Linux Biolinum'
DATE=-V date="`date +'%Y-%m-%d'`"

.PHONY: all clean

all: clean-agile.pdf clean-agile.epub

clean-agile.pdf: clean-agile.md
	pandoc $(DOC_OPTS) $(PDF_OPTS) $(FONT_OPTS) $(DATE) $^ -o $@

clean-agile.epub: clean-agile.md
	pandoc $(DOC_OPTS) $(DATE) $^ -o $@

clean:
	rm -f clean-agile.pdf clean-agile.epub
