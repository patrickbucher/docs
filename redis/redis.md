Redis: REmote DIctionary Service

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

# Command Overview

See the official [list of all commands](https://redis.io/commands/).

- Meta
    - PING
    - HELP
    - AUTH
    - FLUSHALL
- Key Retrieval
    - KEYS
    - RANDOMKEY
    - EXISTS
    - TYPE
- Basic Usage
    - SET
        - MSET
    - GET
    - DEL
    - RENAME
- Arithmetic
    - INCR
        - INCRBY
    - DECR
        - DECRBY
- Transaction Handling
    - MULTI
    - EXEC
    - DISCARD
- Lists: Prefixes L/R (left/right)
    - LPUSH/RPUSH
    - LRANGE
    - LLEN
    - LPOP/RPOP
    - LREM
    - RPOPLPUSH
    - BLPOP/BRPOP
    - BRPOPLPUSH
- Sets
    - SADD
    - SMEMBERS
    - SPOP
    - SREM
    - SINTER
    - SUNION
    - SDIFF
    - SINTERSTORE
    - SUNIONSTORE
    - SDIFFSTORE
- Hashes
- Databases
    - SELECT
    - MOVE
    - FLUSHDB
- Timeouts
    - EXPIRE
    - EXPIREAT
    - SETEX
    - TTL
    - PERSIST

