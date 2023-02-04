DOC_OPTS=--toc -N -s
PDF_OPTS=--pdf-engine=xelatex -V documentclass=scrartcl -V papersize=a4 -V urlcolor=blue --dpi=300 -V lang=en
PDF_OPTS_DE=--pdf-engine=xelatex -V documentclass=scrartcl -V papersize=a4 -V urlcolor=blue --dpi=300 -V lang=de
FONT_OPTS=-V mainfont='Linux Libertine' -V sansfont='Linux Biolinum' -V monofont='Linux Libertine Mono'
DATE=-V date="`date +'%Y-%m-%d'`"
DATE_DE=-V date="`date +'%d.%m.%Y'`"

GRAPHICS=pic/circle-of-life.png pic/iron-cross.png pic/quadrants.png pic/refactoring.png pic/waterfall.png
GRAPHICS_DE=pic/circle-of-life.png pic-de/eisernes-kreuz.png pic-de/quadranten.png pic-de/refactoring.png pic-de/wasserfall.png
ALL=clean-agile.pdf clean-agile.epub clean-agile-de.pdf clean-agile-de.epub $(GRAPHICS_EN) $(GRAPHICS_DE)

.PHONY: all clean

all: $(ALL)

clean-agile.pdf: clean-agile.md $(GRAPHICS)
	pandoc $(DOC_OPTS) $(PDF_OPTS) $(FONT_OPTS) $(DATE) $< -o $@

clean-agile.epub: clean-agile.md $(GRAPHICS)
	pandoc $(DOC_OPTS) $(DATE) $< -o $@

clean-agile.docx: clean-agile.md $(GRAPHICS)
	pandoc -V lang=en -N --toc $(DATE) $< -o $@

clean-agile-de.pdf: clean-agile-de.md $(GRAPHICS_DE)
	pandoc $(DOC_OPTS) $(PDF_OPTS_DE) $(FONT_OPTS) $(DATE_DE) $< -o $@

clean-agile-de.epub: clean-agile-de.md $(GRAPHICS_DE)
	pandoc -V lang=de $(DOC_OPTS) $(DATE_DE) $< -o $@

clean-agile-de.docx: clean-agile-de.md $(GRAPHICS_DE)
	pandoc -N --toc $(DATE_DE) $< -o $@

.SUFFIXES: .pic .png
.pic.png:
	pic $^ | pic2graph -density 300 -colorspace HSL > $@

clean:
	rm -f $(ALL)
