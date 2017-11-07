all: how-to-read-a-book.pdf

how-to-read-a-book.pdf: how-to-read-a-book.tex how-to-read-a-book.toc quellen.bbl
	xelatex how-to-read-a-book.tex

quellen.bbl: quellen.bib how-to-read-a-book.aux
	bibtex how-to-read-a-book

how-to-read-a-book.toc: how-to-read-a-book.tex
	xelatex how-to-read-a-book.tex

how-to-read-a-book.aux: how-to-read-a-book.tex
	xelatex how-to-read-a-book.aux

clean:
	rm -f *.aux *.bbl *.toc *.blg *.log
