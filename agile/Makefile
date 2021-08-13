DOC_OPTS=--toc -N -s
PDF_OPTS=--pdf-engine=xelatex -V documentclass=scrartcl -V papersize=a4 -V urlcolor=blue --dpi=300
FONT_OPTS=-V mainfont='Linux Libertine' -V sansfont='Linux Biolinum'
DATE=-V date="`date +'%Y-%m-%d'`"

.PHONY: all clean

all: clean-agile.pdf clean-agile.epub

clean-agile.pdf: clean-agile.md quadrants.png
	pandoc $(DOC_OPTS) $(PDF_OPTS) $(FONT_OPTS) $(DATE) $< -o $@

clean-agile.epub: clean-agile.md quadrants.png
	pandoc $(DOC_OPTS) $(DATE) $< -o $@

.SUFFIXES: .pic .png
.pic.png:
	pic $^ | pic2graph -density 300 -colorspace RGB -format png > $@

clean:
	rm -f clean-agile.pdf clean-agile.epub quadrants.png
