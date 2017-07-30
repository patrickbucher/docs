FLAGS = --toc -N -S -s -c style.css -t html5
PDF_FLAGS = $(FLAGS) --latex-engine=xelatex

VARS = -V title="Programming and Statistics with R" -V author="Patrick Bucher" -V date=$(date +'%d.%m.%Y')
PDF_VARS = $(VARS) -V documentclass=scrbook -V classoption=11pt -V papersize=a4 -V mainfont='Droid Serif' -V sansfont='Droid Sans' -V monofont='Fira Mono' 


R.html: R.md style.css
	pandoc $(FLAGS) $(VARS) -c style.css -t html5 R.md -o R.html
R.epub: R.md
	pandoc $(FLAGS) $(VARS) -t epub R.md -o R.epub
R.pdf: R.md
	pandoc $(PDF_FLAGS) $(PDF_VARS) -t latex R.md -o R.pdf

all: R.html R.epub R.pdf

clean:
	rm -rf R.html R.epub R.pdf
