pandoc R.md --toc -S -s -c style.css -t html5 -V title="R" -V author="Patrick Bucher" -V date=$(Get-Date -format dd.MM.yyyy) -o R.html
