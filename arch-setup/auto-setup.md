# Install

Set Swiss German keyboard layout, if needed:

    # loadkeys de_CH-latin1

Connect to the WiFi network:

    # iwctl --passphrase [passphrase] station [device] connect [ssid]

Pick a device:

    # lsblk

Download the partition script:

    # curl https://raw.githubusercontent.com/patrickbucher/docs/master/arch-setup/partition.sh > partition.sh

Modify the script according to your environment, then run it:

    # chmod +x partition.sh
    # ./partition.sh

Follow the further instructions printed by the script.

# Setup

Download the setup script:

    # curl https://raw.githubusercontent.com/patrickbucher/docs/master/arch-setup/setup.sh > setup.sh

Modify the script according to your environment, then run it:

    # chmod +x setup.sh
    # ./partition.sh

Follow the further instructions printed by the script.

## Useful Packages

    # pacman -S base-devel man-db manpages
