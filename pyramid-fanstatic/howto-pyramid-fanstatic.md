# Pyramid and Fanstatic

## Setup Pyramid Project

Go to a working directory; create and activate a new python virtual environment:

    $ cd my_workdir
    $ python -m venv env
    $ source env/bin/activate

Upgrade `pip` and `setuptools`; install `cookiecutter` into the virtual
environment:

    $ pip install --upgrade pip setuptools
    $ pip install cookiecutter

Use the template `pyramid-cookiecutter-starter` to create a new application
called `demoapp`:

    $ cookiecutter gh:Pylons/pyramid-cookiecutter-starter --checkout 1.10-branch

Answer the questions as follows:

    re-download the template? Yes
    project_name: demoapp
    repo_name: demoapp
    template_language: jinja2 (1)
    backend: sqlalchemy (2)

Leave the virtual environment (close the shell, then start a new one), and
delete the virtual environment:

    $ rm -rf env

Move to `demoapp`, create a new virtual environment, and activate it:

    $ cd demoapp
    $ python -m venv env
    $ source env/bin/activate

Upgrade `pip` and `setuptools`, then install the project:

    $ pip install --upgrade pip setuptools
    $ pip install -e ".[testing]"

Initialize and upgrade the database using Alembic using a generated revision:

    $ alembic -c development.ini revision --autogenerate -m 'init'
    $ alembic -c development.ini upgrade head

Run the project:

    $ pserve development.ini

The demo application is now available under
[localhost:6543](http://localhost:6543).

## Setup Fanstatic

In `setup.py`, include `fanstatic` as a dependency:

    requires = [
        # existing dependencies
        'fanstatic',
    ]

Re-install the dependencies:

    $ pip install -e ".[testing]"

In `demoapp/static`, create a new `__init__.py` file with the following content:

    from fanstatic import Library

    js_library = Library('demoapp:js', 'js')
    css_library = Library('demoapp:css', 'css')

In `setup.py`, include the following entry point:

    entry_points={
        # existing entry-points
        'fanstatic.libraries': [
            'demoapp:js = demoapp.static:js_library',
            'demoapp:css = demoapp.static:css_library',
        ],
    },

Create the following directories, from which the static content is to be served
through Fanstatic:

    $ mkdir demoapp/static/js
    $ mkdir demoapp/static/css

Replace `demoapp/templates/mytemplate.jinja2` with the following content:

    <h1>Hello, World!</h1>
    <p>This page is Fanstatic!</p>

Create a stylesheet `demoapp/static/css/style.css` as follows:

    body {
        font-family: sans-serif;
        background-color: #eee;
    }

    p {
        color: #a00;
    }

Create a script `demoapp/static/js/script.js` as follows:

    console.log('Hello, World!');

Modify `demoapp/static/__init__.py` and add those files just created as
resources:

    from fanstatic import Library, Resource

    # existing:
    js_library = Library('demoapp:js', 'js')
    css_library = Library('demoapp:css', 'css')

    # new:
    script = Resource(js_library, 'script.js')
    style = Resource(css_library, 'style.css')

The resources `script` and `style` can now be included as a Python module.

Edit `demoapp/views/default.py`. First, import the resources just created:

    from demoapp.static import script, style

Second, replace the existing view code with the following code:

    @view_config(route_name='home', renderer='../templates/mytemplate.jinja2')
    def my_view(request):
        script.need()
        style.need()
        return {}

Finally, the WSGi app must be wrapped with Fanstatic. Open `demoapp/__init__.py`
and replace the line:

    return config.make_wsgi_app()

with the following:

    app = config.make_wsgi_app()
    return Fantastic(app)

When the application is served, the JavaScript and CSS resources are
automatically loaded.
