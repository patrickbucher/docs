# Mounting

- einhängen: `mount`
    - `-a`: Dateisysteme gemäss `/etc/fstab` einhängen
    - `-o` bzw. `--options`: Optionen definieren
    - `-r` bzw. `-ro`: nur Leseberechtigungen ("read only")
    - `-w` bzw. `-rw`: Schreibberechtigungen
    - `-t TYPE`: Typ des Dateisystems spezifizieren
    - `mount UUID=SOME_UUID`: einhängen per UUID
- aushängen: `umount`
    - `-a`: Dateisysteme gemäss `/etc/fstab` aushängen
    - `-f`: aushängen erzwingen (z.B. bei unerreichbaren Dateisystemen)
    - `-r`: gemountetes Dateisystem schreibgeschützt machen
- `lsof`: list open f iles
    - `lsof DEVICE`: offene Dateien auf DEVICE anzeigen
- Mount-Optionen in `/etc/fstab`
    - `atime` und `noatime`: Zugriffszeit beim Lesen (nicht) aktualisieren
    - `auto` und `noauto`: (nicht) automatisch mounten
    - `defaults`: div. Optionen
    - `exec` und `noexec`: Ausführen von Datien (nicht) erlauben
    - `user` und `nouser`: Mounten durch normalen Benutzer (nicht) erlauben
    - `group`: Benutzer derselben Gruppe darf das Dateisystem mounten
    - `owner`: Besitzer des Geräts darf es mounten
    - `suid` und `nosuid`: SETUID- und SETGID-Bits (nicht) wirksam
    - `ro` und `rw`: read only bzw. read/write
    - `remount`: erneutes mounten (nur per `mount -o`, nicht  per `/etc/fstab`)
        - z.B. um bereits gemountete Partition noch read-only zu mounten
    - `sync` und `async`: synchron oder asynchron (Standard) beschreiben
        - bei SSDs steigt die Abnutzung unter `sync`
- `lsblk`
    - `lsblk -f DEVICE`: Details zu Gerät anzeigen (z.b. UUID)

## systemd mount-Unit

Beispiel (`mnt-backup.mount` ‒ sollte `Where`-Direktive entsprechen):

```ini
[Unit]
Description=Backup Disk

[Mount]
What=/dev/disk/by-uuid/[UUID of the disk]
Where=/mnt/backup
Type=ext4
Options=defaults

[Install]
WantedBy=multi-user.target
```

Automatisches einhängen (`mnt-backup.automount` ‒ als Ergänzung zu
`mnt-backup.mount`):

```ini
[Unit]
Description=automount for Backup Disk

[Automount]
Where=/mnt/backup

[Install]
WantedBy=multi-user.target
```
