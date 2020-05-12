# Shared `tmux` Session

_How to share a `tmux` session (on Debian)?_

## Setup

Install `tmux`:

    # apt-get install tmux

Create a common user group `collaborators`:

    # groupadd collaborators

Create two users `alice` and `bob` with the group `collaborators` attached:

    # useradd -G collaborators -m alice
    # useradd -G collaborators -m bob

Set them some good passwords:

    # passwd alice
    # passwd bob

## Shared Session

`alice` creates a shared `tmux` session called `meeting`:

    [alice]$ tmux -S /tmp/shared new -s meeting

`alice` allows the socket `/tmp/shared` for all members of the group `collaborators`:

    [alice]$ chgrp collaborators /tmp/shared

`bob` joins the session:

    [bob]$ tmux -S /tmp/shared attach -t meeting
