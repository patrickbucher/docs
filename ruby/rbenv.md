# Setup `rbenv`

Install `rbenv` on Arch Linux using [AUR package](https://aur.archlinux.org/packages/rbenv):

    $ git clone https://aur.archlinux.org/rbenv.git
    $ cd rbenv
    $ makepkg -si --noconfirm
    $ which rbenv
    /usr/bin/rbenv

Append the following line to your `~/.bash_profile`:

    eval "$(rbenv init - bash)"

Then source `~/.bash_profile`:

    $ source `~/.bash_profile`:

Install the `ruby-build` Plugin:

    $ git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

Show available stable releases:

    $ rbenv install -l

Install Ruby 3.2.0 (takes a while):

    $ rbenv install 3.2.0

Set the freshly installed version as the system global (if you haven't installed
another one yet):

    $ rbenv global 3.2.0

Check the version:

    $ ruby --version
    ruby 3.2.0 …

## Handling Gems

After installing a Gem, the binary might not be in `$PATH`:

    $ gem install rufo
    $ which rufo
    which: no rufo in (…)

However, `rbenv` is aware of its location:

    $ rbenv which rufo
    ~/.rbenv/versions/3.2.0/bin/rufo

It could be run using the following workaround:

    $ `rbenv which rufo` hello.rb
    $ echo $?
    0

Use the `rehash` command to update the shims:

    $ rbenv rehash

Then the command will be in `$PATH`:

    $ which rufo
    ~/.rbenv/shims/rufo

