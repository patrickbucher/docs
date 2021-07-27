FLAGS=--toc --toc-depth=4 -N -s
PDF_FLAGS=--pdf-engine=xelatex

PDF_VARS=-V documentclass=scrbook -V classoption=11pt -V papersize=a4 -V mainfont='DejaVu Serif' -V sansfont='DejaVu Sans' -V monofont='DejaVu Sans Mono'

.PHONY: all clean

all: R.html R.epub R.pdf

R.html: *.md style.css
	pandoc *.md -c style.css -t html5 $(FLAGS) -o R.html

R.epub: *.md
	pandoc *.md -t epub $(FLAGS) -o R.epub

R.pdf: *.md
	pandoc *.md $(PDF_FLAGS) $(FLAGS) $(PDF_VARS) -o R.pdf

clean:
	rm -f R.html R.epub R.pdf
