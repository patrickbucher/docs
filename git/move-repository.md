# Move Repository

If you want to move a repository from one server/account to another including
all branches and tags, you must _mirror_ it. This works as follows:

First, clone the repository with the `--mirror` option:

    $ git clone --mirror git@old.com:org/repo

Second, change the origin remote's push URL:

    $ git remote set-url --push origin git@new.com:org/repo

Third, push the repository withthe `--mirror` option:

    $ git push --mirror

Make sure that all tags and branches can be found on the new location.
