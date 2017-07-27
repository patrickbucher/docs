pandoc R.md --toc -N -S -s -c style.css -t html5 -V title="R" -V author="Patrick Bucher" -V date=$(date +'%d.%m.%Y') -o R.html
