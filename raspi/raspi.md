# Raspi Setup

## Network

- Get QuoVadis certificate from
  [HSLU](https://www.hslu.ch/-/media/campus/common/files/dokumente/h/helpdesk/anleitungen/netzwerk/wlan/sicherheitszertifikat/quovadis%20rca2%20der.zip?la=de-ch)
  and copy it to `/usr/share/ca-certificates/hslu/ca.crt`
- Generate password hash for WPA-EAP: `echo -n 'plaintext password' | iconv -t utf16le | openssl md4` and replace `[TODO]` below with the output.

`/etc/wpa_supplicant/wpa_supplicant.conf`

    country=CH
    ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
    update_config=1

    network={
        ssid="pren7"
        psk=[secret]
    }

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

    network={
        ssid="bucher"
        psk=[secret]
    }
    network={
        ssid="frzbxpdb"
        psk=[secret]
    }

`/etc/network/interfaces`

    source-directory /etc/network/interfaces.d

    auto eth0
    allow-hotplug eth0
    iface eth0 inet static
        address 192.168.1.66
        netmask 255.255.255.0
        gateway 192.168.1.1

    auto wlan0
    allow-hotplug wlan0
    iface wlan0 inet dhcp
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf

- Make hostname discoverable over network using `avahi`:

```bash
sudo apt-get install avahi-daemon insserv
sudo insserv avahi-daemon
sudo /etc/init.d/avahi-daemon restart
```
