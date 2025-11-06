Starting on HEAD, which has a bug:

    git bisect start

Search for an older commit that didn't have the bug:

    git log

Once found, mark that one as good:

    git bisect good COMMIT

Now test the code base repeatedly, and based on the outcome, mark the commit as either good or bad:

    git bisect good
    git bisect bad

Until the commit introducing the bug is found using binary search.

Once the commit has been found, reset to HEAD and finish bisecting:

    git bisect reset

