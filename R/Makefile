FLAGS = --toc -N -S -s -c
PDF_FLAGS = --latex-engine=xelatex

VARS = --variable=title:"Programming and Statistics with R" --variable=author:"Patrick Bucher"
PDF_VARS = -V documentclass=scrbook -V classoption=11pt -V papersize=a4 -V mainfont='Droid Serif' -V sansfont='Droid Sans' -V monofont='Fira Mono'

R.html: R.md style.css
	pandoc R.md -c style.css -t html5 $(FLAGS) $(VARS) -o R.html

R.epub: R.md
	pandoc R.md -t epub $(FLAGS) $(VARS) -o R.epub

R.pdf: R.md
	pandoc R.md -t latex $(PDF_FLAGS) $(FLAGS) $(VARS) $(PDF_VARS) -o R.pdf

all: R.html R.epub R.pdf

clean:
	rm -rf R.html R.epub R.pdf
