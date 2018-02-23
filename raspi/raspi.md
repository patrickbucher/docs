# Raspi Setup

## Network

After copying image to SD card:

    sudo mount /dev/mmcblk0p1 /mnt # mount boot partition
    sudo touch /mnt/ssh # activates ssh
    sudo umount /mnt

    sudo mount /dev/mmcblk0p2 /mnt # mount root partition

Edit `/mnt/etc/dhcpcd.conf`:

    # static ethernet interface for debugging
    interface eth0
    static ip_address=192.168.66.101/24
    static routers=192.168.66.100
    static domain_name_servers=8.8.8.8

Umount SD card:

    sudo umount /mnt

Remove SD card, plug it into the Raspberry.

On Arch Linux, set up the Ethernet as follows:

    sudo ip link set enp0s31f6 up
    sudo ip addr add 192.168.66.100/24 broadcast 192.168.66.255 dev enp0s31f6

Connect to Raspberry using ssh:

    ssh pi@192.168.66.101 # default password: raspberry

Add WiFi credentials:

    sudo bash
    wpa_passphrase [essid] [passphrase] >> /etc/wpa_supplicant/wpa_supplicant.conf

Enable `wpa_supplicant`:

    systemctl enable wpa_supplicant.service
    systemctl start wpa_supplicant.service

Restart networking:

    systemctl restart dhcpcd.service

### HSLU WiFi

- Get QuoVadis certificate from
  [HSLU](https://www.hslu.ch/-/media/campus/common/files/dokumente/h/helpdesk/anleitungen/netzwerk/wlan/sicherheitszertifikat/quovadis%20rca2%20der.zip?la=de-ch)
  and copy it to `/usr/share/ca-certificates/hslu/ca.crt`
- Generate password hash for WPA-EAP: `echo -n 'plaintext password' | iconv -t utf16le | openssl md4` and replace `[TODO]` below with the output.

Add to `/etc/wpa_supplicant/wpa_supplicant.conf`:

    network={
        ssid="hslu"
        scan_ssid=1
        key_mgmt=WPA-EAP
        eap=TTLS
        identity="ibbucher"
        password=hash:[TODO]
        ca_cert="/usr/share/ca-certificates/hslu/ca.crt"
        phase2="auth=MSCHAPV2"
    }

## Basic Setup

Change password:

    passwd

Basic Raspberry configuration:

    sudo raspi-config

A couple of important options:

- 2 Network Options
    - N1 Hostname: set it to some distinct value
- 4 Localisation Options
    - I2 Change Timezone: Europe/Zurich
    - I4 Change Wi-fi Country: CH Switzerland
- 5 Interfacing Options
    - P1 Camera: Activate
- 7 Advanced Options
    - A1 Expand Filesystem: requires restart
- 8 Update: run it
- Finish (and reboot)
