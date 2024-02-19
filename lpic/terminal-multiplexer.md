# GNU Screen

Start it:

    $ screen
    [Space]

Start it with a specified window name:

    $ screen -t NAME

## Windows

Show windows:

    [Ctrl]-[a] [w]

Add another window:

    [Ctrl]-[a] [c]

Rename current window:

    [Ctrl]-[a] [A]

Jump to next window:

    [Ctrl]-[a] [n]

Jump to window with a given number:

    [Ctrl]-[a] NUMBER

Show window selection menu:

    [Ctrl]-[a] ["]

Kill the current window:

    [Ctrl]-[a] [k]

## Regions

Split with a horizontal bar:

    [Ctrl]-[a] [S]

Split with a vertical bar:

    [Ctrl]-[a] [|]

Jump to another region:

    [Ctrl]-[a] [Tab]

Close active region:

    [Ctrl]-[a] [X]

Close all inactive regions:

    [Ctrl]-[a] [Q]

## Sessions

List sessions:

    $ screen -list

Start another session:

    $ screen -S NAME

Close a session by its PID:

    $ screen -S PID -X quit

Detach from a session:

    [Ctrl]-[a] [d]

Re-attach to a session:

    $ screen -r PID
