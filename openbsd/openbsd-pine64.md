# Prepare Installation Medium

mirror page

    https://mirror.ungleich.ch/pub/OpenBSD/6.7/arm64/

downloads miniroot (arm64)

    https://mirror.ungleich.ch/pub/OpenBSD/6.7/arm64/miniroot67.fs

download signature file

    https://mirror.ungleich.ch/pub/OpenBSD/6.7/arm64/SHA256.sig

verify signature

    $ signify -C -x SHA256.sig miniroot67.fs
    Signature Verified
    miniroot67.fs: OK

prepare usb dongle

    doas dd if=miniroot67.fs of=/dev/sd1 bs=1M && sync

# Prepare pine64

- plug in empty SD card
- plug in ethernet cable
- plug in installation medium
- connect to PC using USB to RS232 cable (UART)
    - see schema

connection to EXP connector:

           GND RXD
    2   4   6   8   10
    1   3   5   7   9
   VCC         TXD
