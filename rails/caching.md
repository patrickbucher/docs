# Caching with Rails

from [Caching with Rails](https://guides.rubyonrails.org/caching_with_rails.html)

Toggle caching in dev mode:

    rails dev:cache

Or in `config/environments/development.rb`, set [`perform_caching`](https://guides.rubyonrails.org/configuring.html#config-action-controller-perform-caching) to `true` (only for caching provided by Action Controller).

Techniques:

- Page: for generated pages (avoids Rails stack)
- Action: allows for before filters (hits the Rails stack)
- Fragment (default): caches (nested) page fragments
- Low-Level Caching: for any serializable information

## Low-Level caching

`Rails.cache.fetch`:

- single argument: fetch a key
- pass a block: populates the key in case of a miss

Method `cache_key_with_version` generates keys

Do not cache Active Record Objects, store primitive data types (or collections).

## Cache Stores

`Rails.cache`:

    config.cache_store = :memory_store, { size: 64.megabytes }

Connection pooling (`Gemfile` and Config):

    gem 'connection_pool'

    config.cache_store = :mem_cache_store, "cache.example.com", { pool_size: 5, pool_timeout: 5 }

### Redis

default: `allkeys-lfu` (Keeps frequently used keys; removes least frequently
used (LFU) keys), see [Key Eviction](https://redis.io/docs/reference/eviction/)

`Gemfile`:

    gem 'redis'

Or (faster):

    gem 'hiredis'

Config:

    config.cache_store = :redis_cache_store, { url: ENV['REDIS_URL'] }

