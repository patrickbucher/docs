# Iostat

Install:

    # pacman -S sysstat

Use:

    $ iostat [interval] [count]

Every second ten times:

    $ iostat 1 10

# Zombie Processes

'D' means process is in uninterruptable sleep:

    $ ps -eo state,pid,cmd | grep "^D"
