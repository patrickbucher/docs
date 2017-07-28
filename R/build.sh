pandoc R.md --toc -N -S -s -c style.css -t html5 -V title="Programming and Statistics with R" -V author="Patrick Bucher" -V date=$(date +'%d.%m.%Y') -o R.html
pandoc R.md --toc -N -S -s -c style.css -t epub -V title="Programming and Statistics with R" -V author="Patrick Bucher" -V date=$(date +'%d.%m.%Y') -o R.epub
