# OpenCV on Raspbian Stretch

[Source](https://www.pyimagesearch.com/2017/09/04/raspbian-stretch-install-opencv-3-python-on-your-raspberry-pi/)

## Prerequisites

Install pip for python 3:

    sudo apt-get install python3-pip

Install numpy:

    pip3 install numpy

Install build tools:

    sudo apt-get install build-essential cmake pkg-config

Install image processing libraries:

    sudo apt-get install libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev

Install video processing libraries:

    sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev

Install `python3-dev`:

    sudo apt-get install `python3-dev`

Install libraries for optimizations:

    sudo apt-get install libatlas-base-dev gfortran

## OpenCV Source

Get the OpenCV sources:

    wget -O opencv.zip https://github.com/opencv/opencv/archive/3.4.1.zip
    unzip opencv.zip

## Build

Prepare:

    $ cd ~/opencv-3.4.1/
    $ mkdir build
    $ cd build
    $ cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D PYTHON_DEFAULT_EXECUTABLE=/usr/bin/python3 -D PYTHON_LIBRARY=/usr/lib/python3.5/config-3.5m-arm-linux-gnueabihf/libpython3.5m.so -D BUILD_NEW_PYTHON_SUPPORT=ON -D BUILD_opencv_python3=ON -D HAVE_opencv_python3=ON ..

Set swap size in `/etc/dphys-swapfile`:

    CONF_SWAPSIZE=1024

Restart Swap service:

    sudo /etc/init.d/dphys-swapfile restart

Build with all cores:

    make -j4

Install it:
    
    sudo make install
    sudo ldconfig

Reset swap size in `/etc/dphys-swapfile`:

    CONF_SWAPSIZE=100

Restart Swap service:

    sudo /etc/init.d/dphys-swapfile restart
