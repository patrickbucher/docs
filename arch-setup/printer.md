# Printer

Install, enable and start cups:

    pacman -S cups cups-filters ghostscript
    systemctl enable org.cups.cupsd.service
    systemctl start org.cups.cupsd.service

Avahi:

    pacman -S nss-mdns
    systemctl enable avahi-daemon.service
    systemctl start avahi-daemon.service

edit /etc/nsswitch.conf, add:

    mdns_minimal [NOTFOUND=return]

before

    resolve ...

download driver for Samsung M262x 282x and copy it to

    /usr/share/cups/model/samsung.ppd

Then install:

    lpadmin -p samsung -E -v 'dnssd://samsung._printer._tcp.local/' -m samsung.ppd
    cupsenable samsung
    cupsaccept samsung
