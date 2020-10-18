Install CUPS:

    # pkg_add cups

Enable and start CUPS:

    # rcctl enable cupsd
    # rcctl start cupsd

Enable and start browser configuration interface:

    # rcctl enable cups_browsed
    # rcctl start cups_browsed

Configure the printer over [web interface](http://localhost:631). Assign a name
to the printer, such as `brother`.

Make the configured printer (`brother`) the default:

    $ /usr/local/bin/lpoptions -d brother

Print a document:

    $ /usr/local/bin/lpr document.pdf

Set paper size to A4:

    $ /usr/local/bin/lpoptions -o media=A4

Use long-edge duplex printing:

    $ /usr/local/bin/lpoptions -o sides=two-sided-long-edge

Consider setting an alias for CUPS versions of `lpr`, `lpq`, and `lpotions` (`~/.kshrc`):

    alias lpr='/usr/local/bin/lpr'
    alias lpq='/usr/local/bin/lpq'
    alias lpoptions='/usr/local/bin/lpoptions'
    alias cancel='/usr/local/bin/cancel'

To print PDFs two-sided, consider scaling them to A4:

    $ gs -sDEVICE=pdfwrite -dNOPAUSE -dQUIET -dBATCH -sPAPERSIZE=a4 \
         -dPDFFitPage -sOutputFile=document-a4.pdf document.pdf
