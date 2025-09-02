# WSL

Install the base system without any Linux distribution:

```powershell
wsl --install --no-distribution
```

Make sure to run version 2 of WSL:

```powershell
wsl --set-default-version 2
```

Make sure to restart the system, since it's still Windows, after all.

List available distributions:

```powershell
wsl --list --online
```

Install Debian under WSL:

```powershell
wsl --install --distribution Debian
```

Set Debian as the default distribution:

```powershell
wsl --set-default Debian
```

List all distributions:

```powershell
wsl --list --all
```

List all running distributions:

```powershell
wsl --list --running
```

Terminate the distribution `Debian`:

```powershell
wsl --terminate Debian
```

Get rid of the distribution `Debian`:

```powershell
wsl --unregister Debian
```
