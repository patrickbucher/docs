# Rails Setup

Covering Ruby 2.7 and Rails 6

Install `rbenv`:

    $ curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash

Extend `~/.bashrc`:

    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"

And reload it:

    $ . ~/.bashrc

Install Ruby 2.7.7:

    $ rbenv install 2.7.7

Make it the global default:

    $ rbenv global 2.7.7

Install Rails:

    $ gem install rails --version=6.1.7.3 --no-document

Check your setup:

    $ rails --version
    Rails 6.1.7.3

