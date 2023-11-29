Create `Vagrantfile` for Debian Jessie VM:

    $ vagrant init debian/jessie64

Bring VM up:

    $ vagrant up

# Using `libvirt`

Install the `libvirt` plugin:

    $ vagrant plugin install vagrant-libvirt

Install the `dnsmasq` plugin:

    $ vagrant plugin install vagrant-dnsmasq

Create a minimal `Vagrantfile`:

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "debian/jessie64"
end
```

Run a VM using libvirt:

    $ vagrant up --provider libvirt
