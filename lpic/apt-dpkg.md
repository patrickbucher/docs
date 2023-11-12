# Debian-Paketverwaltung verwenden

- Paketformat: `.deb`
    - Für Debian und Debian-Derivate gebräuchlich
- Paketverwaltung
    - Debian Package Manager: `dpkg`
    - Advanced Package Tool: `apt`

## Debian Package Tool `dpkg`

Installation und Update eines Pakets aus einer `.deb`-Datei:

    # dpkg -i package.deb

`dpkg` erkennt Abhängigkeiten, kann sie jedoch nicht selbst auflösen.

Ein Paket anhand seines Namens entfernen (sofern keine anderen Pakete davon
abhängig sind):

    # dpkg -r package

Die Installation bzw. Entfernung eines Pakets vorhandener Abhängigkeiten davon forcieren:

    # dpkg --force -i package
    # dpkg --force -r package

Ein Paket _inklusive Konfigurationsdateien_ entfernen ("purge"):

    # debian -P package

Informationen zu einer Paketdatei anzeigen:

    # dpkg -I package.deb

Liste auf dem System installierter Pakete anzeigen:

    # dpkg --get-selections

Liste der durch ein Paket installierter Dateien anzeigen:

    # dpkg -L package

Paket-Ursprung einer Datei bestimmen:

    # dpkg-query -S datei

Paket-Konfiguration neu erstellen (führt dessen `post-install`-Skript aus,
sichert die bestehende Konfiguration):

    # dpkg-reconfigure package

# Advanced Package Tool `apt`

APT ist ein _Frontend_ für `dpkg` und kann Abhängigkeiten auflösen,
Paketdateien herunterladen, Paketquellen verwalten usw.

APT besteht aus folgenden Programmen:

- `apt-get` Pakete herunterladen, installieren, aktualisieren, entfernen
- `apt-cache`: Operationen im Paketindex (z.B. suchen)
- `apt-file`: Suche nach Dateien innerhalb von Paketen

Das Programm `apt` kombiniert die Fähigkeiten von `apt-get` und `apt-cache`.

Paketindex aktualisieren:

    # apt-get update
    # apt update

Paket installieren:

    # apt-get install package
    # apt install package

Paket entfernen:

    # apt-get remove package
    # apt remove package

Löschen der Konfiguration:

    # apt-get purge package
    # apt purge package

Löschen der Konfiguration und Deinstallation:

    # apt-get remove --purge package
    # apt remove --purge package

Fehlende Abhängigkeiten nachinstallieren:

    # apt-get install -f
    # apt install -f

Paketquellen und Pakete aktualisieren:

    # apt-get update
    # apt-get upgrade

    # apt update
    # apt upgrade

## Cache

- Heruntergeladene Paketdateien werden in `/var/cache/apt/archives` abgelegt.
- Teilweise heruntergeladene Paketdateien werden in
  `/var/cache/apt/archives/partial` abgelegt.

Cache leeren:

    # apt-cache clean
    # apt clean

Nach Paketen suchen:

    # apt-cache search package
    # apt search package

Gecachte Informationen über ein Paket anzeigen:

    # apt-cache show package
    # apt show package

## Quellenlisten

- Paketquellen werden in `/etc/apt/sources.list` verwaltet.

Eintrag (Debian Bookworm):

```
deb http://deb.debian.org/debian/ bookworm main non-free-firmware
```

Syntax:

- Archivtyp (`deb` für Binärpakete oder `deb-src` für Quellcode)
- URL
- Distribution (hier: `bookworm`)
- Komponenten
    - `main`: offiziell unterstützte Pakete
    - `restricted`: Closed-Source-Software
    - `univese`: von der Community gepflegte Pakete
    - `multiverse`: nicht unterstützte Software
    - `contrib`: freie Abhängigkeiten von `main`
    - `non-free`: unfreie Pakete
    - `security`: Sicherheitsupdates
    - `backports`: von neuerer Distribution zurückportiere Pakete

## Dateisuche und Paketinhalte: `apt-file`

Das Zusatzprogramm `apt-file` installieren:

    # apt-get install apt-file

Paketcache aktualisieren:

    # apt-file update

Inhalt eines Pakets auflisten:

    # apt-file list package

Bereitstellendes Paket eines Dateinamens finden:

    # apt-file search filename

Im Gegensatz zu `dpkg-query` funktioniert `apt-file` auch für nicht
installierte Pakete.
