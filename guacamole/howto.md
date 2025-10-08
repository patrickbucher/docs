# Guacamole Howto

## Given

A server running Debian 13 "Trixie" called `gaucamole` with a user called `debian`.

    ssh debian@guacamole

TODO: various desktop environments (idea: automate using Ansible)

## Setup

### Docker

    sudo apt update -y
    sudo apt install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update -y
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

### User

Create a user `guacamole` with a home directory:

    sudo useradd -m -d /home/guacamole -s `which bash` -G docker sudo guacamole
