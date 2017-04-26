all : document.pdf

clean :
	rm -f document.pdf document.bbl document.aux document.blg document.toc

document.pdf : document.tex document.bbl document.toc
	pdflatex document.tex
	pdflatex document.tex

document.bbl : document.bib document.aux
	bibtex document

document.aux : document.tex
	pdflatex document.tex
