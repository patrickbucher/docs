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

## Source

- [Easily Setup Your Wacom Tablet Under Linux](https://www.youtube.com/watch?v=dzplf-0RJDE)

