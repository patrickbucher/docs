# Multiple Server Sockets

Create a new socket:

    tmux -L foo

Connect to existing socket:

    tmux -L foo attach

Changing default socket location (default: /tmp):

    export TMUX_TMPDIR="$HOME"


# Sessions

Start new session:

    tmux new-session

Shortcut:

    tmux

Call the new session 'workspace':

    tmux new-session -s 'workspace'

Create a new session 'other':

    Prefix + :
    new-session -s 'other'

Switch betweeen sessions:

    previous:
        Prefix + (
    next:
        Prefix + )
    last:
        Prefix + L
    interactive selection:
        Prefix + s

Rename a session:

    Prefix + $

# Windows

Create a new window:

    Prefix + c

Switch between windows:

    previous:
        Prefix + p
    next:
        Prefix + n
    by index:
        Prefix + 0
        Prefix + 1
        etc.
    pick by index (prompt):
        Prefix + '
    pick by matching string (prompt):
        Prefix + f
    list of windows:
        Prefix + w

Rename a window:

    Prefix + ,
