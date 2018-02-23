# Raspi Setup

After copying image to SD card:

    mount /dev/mmcblk0p1 /mnt # mount boot partition
    touch /mnt/ssh # activates ssh

## Network

Edit `/etc/dhcpcd.conf`:

    # static ethernet interface for debugging
    interface eth0
    static ip_address=192.168.66.101/24
    static routers=192.168.66.100
    static domain_name_servers=8.8.8.8

Add WiFi credentials:

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

