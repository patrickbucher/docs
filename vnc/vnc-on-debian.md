# Setup

## Server

Create a new Debian VM on Exoscale (used here: 12 "Bookworm").

Connect using SSH, e.g.:

    ssh debian@desktop

Run updates (select default options when asked):

    sudo apt update -y && sudo apt upgrade -y

Install GUI (e.g. Xfce, also with default options when asked):

    sudo apt install -y task-xfce-desktop

Boot into graphical target:

    sudo systemctl set-default graphical.target

Reboot:

    sudo shutdown -r now

Install VNC server:

    sudo apt install -y tightvncserver

Run it (define a password manually):

    tightvncserver

Adjust `~/.vnc/xstartup`:

```sh
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &
```

## Client

Download and install [TightVNC](https://www.tightvnc.com/download.php) (client only)

Create an SSH tunnel:

    ssh -L localhost:59000:desktop:5901 debian@desktop

Run TightVNC and connect to `localhost:59000`.
