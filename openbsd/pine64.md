put minifs (arm64) on SD card and plug it into pine64

setup requires serial communication, use Raspberry Pi (connect TXD-RXD, RXD-TXD, and GND-GND)

install cu on raspi

	apt-get install cu

add user pi to dialout group

	sudo usermod -a -G dialout pi

make sure serial console can be accessed

	chmod 777 /dev/ttyS0

connect to pine64

	cu -l /dev/ttyS0 -s 115200

(this works _somehow_, but is not very stable. to be continued...)
