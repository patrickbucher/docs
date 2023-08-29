# Wacom Tablet

Install the driver and the `xsetwacom` utility:

    # pacman -S xf86-input-wacom

After re-starting X, check if the devices are listed:

    $ xsetwacom --list devices
    Wacom Intuos M Pen stylus               id: 9   type: STYLUS
    Wacom Intuos M Pad pad                  id: 10  type: PAD

## Output Mapping

For multiple monitors (say, with a 1920x1080 resolution), use an offset to map
the stylus (here: id 9, see above) to the proper monitor (e.g. the second from
the left):

    $ set 9 MapToOutput 1920x1080+1920+0

The `+1920` is the X offset; `+0` is the Y offset.

## Aspect Ratio

For a monitor with a resolution of 2550x1440 (check with `xrandr`), the aspect
ratio is 16:9:

    2550 / 1440 = 1.777
      16 /    9 = 1.777

Figure out the resolution of the tablet:

    $ xsetwacom get 9 area
    0 0 21600 13500

Which uses a 16:10 aspect ratio:

    21600 / 13500 = 1.6
       16 /    10 = 1.6

Therefore, the height of the tablet (13500) has to be cropped so that:

    21600 / h      = 16 / 9 | *h, *9
    21600 * 9      = 16 * h | /16
    21600 * 9 / 16 = h
    h              = 12150

Which can be set as follows:

    $ xsetwacom set 9 Area 0 0 21600 12150

## Automation

This script will set the resolution automatically:

```bash
#!/usr/bin/bash

id="$(xsetwacom --list devices | grep STYLUS | grep -Eo 'id: .+' | grep -Eo '[[:digit:]]+')"
if [ -z id ]
then
    exit 1
fi

xsetwacom set $id Area 0 0 21600 12150
```

Save it under `/usr/local/bin/wacom-set-res` and make it executable:

    # chmod +x /usr/local/bin/wacom-set-res

To invoke it automatically, a `udev` rule shall be defined.

First, the vendor and product id have to be found:

    $ lsusb | grep Wacom | grep -Eo 'ID [[:digit:]]{4}:[[:digit:]]{4}'
    ID 056a:0375

The first part `0560` is the vendor ID, the second part `0375` is the product ID.

Create a `udev` rule in `/etc/udev/rules.d/wacom-tablet.rules`:

    ACTION=="add" ATTRS{idVendor}=="056a", ATTRS{idProduct}=="0375", RUN+="/usr/local/bin/wacom-set-res"

Matching both vendor and product ID, the script above is run, after the rules
are reloaded:

    # udevadm control --reload-rules && udevadm trigger

TODO: the script doesn't work reliably yet; `$DISPLAY` and `$XAUTHORITY` aren't
set yet; so neither will `$id` be.

## Source

- [Easily Setup Your Wacom Tablet Under Linux](https://www.youtube.com/watch?v=dzplf-0RJDE)

