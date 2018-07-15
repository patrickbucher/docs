# Preparation

Prepare the USB stick:

    dd if=archlinux-2017.07.01-x86_64.iso of=/dev/sdb bs=4096

# Installation

Set Swiss German keyboard layout:

    loadkeys de_CH-latin1

Connect to the WiFi network:

    wifi-menu

Update the system clock:

    timedatectl set-ntp true

## Partitioning

Find the block device (`mmcblk0` in case of the _acer_ laptop's SSD card):

    lsblk

Create the partitions:

    fdisk /dev/mmcblk0

- Create a new empty GPT partition table: `g`
- Create the EFI System Partition: `n`, `+512M`
    - Set the type: `t`, `1` (EFI System)
    - Enter the expert's menu: `x`
    - Toggle the bootable flag: `A`
    - Exit the expert's menu: `r`
- Create the Swap Partition: `n`, `+2G` (size of physical memory)
    - Set the type: `t`, `19` (Linux swap)
- Create the root Partition: `n`, use all blocks (if no multiboot is intended)
    - set the type: `t`, `20` (Linux filesystem)
- Save and exit: `w`

Format the root file system:

    mkfs.ext4 /dev/mmcblk0p3

Mount it to `/mnt`:

    mount /dev/mmcblk0p3 /mnt

Create directory for the bootloader:

    mkdir /mnt/boot

Format the boot file system:

    mkfs.fat -F32 /dev/mmcblk0p1

Mount boot partition on it:

    mount /dev/mmcblk0p1 /mnt/boot

Format the swap space file system:

    mkswap /dev/mmcblk0p2

Activate it:

    swapon /dev/mmcblk0p2

Install basic packages:

    pacstrap /mnt base

Generate `fstab`:

    genfstab -U /mnt >> /mnt/etc/fstab

Change root into new system:

    arch-chroot /mnt

Set the time zone:

    ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime

Set the hardware clock:

    hwclock --systohc

Uncomment `en_US.UTF-8 UTF-8` in `/etc/locale.gen` and generate locals:

    locale-gen

Set the `LANG` option in `/etc/locale.conf`:

    LANG=en_US.UTF-8

Set the `KEYMAP` option in `/etc/vconsole.conf`:

    KEYMAP=de_CH-latin1

Set the hostname in `/etc/hostname`

    rumpelkiste

Install additional packages for WiFi:

    pacman -S iw wpa_supplicant dialog intel-ucode wpa_actiond

Set the root password:

    passwd

Install `systemd-boot`:

    systemd-machine-id-setup
    bootctl --path=/boot install

Create the startup configuration file under `/boot/loader/entries/arch.conf`:

    title   Arch Linux
    linux   /vmlinuz-linux
    initrd  /initramfs-linux.img
    options root=PARTUUID=[partition UUID] rw

Don't write the PARTUUID within double quotes!

Find out partition UUID:

    blkid | grep mmcblk0p3 | egrep -o 'PARTUUID="(.+[^"])"'

Modify `/boot/loader/loader.conf`:

    default arch
    timeout 0
    editor  0

Create new _initramfs_:

    mkinitcpio -p linux

Leave and umount recursively:

    exit
    umount -R /mnt

Shutdown:

    shutdown -h now

# Configuration

## WiFi

Connect to WiFi and store profile (without hyphen):

    wifi-menu -o

Enable and start the `netctl-auto` service:

    systemctl enable netctl-auto@wlp2s0.service

## User

Add a user:

    useradd -m paedubucher
    passwd paedubucher

## Font

Install terminus:

    pacman -S terminus-font

Use it as the system's default font in `/etc/vconsole.conf`

    FONT=ter-v16n

## Xorg

Xorg for Intel graphics card:

    pacman -S xorg-server xf86-video-intel xorg-xinit xorg-xset xorg-xsetroot

Packages for compilation:

    pacman -S make gcc pkgconfig

Libraries for dwm, dmenu, slock and st:

    pacman -S libxft libxinerama libxrandr

Touchpad:

    pacman -S xf86-input-synaptics

## alsa

    pacman -S alsa-tools alsa-utils
    alsaloop init

If this causes an error, then probably HDMI is the default sound card. Create
the file `/etc/modprobe.d/alsa.conf` with the content:

    options snd-hda-intel index=1,0

## misc

GTK theme and theme switcher:

    pacman -S gtk-chtheme lxappearance gtk-engine-aurora

Initialize `pacman` file name databaes:

    pacman -Fy

Make sure Java GUIs work properly (add to `$HOME/.bashrc`):

    export _JAVA_AWT_WM_NONREPARENTING=1

### XDG User Dirs

    pacman -S xdg-user-dirs
    xdg-user-dirs-update

Edit `.config/user-dirs.dirs` and clean up the mess. Then run again:

    xdg-user-dirs-update

## mutt

    pacman -S mutt

Create a file `.my-pwds`:

    set my_pw_personal="[SECRET]"

Encrypt it:

    gpg -e .my-pwds > .my-pwds.gpg

    mkdir .mutt
    cp /usr/share/doc/mutt/samples/gpg.rc .mutt/gpg.rc

## ntp

    pacman -S ntp
    systemctl enable ntpd.service
    systemctl start ntpd.service


## sudo

    pacman -S sudo

Edit `/etc/sudoers` **using the `visudo` command, add this line:

    paedubucher ALL=(ALL) ALL

## Boot Order

On a multiboot system, make sure that the Windows Boot Manager is not on the
first position:

    pacman -S efibootmgr
    efibootmgr -o 3,7,0 # 3 is USB stick, 7 internal HDD, 0 Windows Boot Manager

## Windows Key

Find out the embedded Windows license key:

    sudo xxd /sys/firmware/acpi/tables/MSDM

## Printer

For model: Samsung M2825ND

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

download driver for Samsung M262x 282x from [Open Printing](https://openprinting.org/printers) and copy it to:

    /usr/share/cups/model/samsung.ppd

Then install (find out URI and driver using `lpinfo -v` and `lpinfo -m`):

    lpadmin -p samsung -E -v 'dnssd://samsung._printer._tcp.local/' -m samsung.ppd
    cupsenable samsung
    cupsaccept samsung
    lpoptions -d samsung

## Pinentry

Make sure to use the curses version of `pinentry`:

    ln -fs /usr/bin/pinentry-ncurses /usr/bin/pinentry

## Docker

Install docker:

    pacman -S docker

Start and enable the docker service:

    systemctl enable docker.service
    systemctl start docker.service

Create a special docker user and add it to the docker group:

    adduser -m docker
    usermod -a -G docker docker

Logout and login again.

## PostgreSQL

Install postgresql:

    pacman -S postgresql

Switch password of user postgres:

    passwd postgres

Initialize the database cluster as postgres user:

    su postgres
    initdb --locale $LANG -E UTF8 -D '/var/lib/postgres/data'

Enable and start service:

    systemctl enable postgresql.service
    systemctl start postgresql.service

Create a database (as postgres user):

    createdb demo

Start interactive SQL prompt:

    psql demo postgres

Perform SQL operation non-interactively:

    psql demo postgres -c 'SELECT * FROM foobar;'
    psql demo postgres -f commands.sql

## MySQL/Maria DB

Install Maria DB:

    pacman -S mariadb

Initialize the database system:

    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

Enable and start service:

    systemctl enable mariadb.service
    systemctl start mariadb.service

Optionally, configure some security measures:

    mysql_secure_installation

Start interactive SQL prompt:

    mysql -u root -p[password]

Perform SQL operation non-interactively:

    mysql -u root -p[password] -e 'USE foo; SELECT * FROM foo;'
    mysql -u root -p[password] <commands.sql

## Static IP address

Configure static IP address on eno1:

    sudo ip link set eno1 down
    sudo ip addr add 192.168.1.60/24 broadcast 192.168.1.255 dev eno1
    sudo ip link set eno1 up

# Go

Install Go:

    pacman -S go

Create directory (in $HOME):

    mkdir -p ~/go/src

Set environment variables:

   export GOROOT='/usr/lib/go'
   export GOPATH="$HOME/go"
   export GOBIN="$GOROOT/bin"
   export PATH="$PATH:$GOBIN"

## vim-go with vim-plug

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

Extend the `.vimrc` at the very top:

    call plug#begin('~/.vim/plugged')
    call 'fatih/vim-go'
    call plug#end()

Reload .vimrc, then run command in vim:

    :PlugInstall
    :GoInstallBinaries

# SSH key (for GitHub)

Install OpenSSH:

    pacman -S openssh

Create a key:

    ssh-keygen -t rsa -b 4096 -C "patrick.bucher@stud.hslu.ch"

# LaTeX

Basic TeX Live distribution:

    pacman -S texlive-core

For apacite:

    pacman -S texlive-bibtexextra

For multirow etc.:

    pacman -S texlive-latexextra

XeLaTeX (among others):

    pacman -S texlive-bin

# Fonts

TTF Fonts:

    cp *.ttf /usr/share/fonts/TTF
