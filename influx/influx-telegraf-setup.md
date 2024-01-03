# Download & Setup

From the [downloads page](https://www.influxdata.com/downloads/), download the following compontents:

InfluxDB 2 (Server):

    $ wget https://dl.influxdata.com/influxdb/releases/influxdb2-2.7.4_linux_amd64.tar.gz
    $ sudo tar xf influxdb2-2.7.4_linux_amd64.tar.gz -C / --strip-components=1

InfluxDB 2 (Client):

    $ wget https://dl.influxdata.com/influxdb/releases/influxdb2-client-2.7.3-linux-amd64.tar.gz
    $ tar xf influxdb2-client-2.7.3-linux-amd64.tar.gz
    $ sudo mv influx /usr/local/bin/

Telegraf:

    $ wget https://dl.influxdata.com/telegraf/releases/telegraf-1.29.1_linux_amd64.tar.gz
    $ sudo tar xf telegraf-1.29.1_linux_amd64.tar.gz -C / --strip-components=1

## Setup Using systemd

### InfluxDB

    $ sudo useradd -m -d /home/influxdb -s /usr/bin/bash -U influxdb
    $ sudo cp /usr/lib/influxdb/scripts/influxdb.service /etc/systemd/system/
    $ sudo systemctl daemon-reload
    $ sudo apt install -y curl
    $ sudo systemctl enable --now influxdb.service

Check if InfluxDB is running at [localhost:8086](http://localhost:8086).

Create an initial configuration:

    $ sudo influx setup --host http://localhost:8086 --username influx --password topsecret --org acme --bucket metrics -r 24h -f

### Telegraf

    $ sudo useradd -m -d /home/telegraf -s /usr/bin/bash -U telegraf
    $ sudo cp /usr/lib/telegraf/scripts/telegraf.service /etc/systemd/system/
    $ telegraf --sample-config > telegraf.conf
    $ sudo cp telegraf.conf /etc/telegraf/telegraf.conf
    $ sudo systemctl daemon-reload

Extend the initial config (`/etc/telegraf/telegraf.conf`):

```ini
[[outputs.influxdb_v2]]
urls = ["http://127.0.0.1:8086"]
token = "TODO: `figure out using influx auth ls`"
organization = "acme"
bucket = "metrics"
```

Replace the token value (`topsecret`) with the proper token as shown here:

    $ influx auth ls

Start Telegraf:

    $ sudo systemctl enable --now telegraf.service

Checkout the Data Explorer on [localhost:8086](http://localhost:8086) after a while.
