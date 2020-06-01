# Partitioning

Given: 500 GB SSD, UEFI, GPT

Partitions:

| # | name | path   | size | type                | format        | remarks     |
|--:|------|--------|------|---------------------|---------------|-------------|
| 1 | boot | /boot  | 512M | 1 EFI System        | mkfs.fat -F32 |             |
| 2 | swap | swapon | 24G  | 19 Swap             | mkswap        | size of RAM |
| 3 | root | /      | 128G | 20 Linux filesystem | mkfs.ext4     |             |
| 4 | var  | /var   | 16G  | 20 Linux filesystem | mkfs.ext4     |             |
| 5 | home | /home  |      | 20 Linux filesystem | mkfs.ext4     | size: rest  |
