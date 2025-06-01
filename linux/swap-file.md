Create a swap file (size: 2G):

    sudo fallocate -l 2G /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile

Activate it:

    sudo swapon /swapfile

Check it:

    sudo swapon --show
    free -h
