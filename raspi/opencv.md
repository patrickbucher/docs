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

Install video processing libraries (if needed):

    sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev

If you have a GUI, install prerequisites for `highgui` module:

    sudo apt-get install libgtk2.0-dev libgtk-3-dev

Install libraries for optimizations:

    sudo apt-get install libatlas-base-dev gfortran

## OpenCV Source

Get the OpenCV sources:

    wget -O opencv.zip https://github.com/opencv/opencv/archive/3.4.1.zip
    unzip opencv.zip

Consider downloading the contrib repo:

    wget -O opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/3.3.0.zip
    unzip opencv_contrib.zip

## Build

Prepare:

    $ cd ~/opencv-3.4.1/
    $ mkdir build
    $ cd build
    $ cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D INSTALL_PYTHON_EXAMPLES=ON \
        -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-3.4.1/modules \ # needed?
        -D BUILD_EXAMPLES=ON ..

Set Swap Size in `/etc/dphys-swapfile`:

    CONF_SWAPSIZE=1024

Restart Swap service:

    sudo /etc/init.d/dphys-swapfile stop
    sudo /etc/init.d/dphys-swapfile start

Build with all cores:

    make -j4

Install it:
    
    sudo make install
    sudo ldconfig
