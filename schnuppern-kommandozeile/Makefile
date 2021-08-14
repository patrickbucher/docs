.PHONY: all clean

all: search-small.txt search-big.txt kommandozeile.pdf

search-small.txt: generate.py
	./generate.py 1000 > $@

search-big.txt: generate.py
	./generate.py 1000000 > $@

kommandozeile.pdf: kommandozeile.md
	pandoc -t ms $^ -o $@

clean:
	rm -f search-small.txt search-big.txt kommandozeile.pdf
