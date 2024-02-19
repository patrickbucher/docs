This post summarizes the most important information of [LPIC-1
103.5](https://learning.lpi.org/en/learning-materials/101-500/103/103.5/).

It covers the following commands: `jobs`, `fg`, `bg`, `kill`, `nohup`

## Job Control

A process can be stopped by pressing `Ctrl`-`Z` while running:

```bash
$ sleep 60
^Z
[1]+  Stopped                 sleep 60
```

A process can also be sent to the background by starting it with the `&`
(ampersand) character:

```bash
$ sleep 60 &
[2] 3876
```

Use the `jobs` command to list such processes:

```
$ jobs
[1]+  Stopped                 sleep 60
[2]-  Running                 sleep 60 &
```

The `1` in `[1]` can be used as a _job specification_, not to be confused with
the _process id_ (PID).

The `jobs` command supports various flags and different job specifications:

- Flags
    - `-n`: processes that changed status since last notification
    - `-p`: show process ids
    - `-r`: only running jobs
    - `-s`: only stopped/suspended jobs
- Job Specifications
    - `%n`: job with id number `n`
        - `jobs %1`
    - `%str`: job with command starting with `str`
        - `jobs %sleep`
    - `%?str`: job with command containing `str`
        - `jobs %?60`
    - `%+`/`%%`: current job
    - `%-`: previous job

### Moving Processes to the Foreground and Background

Use the commands `fg` and `bg` together with a job specification to send a job
to the foreground or background, respectively:

```bash
$ sleep 60 &
[1] 3885
$ jobs
[1]+  Running                 sleep 60 &
$ fg %1
sleep 60
```

This job is started, stopped (`Ctrl`-`Z`), and moved to the foreground, where it
is running:

```bash
$ sleep 60
^-Z
[1]+  Stopped                 sleep 60
$ bg %1
[1]+ sleep 60 &
```

### Terminate Processes

A job can be terminated pre-maturely by sending it the `SIGTERM` signal using
`kill`:

```bash
$ sleep 60 &
[1] 3898
$ jobs
[1]+  Running                 sleep 60 &
$ kill %1
$ jobs
[1]+  Terminated              sleep 60
```

### Detach Processes

Start a process using the `nohup` ("no hangup") command to detach it from the
current shell (an additional shell session is opened and closed):

```bash
$ nohup sleep 60 &
[1] 3912
$ exit
```

In another shell:

```bash
$ ps 3912
    PID TTY      STAT   TIME COMMAND
   3912 pts/2    S      0:00 sleep 60
```

Even though the shell that started the `sleep` process (PID: 3912) was closed,
the process was still running.

### The `ps` Command

- `ps`: show processes
    - `a`: processes connected to current TTY
    - `x`: processes _not_ connected to current TTY
    - `p PID`: process by PID
    - `u`: list processes of current user
    - `U USER`: list processes by specific user
