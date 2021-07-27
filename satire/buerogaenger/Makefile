PARAMS=--pdf-engine=xelatex -V documentclass=scrartcl -V papersize=a4 -V lang=de -V urlcolor=blue
FONTS=-V mainfont="Vollkorn" -V sansfont="Vollkorn"
DATE=-V date="`date +'%d.%m.%Y'`"

%.pdf: %.md
	pandoc -s $(PARAMS) $(FONTS) $(DATE) $< -o $@ 
