# Notes

Puppet scripts are called "manifests" written in Puppet DSL. A manifest text
files that declare one or more Puppet resources.

Puppet supports different types of resources.

The Puppet DSL looks similar to Ruby's Hash data type.

Ruby:

```ruby
User = { 'patrick' =>
    { 'ensure' -> 'absent' }
}
```

Puppet DSL:

```puppet
user { 'patrick':
    ensure => 'absent',
}
```

Puppet's own configuration can be changed using the `puppet config` command, or
by editing the `/etc/puppet/puppet.conf` configuration file. The file has these 
sections:

- `[main]`: common configuration for master and agent
- `[master]`: configuration for the puppet master
- `[agent]`: configuration for the puppet agent
- `[user]`: TODO

The configuration can be used to connect a puppet agent with its master.

# Links

- [Puppet Documentation (6.18)](https://puppet.com/docs/puppet/6.18/puppet_index.html)
- [Puppet Documentation (5.5)](https://puppet.com/docs/puppet/5.5/puppet_index.html)

# Command Reference

## Resources

List built-in resource types:

    $ puppet describe --list

Describe a specific resource type:

    $ puppet describe user

Manage a resource:

    # puppet resource user patrick ensure=present

Show a resource (and save it as a manifest):
    
    $ puppet resource user patrick
    $ puppet resource user patrick > user.pp

Simulate a resource manipulation:

    $ puppet resource user patrick ensure=present --noop

Apply a resource entered directly in the terminal (with short flag):

    $ puppet apply --execute "user { 'patrick': ensure => 'present' }"
    $ puppet apply -e "user { 'patrick': ensure => 'present' }"

Apply a resource stored in a manifest:

    $ puppet apply user.pp

## Configuration

Set the puppet agent's identity:

    # puppet config set certname doll

By default, `config set` applies to the `[main]` section of the config. This can
be changed using the `--section` option:

Set the puppet agent's environment:

    # puppet config --section agent set environment development

Lookup specific configuration settings (in specific section):

    $ puppet config print certname
    $ puppet config -section main print certname

## Misc

Show the puppet version:

    $ puppet --version

# Resource Types

## File

```puppet
file { '/home/patrick/notes':
    ensure => directory;
}
```

## User

```puppet
user { 'patrick':
    ensure => 'present',
    groups => ['sudo'],
    home   => '/home/patrick',
    shell  => '/bin/bash',
}
```
