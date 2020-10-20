- Puppet scripts are called "manifests" written in Puppet DSL.
- Puppet supports different types of resources.

# Links

- [Puppet Documentation (6.18)](https://puppet.com/docs/puppet/6.18/puppet_index.html)
- [Puppet Documentation (5.5)](https://puppet.com/docs/puppet/5.5/puppet_index.html)

# Command Feference

## Resources

List built-in resource types:

    $ puppet describe --list

Describe a specific resource type:

    $ puppet describe user

Manage a resource:

    # puppet resource user patrick ensure=present

Show a resource:
    
    $ puppet resource user patrick

Simulate a resource manipulation:

    $ puppet resource user patrick ensure=present --noop

## Misc

Show the puppet version:

    $ puppet --version
