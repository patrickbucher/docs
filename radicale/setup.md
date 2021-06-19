# Radicale

Setup virtual environment and install Radicale:

    $ mkdir ~/radicale
    $ cd ~/radicale
    $ python3 -m venv env
    $ . env/bin/activate
    $ pip 3 install radicale

Create a unit file (`/etc/systemd/system/radicale.sercice`):

    [Unit]
    Description=Radicale caldav
    After=network.target
    Requires=network.target

    [Service]
    ExecStart=/home/debian/radicale/env/bin/python3 -m radicale --storage-filesystem-folder=/home/debian/radicale/data
    Restart=on-failure
    User=debian

    [Install]
    WantedBy=multi-user.target

Server configuration (Nginx, proper TLS config below):

    server {
            listen 0.0.0.0:80;
            server_name calendar.paedubucher.ch;

            location / {
                    auth_basic              "Restricted";
                    auth_basic_user_file    "/home/debian/radicale/radicale.passwd";
                    proxy_pass              http://localhost:5232;
                    proxy_redirect          off;
                    proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
                    proxy_set_header        X-Real-IP $remote_addr;
                    proxy_set_header        Host $http_host;
                    proxy_set_header        X-outside-url http://calendar.paedubucher.ch:80;
            }
    }

Install `htpasswd` (on Debian via `apache2-utils`) and generate the password file:

    $ htpasswd -c /home/debian/radicale/radicale.passwd radicale


Run `certbot` to TLS configuration (choose with redirect):

    $ sudo certbot --nginx -d calendar.paedubucher.ch --post-hook "systemctl reload nginx"
