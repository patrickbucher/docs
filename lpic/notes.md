# LPIC-1 (Exam 101)

## 101.1 Determine and Configure Hardware Settings

### Pseudo File Systems

- unlike regular file system:
    - does not exist on a physical disk
    - only exists in RAM
- `/proc`
    - one pid-named folder by process
        - contains `cmdline`: the command that started the process
    - additional "files" (`cpuinfo`, `uptime`, etc.)
- `/sys`
    - information about current hardware and kernel
    - exposed information for applications for kernel interaction
    - e.g. `fs/xfs` for XFS file systems
        - subfolders `error`, `log`, `stats`

# LPIC-1 (Exam 102)
