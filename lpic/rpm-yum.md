# RPM und YUM-Paketverwaltung verwenden

- rpm: RPM Package Manager
- yum: YellowDog Updater Modifier
- dnf: Dandified YUM
- zypper

## RPM

Paket installieren:

    # rpm -i [name]

Paket aktualisieren ("update"), wenn vorhanden, sonst installieren:

    # rpm -U [name]

Paket aktualisieren, wenn vorhanden:

    # rpm -U -F [name]

Paket entfernen ("erase"):

    # rpm -e [name]

Installierte Pakete auflisten ("query all"):

    # rpm -qa

Informationen zu installiertem Paket anzeigen ("query info"):

    # rpm -qi [name]

Dateien eines installierten Pakets anzeigen ("query list"):

    # rpm -ql [name]

Informationen zu einer nicht installierten Paketdatei anzeigen:

    # rpm -qip [filename]

Dateien einer nicht installierten Paketdatei anzeigen:

    # rpm -qlp [filename]

Paketursprung einer Datei anzeigen ("query file"):

    # rpm -qf [filename]

Weitere Parameter:

- `-v`: ausführliche Ausgabe
- `-h`: Fortschrittanzeige

RPM bemerkt Abhängigkeiten zu anderen Paketen, kann diese aber nicht
selbständig auflösen.

## YUM

Paketsuche:

    # yum search [pattern]

Paket installieren:

    # yum install [name]

Paket aktualisieren:

    # yum update [name]

Alle Pakete aktualisieren:

    # yum update

Prüfen, ob Aktualisierungen vorliegen (für einzelnes Paket und global):

    # yum check-update [name]
    # yum check-update

Herausfinden, welches Paket eine Datei zur Verfügung stellt (egal, ob bereits installiert oder nicht):

    # yum whatprovides [filename]
    # yum whatprovides [path]

Informationen zu einem Paket anzeigen:

    # yum info [name]

### Repositories

- Dateien in `/etc/yum.repos.d/` abgelegt
- Dateien in `/etc/yum.conf` aufgelistet
- z.B. `CentOS-Base.repo`
- `yum-config-manager`: Verwaltung von Repos

Repo hinzufügen:

    # yum-config-manager --add-repo [url]

Verfügbare Repos auflisten:

    # yum repolist all

Repo deaktivieren und wieder aktivieren:

    # yum-config-manager --disable [repo-name]
    # yum-config-manager --enable [repo-name]

Cache unter `/var/cache/yum` leeren (Paketdaten und Metadaten):

    # yum clean packages
    # yum clean metadata

## DNF

DNF ist die YUM-Alternative für Fedora.

Suche nach Paketen:

    # dnf search [pattern]

Informationen zu Paket anzeigen:

    # dnf info [name]

Paket installieren:

    # dnf install [name]

Paket entfernen:

    # dnf remove [name]

Paket aktualisieren:

    # dnf upgrade [name]

Bereitstellendes Paket einer Datei finden:

    # dnf provides [filename]

Installiere Pakete auflisten:

    # dnf list --installed

Paketinhalt auflisten:

    # dnf repoquery -l [name]

Hilfe anzeigen (allgemein und zu einem Unterbefehl):

    # dnf help
    # dnf help [command]

### Repositories

siehe `/etc/yum.repos.d` (analog zu YUM)

Repositories auflisten (alle, aktive, inaktive):

    # dnf repolist
    # dnf repolist --enabled
    # dnf repolist --disabled

Repository hinzufügen, aktivieren, deaktivieren:

    # dnf config-manager --add_repo [url]
    # dnf config-manager --set-enabled [repo-id]
    # dnf config-manager --set-disabled [repo-id]

Repositories auflisten:

    # dnf repolist

## Zypper

Zypper ist die SUSE/OpenSUSE-Alternative zu `apt` und `yum`.

Paketindex aktualisieren:

    # zypper refresh

Paket suchen:

    # zypper se [name]

Installierte Pakete auflisten:

    # zypper se -i [name]

Paket installieren:

    # zypper in [name]

Paket als Datei installieren:

    # zypper in [/full/path/to/file]

Pakete aktualisieren:

    # zypper update

Aktualisierungen anzeigen:

    # zypper list-updates

Paket entfernen (inkl. Abhängigkeiten):

    # zypper remove [name]
    # zypper rm [name]

Bereitstellendes Paket einer Datei finden:

    # zypper se --provides [/full/path/to/file]

Informationen zu einem Paket anzeigen:

    # zypper info [name]

### Repositories

Repositories auflisten:

    # zypper repos

Repositories deaktivieren und aktivieren:

    # zypper modifyrepo -d [name]
    # zypper modifyrepo -e [name]

Aktualisierungen auf Basis eines Repositories deaktivieren und aktivieren:

    # zypper modifyrepo -F [name]
    # zypper modifyrepo -f [name]

Repository hinzufügen (und Aktualisierungen aktivieren bzw. deaktivieren):

    # zypper addrepo [url] [name]
    # zypper addrepo -f [url] [name]
    # zypper addrepo -d [url] [name]

Repository entfernen:

    # zypper removerepo [name]

