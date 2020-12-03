Problem: Arch Linux recently updated Python to 3.9, but some projects only work
with Python <= 3.8.x.

Solution: Use `pyenv` to install other Python versions.

# Setup

Install `pyenv`:

    # pacman -S pyenv

# Installing

List possible Python versions:

    $ pyenv install --list | grep -E ' [2-3]{1}.[0-9]+.[0-9]+'

Install a specific Python version (e.g. `3.6.12`):

    $ pyenv install -v 3.6.12

See installed versions:

    $ ls ~/.pyenv/versions

or:

    $ pyenv versions

# Uninstalling

Removing a Python version:

    $ rm -r ~/.pyenv/versions/3.6.12

or:

    $ pyenv uninstall 3.6.12

# Switching

See currently active version of python (initially, same as `which python`):

    $ pyenv which python
    /usr/bin/python

Change python version globally:

    $ pyenv global 3.6.12

    $ which python
    /usr/bin/python

    $ pyenv which python
    ~/.pyenv/versions/3.6.12/bin/python

Revert to default version:

    $ pyenv global system

The Python version can be switched on different levels, using the respective
commands and way to store the version number:

1. system: manage using your OS package manager or manually (outside of `pyenv`)
2. global: `pyenv global <version>`
    - `~/.pyenv/version`
3. local: `pyenv local <version>`
    - `.python-version`
4. shell: `pyenv shell <version>`
    - `$PYENV_VERSION`

Initialize the version:

    $ eval "$(pyenv init -)"

# Virtual Environment

Install the `pyenv-virtualenv` plugin:

    $ git clone https://github.com/pyenv/pyenv-virtualenv.git \ 
        "$(pyenv root)/plugins/pyenv-virtualenv"

Activate and init the desired Python version:

    $ pyenv local 3.6.12
    $ eval "$(pyenv init -)"

Create a virtual environment called `myproject` and activate it:

    $ pyenv virtualenv 3.6.12 myproject
    $ pyenv local myproject
    $ pyenv which python
    ~/.pyenv/versions/myproject/bin/python

    $ eval "$(pyenv virtualenv-init -)"

Reactivate the next time:

    $ eval "$(pyenv init -)"
    $ eval "$(pyenv virtualenv-init -)"

Add those commands to the `~/.bashrc`, or, to save some ~0.5 seconds when opening
a shell, create a function to be invoked if `pyenv` is needed in the respective
shell session:

    function p {
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
    }

Then activate everything as follows:

    $ p

## Example: Additional Project

After the initial setup is done, and a Python version (e.g. `3.8.6`) installed,
a new project can be configured with a virtual environment to use that version.

First, move to the project folder:

    $ cd ~/myproject

Second, use the installed python version for that particular project:

    $ pyenv local 3.8.6

Third, install a virtual environment:

    $ pyenv virtualenv myproject

Fourth, activate the virtual environment:

    $ pyenv local myproject

Fifth, activate the environment using the `p` function:

    $ p
