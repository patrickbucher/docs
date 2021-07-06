# `lsof`

## Output Columns

- COMMAND: command that started the process, which in turn opened the file
- PID: process identifier
- TID: task (thread) identifier
- TCMD: task command name
- USER: login of process owner (owner of `/proc/${pid}` entry)
- FD: file descriptor
    - cwd: current working directory
    - err: error
    - ltx: shared library text
    - m86: DOS mapped file
    - mmap: memory mapped file
    - pd: parent directory
    - rtd: root directory
    - txt: program text
    - [number]: file descriptor
    - mode
        - r: read access
        - w: write access
        - u: read and write access
        - lock character
            - ' ': (space): unknown, no lock character)
            - -: unknown, lock character
            - r: partial read lock
            - R: read lock (entire file)
            - w: partial write lock
            - W: write lock (entire file)
            - u: read/write lock (any length)
            - U: unknown lock type
            - ' ': no lock
- TYPE: file type
    - REG: regular file
    - DIR: directory
    - FIFO: first in first out queue
    - CHR: character special file
    - BLK: block special file
    - INET: internet socket
    - unix: Unix domain socket
- DEVICE: device numbers (character, special, block special, regular file,
  directory, NFS file) or kernel reference address for file idnetification
- SIZE/OFF: file size or offset in bytes
- NODE: local node number or NFS inode number; STR (stream), IRQ (socket)
- NAME: mount point of the file

## Examples

Processes that are using a specific file:

    lsof /home/user/hello.txt

Files that are opened in a specific directory:

    lsof -D /home/user

Files opened by a particular command (or multiple commands):

    lsof -c vim
    lsof -c ed -c vim c emacs

Files opened by a particular user (and negation):

    lsof -u patrick
    lsof -u ^patrick

Files opened by a particular process:

    lsof -p 295966

Process IDs that opened a particular file:

    lsof -t /home/user/hello.txt

Combine multiple search criteria (and logic):

    lsof -a -c ed -u patrick -t /home/patrick/diary.txt

Refresh display every five seconds:

    lsof -r5

Files associated with internet connections (and port, and protocol):

    lsof -i
    lsof -i :80
    lsof -i tcp
