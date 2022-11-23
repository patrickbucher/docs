Install `spiped` (on Arch Linux):

    sudo pacman -S spiped

Create some pseudo-key file:

    echo -n 'topsecret' > secret.key

Encrypting from source (`-s`) to target (`-t`) socket using key (`-k`) in
`secret.key`:

    spiped -e -s [127.0.0.1]:2000 -t [127.0.0.1]:3000 -k secret.key

Decrypting from source (`-s`) to target (`-t`) socket using key (`-k`) in
`secret.key`:

    spiped -d -s [127.0.0.1]:3000 -t [127.0.0.1]:4000 -k secret.key

Listen to the output socket:

    nc -l 4000

Send some data to the input socket:

    echo 'secret message' | nc localhost 2000

The message `secret message` should now appear in the terminal running `nc -l
4000`.

