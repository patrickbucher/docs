# pf: Packet Filter

Enable/disable pf:

    # pfctl -e
    # pfctl -d

Override the default in `/etc/rc.conf.local`:

    pf=YES

Configure pf using `/etc/pf.conf`.

Some comments on the default configuration:

    set skip on lo

Traffic on the loopback interface is not filtered.

    block return # TODO
    pass

By default, let the ...
