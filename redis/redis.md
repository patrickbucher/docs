# Setup

On Arch Linux:

    # pacman -S redis
    # systemctl enable --now redis.service

## Files

- `/etc/redis/redis.conf`: Configuration File
- `/var/lib/redis/dump.rdb`: DB Dump file

## Tools

- `redis-server`: Redis Server
- `redis-sentinel`: Redis Sentinel (Failover)
- `redis-cli`: Redis Command Line Interface
- `redis-benchmark`: Run a Benchmark
- `redis-check-rdb`: Check Redis DB File
- `redis-check-aof`: Check Redis Append-Only File

# Usage

Connect to local Redis using default parameters:

    $ redis-cli
    127.0.0.1:6379>

Connect using explicit connection parameters:

    $ redis-cli -h 127.0.0.1 -p 6379

## Simple Keys

Create a key with a value:

    > set name Joe
    OK

Get a value by its key:

    > get name
    "Joe"

List all keys:

    > keys *
    1) "name"

