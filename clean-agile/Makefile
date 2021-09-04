DOC_OPTS=--toc -N -s
PDF_OPTS=--pdf-engine=xelatex -V documentclass=scrartcl -V papersize=a4 -V urlcolor=blue --dpi=300 -V lang=en
PDF_OPTS_DE=--pdf-engine=xelatex -V documentclass=scrartcl -V papersize=a4 -V urlcolor=blue --dpi=300 -V lang=de
FONT_OPTS=-V mainfont='Linux Libertine' -V sansfont='Linux Biolinum'
DATE=-V date="`date +'%Y-%m-%d'`"
DATE_DE=-V date="`date +'%d.%m.%Y'`"

GRAPHICS=circle-of-life.png iron-cross.png quadrants.png refactoring.png waterfall.png
GRAPHICS_DE=circle-of-life.png eisernes-kreuz.png quadranten.png refactoring-de.png wasserfall.png
ALL=clean-agile.pdf clean-agile.epub clean-agile-de.pdf clean-agile-de.epub $(GRAPHICS_EN) $(GRAPHICS_DE)

.PHONY: all clean

all: $(ALL)

clean-agile.pdf: clean-agile.md $(GRAPHICS)
	pandoc $(DOC_OPTS) $(PDF_OPTS) $(FONT_OPTS) $(DATE) $< -o $@

clean-agile.epub: clean-agile.md $(GRAPHICS)
	pandoc $(DOC_OPTS) $(DATE) $< -o $@

clean-agile-de.pdf: clean-agile-de.md $(GRAPHICS_DE)
	pandoc $(DOC_OPTS) $(PDF_OPTS_DE) $(FONT_OPTS) $(DATE_DE) $< -o $@

clean-agile-de.epub: clean-agile-de.md $(GRAPHICS_DE)
	pandoc $(DOC_OPTS) $(DATE_DE) $< -o $@

.SUFFIXES: .pic .png
.pic.png:
	pic $^ | pic2graph -density 300 -colorspace HSL > $@

clean:
	rm -f $(ALL)
