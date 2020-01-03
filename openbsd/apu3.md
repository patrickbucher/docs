# Host Preparation (Arch Linux)

Install `cu` or a similar program able to communicate through the serial port:

    # pacman -S cu

Plugin the Serial cable and check it's device (here: `/dev/ttyUSB0):

    $ dmesg | grep tty

Connect to the apu3 over com0 (baud rate 115200):

    $ cu -l /dev/ttyUSB0 -s 115200

When you see the boot prompt on the apu3, quickly type this options:

    stty com0 115200
    set tty com0

Then press Return to boot the installer.
