show possible compose keys

    $ grep 'compose:' /usr/X11R6/share/X11/xkb/rules/base.lst

configure compose key in ~/.xinitrc

    setxkbmap -option compose:caps

if special rules are needed, create file ~/.XCompose; include global rules:

    include "%S/en_US.UTF-8/Compose"

restart X
