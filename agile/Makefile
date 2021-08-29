DOC_OPTS=--toc -N -s
PDF_OPTS=--pdf-engine=xelatex -V documentclass=scrartcl -V papersize=a4 -V urlcolor=blue --dpi=300 -V lang=en
FONT_OPTS=-V mainfont='Linux Libertine' -V sansfont='Linux Biolinum'
DATE=-V date="`date +'%Y-%m-%d'`"

GRAPHICS=circle-of-life.png iron-cross.png quadrants.png refactoring.png waterfall.png

.PHONY: all clean

all: clean-agile.pdf clean-agile.epub $(GRAPHICS)

clean-agile.pdf: clean-agile.md $(GRAPHICS)
	pandoc $(DOC_OPTS) $(PDF_OPTS) $(FONT_OPTS) $(DATE) $< -o $@

clean-agile.epub: clean-agile.md quadrants.png
	pandoc $(DOC_OPTS) $(DATE) $< -o $@

.SUFFIXES: .pic .png
.pic.png:
	pic $^ | pic2graph -density 300 -colorspace HSL > $@

clean:
	rm -f clean-agile.pdf clean-agile.epub $(GRAPHICS)
