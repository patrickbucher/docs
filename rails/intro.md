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

## Add a Model

Generate a `User` model with just an `email` address and a `password_digest`:

    $ rails generate model User email:string password_digest:string

Run the database migration:

    $ rake db:migrate

Generate a `Product` model that belongs to a `User`:

    $ rails generate model Product title:string price:decimal published:boolean user:belongs_to

Which creates an indexed column `Product.user_id` pointing to `User.id`.

## Add a Controller

    $ rails generate controller api::v1::users
