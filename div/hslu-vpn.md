# HSLU VPN

on Arch Linux

Prerequisite: install `rpmextract`:

    $ sudo pacman -S rpmextract

From the [HSLU Software](https://softwaredownload.hslu.ch/Software.aspx) page,
download _HSLU VPN Pulse Secure - CentOS / RedHat / Fedora_ and unpack it:

    $ unzip ps-pulse-linux-9.0r2.0-b819-centos-rhel-installer.zip

Extract the files from the `rpm` file (64-bit version):

    $ rpmextract.sh ps-pulse-linux-9.0r2.0-b819-centos-rhel-64-bit-installer.rpm

Move the contents to `/usr/local/pulse`:

    $ sudo mv usr/local/pulse /usr/local/pulse
    $ sudo mv usr/local/share/man/man1/pulse.1.gz /usr/local/pulse/

Run the configuration script:

    $ sudo /usr/local/pulse/ConfigurePulse_x86_64.sh

Connect to VPN:

    $ /usr/local/pulse/pulsesvc -u ibbucher -p geheim -h vpn.hslu.ch -r HSLU_VLAN

Replace `ibbucher` and `geheim` with the respective username and password.

Leave the program running while accessing VPN.
