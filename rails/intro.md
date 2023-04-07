# First Steps

## Create a Rails Application

Create a new Rails 6 _API only_ application called `demo`:

    $ rails new demo --api
    $ cd demo

Examine the installation to check versions and the like:

    $ bin/rails about

Or alternatively:

    $ bundle exec rails about

Start the Rails server:

    $ bin/rails server

Use the `-b` parameter to bind to a specific address, e.g. `0.0.0.0`:

    $ bin/rails server -b 0.0.0.0

Check out more parameters using the `--help` flag:

    $ bin/rails server --help

And check `http://localhost:3000/`, which should display a welcome page.
