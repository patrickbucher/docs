# First Steps

## Create a Rails Application

Create a new Rails 6 application called `demo`:

    $ rails new demo
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

## Add a Controler

Create a controller called `Say` with two endpoints `hello` and `goodbye`:

    bin/rails generate controller Say hello goodbye

Which generates the controller `app/controllers/say_controller.rb`. Two
new endpoints are now available:

- `http://localhost:3000/say/hello`
- `http://localhost:3000/say/goodbye`

If accessing one of those endpoints results in an error concerning Webpacker,
run the following:

    TODO: unverified

    $ bin/rails webpacker:install
    $ yarn
