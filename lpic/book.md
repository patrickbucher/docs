# LPIC-1

Anselm Lingnau: LPIC-1. Optimale Vorbereitung auf die LPI-Prüfungen 101 und 102. 7. Auflage (ISBN-13: 978-3-95845-956-4)

## Dokumentation

Gegenüberstellung Manual Pages und GNU Info:

|                             | Manual Pages     | GNU Info          |
|-----------------------------|------------------|-------------------|
| Befehl                      | `man`            | `info`            |
| Verzeichnis                 | `/usr/share/man` | /`usr/share/info` |
| Umgebungsvariable für Pfade | `MANPATH`        | `INFOPATH`        |

Kapitel der Manual Pages:

1. Benutzerkommandos
2. Systemaufrufe
3. Bibliotheksaufrufe
4. Gerätedateien
5. Konfigurationsdateien, Dateiformate
6. Spiele
7. Diverses, Konventionen
8. Systemadministrationskommandos
9. Kernel-Funktionen

Hilfreiche Befehle:

- `man -k STICHWORT` bzw. `apropos STICHWORT`: nach einem Suchbegriff suchen
    - siehe Index `/var/cache/man/index.db`, mit `mandb` aktualisierbar
- `whatis BEFEHL`

Weitere Quellen:

- [Linux Documentation Project](https://tldp.org): HOWTOs, Guides, FAQs usw.
- [LWN.net](https://lwn.net/): Neuigkeiten, Artikel

## Kommandos: Überblick und Dateiverwaltung

- Die Umgebungsvariable `$0` hat den Pfad zur laufenden Shell als Wert (z.B. `/bin/bash`).
- Man unterscheidet zwischen zwei Arten von _Parameter_:
    1. Optionen (optional), in Kurzform (`-v`) oder Langform (`--verbose`),
       wobei die Kurzformen kombinierbar sind (`-al`).
    2. Argumente (zwingend oder optional), deren Bedeutung anhand ihrer Position
       im Befehl bestimmt wird.
- Um welche Art von Befehl es sich handelt (Alias, integrierter Shell-Befehl,
  ausführbare Datei) ermittelt man mit dem Befehl `type`.
- Mit dem Befehl `history` kann man sich vergangene Befehle anzeigen lassen.
  Diese Befehle können anhand der dargestellten Laufnummer direkt mit `!`
  ausgeführt werden, z.B. `!12857`.
- Das Glob-Pattern `*` wird _nicht_ auf versteckte Dateien (Dateiname mit `.`
  beginnend) angewendet.

### Dateioperationen

- `ls -F` fügt Ordnern das Suffix `/`, ausführbaren Dateien das Suffix `*` und
  symbolischen Links das Suffix `@` an.
- Bei der Ausgabe von `ls -l` hat das erste Zeichen die folgende Bedeutung: `d`
  für Verzeichnisse, `l` für symbolische Links und `-` für Dateien.
- Möchte man `ls` auf ein Verzeichnis selber anwenden und damit nicht dessen
  Inhalte auflösen, kann man die Option `-d` verwenden (v.a. mit anderen
  Optionen wie `-l` sinnvoll).
- Mit `cd -` kann man in das Verzeichnis wechseln, in dem man sich vor dem
  letzten `cd`-Aufruf befunden hat.
- Mit `rmdir` können leere Verzeichnisse gelöscht werden; mit `rmdir -p` werden
  leere Unterverzeichnisse gleich mitbeseitigt.
- Befehle wie `cp` unterstützen einen interaktiven Modus über die Option `-i`,
  der vor bestimmten Operationen explizit den Benutzer nachfragt (z.B. beim
  Überschreiben von Dateien mit `cp`).
- Die Option `-a` von `cp` erlaubt das _Archivieren_ von Dateien, wobei
  Metadaten wie Berechtigungen und Zeitstempel mitkopiert werden.

### Modifikationszeiten

- Mit `ls -l` wird standardmässig die Modifikationszeit (`mtime` für
  "modification time") angezeigt. Die Erstellungszeit (`ctime` für "creation
  time") wird mit `ls -lc` angezeigt; die letzte Zugriffszeit (`atime` für
  "access time"; lesend/schreibend) mit `ls -la`.
    - Der Befehl `touch` modifiziert standardmässig `atime` und `mtime`; mit
      `touch -a` und `touch -m` wird nur die Zugriffs- (`atime`) bzw.
      Modifikationszeit (`mtime`) verändert. Die `ctime` wird von `touch`
      _immer_ verändert. Mit `-d` oder `-t` kann ein Zeitstempel explizit
      angegeben werden, mit `-r DATEI` wird der Zeitstempel der angegebenen
      Datei verwendet.

### Links und inodes

- Die Zugriffsrechte eines symbolischen Links sind weitgehend irrelevant, da die
  Rechte der Zieldatei berücksichtigt werden.
- Die inode-Nummer mithilfe von `ls -li` angezeigt werden.
- Ein Verzeichnis ist eine Tabelle von inodes.
- Symbolische Links können mit den Optionen `-H` und `-L` von `ls` aufgelöst werden.
- Mit `cp -l VERZEICHNIS/*` kann für alle Dateien im Verzeichnis ein harter Link
  angelegt werden. Dies bezeichnet man als _Link-Farm_. Mit `cp -s` funktioniert
  das auch für symbolische Links.

### Berechtigungen

- Die _Execute_-Berechtigung erlaubt nicht nur das Betreten eines
  Verzeichnisses, sondern auch die Verwendung eines Verzeichnisses in einem
  weiterführenden Pfad.
- Zum Löschen einer Datei werden keine Schreibrechte darauf sondern
  Modifikationsrechte auf das beinhaltende Verzeichnis benötigt. Mit dem
  Schreibrecht auf eine Datei kann diese jedoch geleert werden (z.B. mit
  `truncate -s 0`).
- Verfügt der "Rest der Welt" über mehr Rechte als eine bestimmte
  Benutzergruppe, erhalten Angehörige derselben _nicht_ die Rechte der "Rest der
  Welt".
- Nur der Dateieigentümer und der Administrator können Berechtigungen für eine
  Datei vergeben. Ein Eigentümer kann sich die Rechte auf eine Datei selber
  wegnehmen, sich diese aber später wieder zurückgeben.
- Mit `chmod` können Berechtigungen absolut mit `=` bzw. relativ mit `+` und `-`
  vergeben werden. Es stehen die Angaben `u` (user), `g` (group) und `o`
  (others) zur Verfügung.
    - `chmod u=rw,g=r,o= DATEI` entspricht `chmod 640 DATEI`
    - Mit `--reference DATEI` können die Berechtigung von einer bestehenden
      Datei übernommen werden.
- Der Befehl `umask` zeigt ohne Parameter den aktuellen `umask`-Wert an. Mit
  einem oktalen Argument kann die `umask` gesetzt werden; diese wirkt wie ein
  Sieb, das Rechte von der Einstellung 666 und 777 (für Dateien bzw. Ordner)
  entfernt. Die `umask`-Einstellung wird durch eine Unterschell geerbt. Mit
  `umask -S` kann die aktuelle Einstellung symbolisch angezeigt werden.

#### Spezialberechtigungen

 Für besondere Anwendungsfälle stehen _Spezialberechtigungen_ zur Verfügung, die
 mit einem zusätlichen Präfix gesetzt werden können:

- `1` (z.B. `chmod 1775` bzw. `chmod +t`): _Sticky Bit_: 
    - Kann auf Verzeichnisse angewendet werden. Dadurch genügen
      Schreibrechte auf das Verzeichnis nicht mehr, um Dateien darin zu
      löschen, die anderen Benutzern gehören. (Das ist z.B. für das
      `/tmp`-Verzeichnis sinnvoll, auf das jeder Schreibrechte benötigt, man
      aber nur seine eigenen Dateien löschen können soll.)
- `2` (z.B. `chmod 2775` bzw. `chmod g+s`): _SGID Bit_ für ausführbare Binärdateien
    - Führt das jeweilige Programm mit den Berechtigungen der besitzenden
      Gruppe anstelle des Aufrufers aus.
    - Auf Verzeichnisse hat diese Einstellung keine Wirkung.
- `4` (z.B. `chmod 4775` bzw. `chmod u+s`): _SUID Bit_ für ausführbare Binärdateien
    - Führt das jeweilige Programm mit den Berechtigungen des besitzenden
      Benutzers anstelle des Aufrufers aus. (Dies ist z.B. für den Befehl
      `passwd` sinnvoll, der es _jedem_ Benutzer eingeschränkt erlauben
      muss, die Datei `/etc/shadow` zu bearbeiten. Das Programm muss
      sicherstellen, dass ein Benutzer nur sein eigenes Passwort ändern
      kann.)
    - Kann auf Verzeichnisse angewendet werden, wobei erstellte Dateien in
      diesem Verzeichnis der Besitzergruppe dieses Verzeichnisses gehören
      und nicht der Gruppe des Erstellers. (Dies ist z.B. bei FTP-Servern
      sinnvoll, wo verschiedene Benutzer Dateien hochladen.)

| Berechtigung | Ziel        | Zweck                                     | oktal | symbolisch |
|--------------|-------------|-------------------------------------------|------:|------------|
| Sticky Bit   | Verzeichnis | Löschen nur eigener Dateien               |   `1` | `+t`       |
| SGID Bit     | Binärdatei  | Ausführen mit Besitzerrechten (User)      |   `2` | `g+s`      |
| SGID Bit     | Verzeichnis | Besitz neuer Datei an Verzeichnisbesitzer |   `2` | `g+s`      |
| SUID Bit     | Binärdatei  | Ausführen mit Besitzerrechten (Group)     |   `4` | `u+s`      |

### Dateien finden

Der _Filesystem Hierarchy Standard_ klassifiziert Dateien nach zwei Kriterien:

- Müssen diese lokal vorhanden sein, oder können sie auch remote eingebunden
  werden?
- Werden Schreib- (dynamisch) oder nur Leserechte (statisch) auf diese Dateien
  benötigt?

Mit `find` lassen sich u.a. Datien anhand des Modifikationsdatums finden:

- `-mmin 10`: genau vor zehn Minuten
- `-mmin +10`: vor mindestens zehn Minuten
- `-mmin -10`: vor weniger als zehn Minuten

Regeln lassen sich mit `-a` (and), `-o` (or) und `!` (not) und Klammernpaaren
(mit Escaping: `\( … \)`) verknüpfen.

Die Option `-ok` verhält sich wie `-exec`, fragt aber vor der Ausführung
interaktiv nach.

Mit `whereis` lassen sich Dateien nach Namen finden, wobei z.B. auch
dazugehörige Manpages gefunden werden.

### Kompression

Das Program `tar` arbeitet mit verschiedenen Modi:

- `-c` (create): Archive erstellen
    - Mit `-f` kann eine Zieldatei angegeben werden, andernfalls wird auf die
      Standardausgabe geschrieben.
    - Bei absoluten Pfaden wird das führende `/` immer entfernt.
    - Der Algorithmus kann per Option gewählt werden, wodurch `tar` selbständig
      das passende Programm zur Kompression aufruft:
        - `-Z`: `compress` (veraltet, patentbehaftet)
        - `-z`: `gzip` (frei)
        - `-j`: `bzip2` (starke Kompression)
        - `-x`: `xz` (stark, aber rechenintensiv)
    - Alternativ können Befehle wie `gzip` und `gunzip` bzw. `xz` und `unxz` in
      Kombination mit einer Pipe manuell aufgerufen werden.
- `-x` (extract): Archive entpacken
    - Für die entpackten Daten wird die `umask` angewendet, was mit der Option
      `-p` verhindert werden kann.
- `-t` (table): Archivinnhalt auflisten.

Mit `cpio` können ebenfalls Dateien und Verzeichnisse zu Archiven
zusammengeführt werden.

## Pipelines und Filter

- `set -o noclobber` verhindert das Überschreiben von Dateien bei Umleitungen
  mit `>`.
- Übergibt man `tee` mehrere Dateinamen, wird die Ausgabe in alle Dateien
  umgeleitet.
- Die Anzahl der von `xargs` zu konsumierenden Argumente kann mit dem Parameter
  `-n` gesteuert werden.
- Mit `split` wird eine Datei standardmässig in Teile von 1000 Zeilen
  aufgeteilt. Mit `-l` kann eine alternative Zeilenlänge angegeben werden. Mit
  `-b` wird die Anzahl von Bytes definiert, z.B. Blöcke von 512 Bytes mit dem
  Suffix `b`, Kibibyte und Mebibyte mit dem Suffix `k` bzw. `m`.
- `cat` kann Zeilen mit `-n` nummerieren, Zeilenenden mit `-E` als `$` anzeigen
  und Tabs mit `-t` durch die Zeichenfogle `^I` ersetzten.
- `tac` listet Dateien rückwärts auf.
- Mit `paste` können Dateien zeilenweise kombiniert werden. Mit `-s` erfolgt die
  Kombination spaltenweise.
- Mit `wc -m` können UTF-8 Zeichen gezählt werden.
- Mit `od` können Dateien oktal ausgegeben werden, bzw. mit diversen
  `-t`-Optionen in einer anderen Codierung.

## Reguläre Ausdrücke und Editoren

- Bei der Shell funktioniert die Negierung von Zeichenklassen mittels `[!abc]`,
  bei regulären Ausdrücken mit `[^abc]`.
- Wortgrenzen können mit `\<` und `\>` gematched werden.
- Bei `grep` kann mit `-n` die Zeilennummer mit ausgegeben, mit `-v` die Logik
  des Musters negiert, mit `-c` die Anzahl Matches und mit `-l` (bei mehreren
  Dateien) der Dateiname ausgegeben werden.
- `sed` verfügt u.a. über folgende Kommandos:
    - `p`: print (Ausgabe)
    - `a`: append (Einfügen _nach_ einer Zeile)
    - `i`: insert (Einfügen _vor_ einer Zeile)
    - `y`: Ersetzen einzelner Zeichen
    - `s`: substitute (Ersetzen)
- `sed` verfügt u.a. über folgende Parameter:
    - `-f`: Skriptdatei
    - `-e`: Skript-Literale
    - `-n`: automatisches Ausgeben unterdrücken
- Die Umgebungsvariable `VISUAL` definiert den visuellen Texteditor; mit
  `EDITOR` wird der Zeileneditor gesetzt.
- Bei `vi` wird mit `H`, `L` und `M` zur obersten, zur untersten bzw. zur
  mittleren dargestellten Bildschirmzeile gesprungen. Mit `I` und `A` wird am
  Anfang bzw. am Ende einer Zeile Text eingefügt. Mit `cc` wird die aktuelle
  Zeile gelöscht und in den Einfügemodus gewechselt.
    - Bei ex-Befehlen kann die aktuelle Zeile mit `.` referenziert werden.
    - Die Ausgabe eines Programms kann mit `:r! BEFEHL` eingefügt werden, z.B.
      `:r date` zum Einfügen des aktuellen Datums.
    - Ein Zeilenbereich (z.B. 1 bis 5) kann an einen externen Befehl gesendet
      und durch dessen Ausgabe ersetzt werden, z.B. `1,5 ! sort` zum Sortieren
      der ersten fünf Zeilen.

## Prozesse

- `ps` zeigt mit `-l` mehr Details an. Mit `ps ax` bzw. `ps -e` werden alle
  laufende Prozesse angezeigt. Mit der Option `o` können Felder wie z.B. `uid`,
  `pid` usw. ausgewählt werden. Mit `-C NAME` können Prozesse anhand ihres
  Befehlnamens ermittelt werden.
- Mit `pstree` kann die Prozesshierarchie angezeigt werden; `-p` gibt die
  Prozessnummer und `-u` den Besitzer aus.
- Mit `jobs` aufgelistete Prozesse können mit `bg %N` in den Hintergrund
  verschoben werden, wobei `N` die Jobnummer bezeichnet.
- Mit `nohup` ausgeführte Befehle ignorieren `SIGHUP` und bleiben auch nach dem
  Unterbruch einer Verbindung laufen. Die Ausgabe wird in die Datei `nohup.out`
  geschrieben.
- Die wichtigsten Signale, die mit `kill`, `killall` oder `pkill` an einen
  Prozess gesendet werden können, lauten:
    - `SIGHUP` (1, hang up): Kindprozesse und Terinal beenden
    - `SIGINT` (2, interrupt): Unterbruch (wie Ctrl-C)
    - `SIGKILL` (9, kill): Prozess forciert beenden
    - `SIGTERM` (15, terminate): Prozess beenden
    - `SIGCONT` (18, continue): angehaltenen Prozess fortsetzen
    - `SIGSTOP` (19, stop): Prozess anhalten
    - `SIGSTP` (20, terminal stop): Prozess in den Hintergrund schicken (wie Ctrl-Z)
- Mit `pgrep` können anhand verschiedener Kriterien (z.B. `-u USER`, `-G GROUP`
  usw.) Prozess-IDs gefunden werden.
- Mit `nice` kann die Priorität von Prozessen von -20 (höhere Priorität) bis +19
  (tiefere Priorität) gesetzt werden. (Nur `root` darf negative Werte
  verwenden.) Mit `renice` kann die Priorität eines laufenden Prozesses geändert
  werden. (Nur `root` darf tiefere Werte verwenden, andere Benutzer nur höhere.)
- Mit `watch` kann ein Befehl wiederholt ausgeführt werden. Die Frequenz in
  Sekunden kann mit `-n` angegeben werden. Unterschiede der Ausgabe können mit
  `-d` hervorgehoben werden.

## Hardware

- PCI-Geräte können mit `lspci` aufgelistet werden. Mit `-v` erfolgt eine
  ausführlichere Ausgabe, mit `-t` eine baumartige Ausgabe und mit `-n` werden
  die Gerätecodes ausgegeben.
- Mit `lsusb` (und `-v` für eine ausführlichere Ausgabe) werden USB-Geräte
  aufgelistet.
- Kernel-Module können mit `modprobe MODUL` geladen und mit `modprobe -r MODUL`
  wieder entladen werden. Die Konfiguration für das automatische Laden befindet
  sich in der Datei `/etc/modprobe.conf` und in den Dateien unterhalb des
  Verzeichnisses `/etc/modprobe.d`. Die Module des laufenden Kernels sind in
  `/lib/modules` aufgelistet.
- Das Verzeichnis `/sys` ist ein Pseudodateisystem, welches den Zugriff auf
  Geräte nach Anschlusstyp (`/sys/bus`, `/sys/pci`, `/sys/pci`, `/sys/scsi`)
  bzw allgemein (`/sys/devices`) bietet.
- Mit `udev`, bestehend aus dem Daemon `udevd` und der Bibliothek `namedev`,
  wird das `/dev`-Dateisystem automatisch und dynamisch mit Geräten befüllt
  (hotplugging im laufenden System & coldplugging beim Systemstart). Das Ein-
  und Ausstecken von Geräten wird mit sog. "uevents" behandelt.
- Der alte Hardware-Abstraction Layer (HAL) wurde u.a. durch `udisks` ersetzt,
  welches sich um Speichermedien kümmert. Es besteht aus dem Daemon `udisksd`
  und dem Anwendungsprogramm `udiskctl`). Via D-Bus können Prozesse
  untereinander kommunizieren, z.B. Programme untereinander oder der Kernel mit
  der grafischen Benutzeroberfläche.

## Plattenspeicher

- Die traditionelle Partitionsmethode _Master Boot Record_ (MBR) erlaubt vier
  primäre Partitionen. Eine primäre Partition kann zu einer erweiterten
  Partition gemacht werden, innerhalb welcher mehrere logische Partitionen
  angelegt weden können, was die Obergrenze von 4 Partitionen lockert. Aufgrund
  der 32-Bit-Adressierung sind Partitionen auf eine Grösse 2 TiB begrenzt.
- Die moderne Partitionsmethode _GUID Partition Table_ (GPT) reserviert den
  ersten Sektor aus Kompatibilitätsgründen für den MBR. Die
  Partitionierungsinformationen folgen anschliessend, sowie zusätzlich am Ende
  der Platte. Pro Partition werden 128 Bytes abgespeichert: 16 Bytes für
  die GUID, je 8 Bytes für den Partitionstyp, die Partition, Anfangs- und
  Endblocknummer sowie Attribute, 72 Byte für den Partitionsnamen.
- Die Benennung der Speichergeräte (`/dev/sda1`, `/dev/sda2`) erlaubt maximal 15
  Partitionen pro Gerät. Die Nummerierung erfolgt gemäss der Reihenfolge des
  Erscheinens der Geräte. Alternativ bietet `/dev` die Unterverzeichnisse
  `block`, `disk/by-id`, `disk/by-path`, `disk/by-uuid` und `disk/by-label` mit
  stabileren Zugriffspfaden.
- Ein Swap Space von der Grösse des physischen Arbeitsspeichers ermöglicht einen
  "Tiefschlaf" des Rechners (Hibernate). Wird der Auslagerungsspeicher über
  mehrere Geräte verteilt, kann das System jeweils auf den Swap Space zugreifen,
  dessen Gerät gerade unter geringer Last steht.
- Gängige Partitionierungsprogramme sind `fdisk` (interaktiv), `parted`
  (interaktiv und nicht-interaktiv), `gdisk` (auf GPT ausgelegt, erlaubt
  MBR-Konvertierung, interaktiv/nicht-interaktiv), `cfdisk`
  (bildschirmorientiert), `sfdisk` (nicht-interaktiv, nur für MBR) und `sgdisk`
  (nicht-interaktiv, nur für GPT).
- Zu Beginn eines Dateisystems steht ein Superblock, der Informationen über das
  Dateisystem enthält. Partitionen werden via `mkfs` erstellt, wobei der Wert
  des `-t`-Parameters den Aufruf zu einem entsprechenden Programm delegiert
  (z.B. `mkfs -t ext2` -> `mkfs.ext2`). Integritätsprüfungen erfolgen über das
  Programm `fschk`, welches wiederum Aufrufe anhand des `-t`-Parameters an ein
  entsprechendes Programm delegiert.
- Journaling-Dateisysteme wie `ext3` protokollieren Schreibzugriffe als
  Transaktionen, welche als ganzes erfolgreich sein oder scheitern können. Im
  Fehlerfall kann anhand des Transaktionsprotokolls wieder ein konsistenter
  Zustand erzeugt werden. Ab `ext4` ist das Journal mit Prüfsummen abgesichert.
  Partitionen werden mit `e2fsck` geprüft (Link: `fsck.ext2`).
- Mit `tune2fs` können Partitionsparameter angepasst werden, wobei äusserste
  Vorsicht geboten ist.
- XFS ist ein alternatives Dateisystem von SGI, welches über den Befehl
  `xfs_repair` repariert und mit `xfs_fsr` "aufgeräumt" (defragmentiert) wird.
  Mit `xfs_info` erhält man Informationen zu einem XFS-Dateisystem; mit
  `xfsdump` und `xfsrestore` bzw. mit `xfs_copy` können XFS-Dateisysteme
  gesichert/geladen bzw. kopiert werden, wozu `dd` bei XFS _nicht_ verwendet
  werden sollte! Mit `xfs_db` kann ein Dateisystem inspiziert werden.
- Btrfs ist ein an ZFS angelegtes, modernes Dateisystem, das u.a. einen Logical
  Volume Manager (LVM) unterstützt, Dateien transparent komprimiert,
  Konsistenzprüfungen durchführt und Snapshots erlaubt. Mithilfe von _copy on
  write_ erfolgen diese Snapshots kostenkünstig. Btrfs-Partitionen werden
  mittels `mkfs -t btrfs` angelegt und unterstützen redundante Speicherung über
  ein Software-RAID. Innerhalb eines Btrfs-Dateisystems können Subvolumes
  (`btrfs subvolume create /home`) und Snapshots (`btrfs subvolume snapshot
  /foo/bar /foo/bar-snap`) angelegt werden. Eine Konsistenzprüfung kann mit
  `btrfs scrub start/status/cancel/resume` gestartet, angezeigt, abgebrochen
  bzw. fortgesetzt werden. Die Prüfung des Dateisystems bzw. dessen Korrektur
  erfolgt mit `btrfs check` bzw. `btrfs check --repair`.
- Ein `tmpfs` ist ein Dateisystem, das auf dem Memory liegt.
- VFAT und exFAT eignen sich für externe Datenträger, gerade wenn diese auch auf
  anderen Geräten zum Einsatz kommen (Digitalkameras, USB-Sticks). Die
  exFAT-Dienstprogramme laufen aus Patentgründen im Userspace (FUSE).
- Ein Logical Volume Manager (LVM) erlaubt das Anlegen, Anpassen, Verschieben,
  Vergrössern und Verkleinern von Partitionen im laufenden Betrieb sowie
  geräteübergreifende Partitionen. Ein oder mehrere Geräte (_physical volumes_,
  PV) können zu einer _volume group_ (VG) zusammengefasst werden, woraus
  _logical volumes_ (LV) erstellt werden. Die Verteilung einer Partition auf
  mehrere Platten bezeichnet man als _stripping_; die redundante Speicherung
  eienr Partition auf mehreren Geräten als _mirroring_ (ein limitiertes RAID).
  Sicherheitskopien können über Snapshots erstellt werden.
- Ein- und Aushängevorgänge (`mount`/`umount`) werden in `/etc/mtab`
  protokolliert, was in modernen Systemen ein symbolischer Link auf
  `/proc/self/mounts` darstellt.
- Das automatische Einhängen von Partitionen kann via systemd über Mount-Units
  (`What`: Gerät, `Where`: Einhängepunkt) oder klassisch via `/etc/fstab` mit
  folgenden Spalten erfolgen:
    1. Gerät, z.B. `/dev/sda1` oder `LABEL=...` bzw. `UUID=...`
    2. Einhängepunkt, z.B. `/`, `/var`, `/home`
    3. Dateisystemtyp, z.B. `ext4`, `swap`
    4. Mount-Optionen, z.b. `noexec`
    5. Sicherheitskopien über `dump`: 0
    6. automatische Integriätsprürung: 1 bei `/`, sonst i.d.R. 2
- Die UUID einer Partition kann via `tune2fs -l DEVICE | grep UUID` ermittelt werden.
- Mit `blkid --label=...` bzw. `blkid --uuid=...` kann das Gerät anhand eines
  Labels bzw. einer UUID ermittelt werden.
- Mit `lsblk` können Blockgeräte aufgelistet werden.
- Die Befehle `df` und `du` unterstützen die Parameter `-h` (Zweier-) und `-H`
  (Zehnerpotenz), welche die Grössen menschenlesbar ausgeben.

## Systemstart und Init-System

- Das Init-System kann per `init=`-Kernel-Parameter ausgewählt bzw.
  überschrieben werden. Kernel-Parameter, mit dem der Kernel selber nichts
  anfangen kann, werden an das Init-Programm weitergereicht.
- Die Grub-Konfigurationsdatei `grub.cfg` kann über das Hilfsprogramm
  `grub-mkconfig` erzeugt werden. Nach einem Kernel-Update soll diese mithilfe
  von `update-grub` aktualisiert werden. Eigene Konfigurationsoptionen können in
  `/etc/grub.d/40_custom` definiert werden, welche dann eins zu eins in die
  Grub-Konfiguration übernommen werden.
- Der `init`-Prozess mit der PID 1 kann als einziger nicht mit `kill -9`
  abgeschossen werden.
- System-V-Init arbeitet normalerweise mit den folgenden Runlevels:
    - 1 (oder S): Ein-Benutzer-Modus
    - 2: Mehrbenutzerbetrieb
    - 3: Mehrbenutzerbetrieb mit Netzwerk
    - 4: unbenutzt (für eigene Bedürfnisse nutzbar)
    - 5: Mehrbenutzerbetrieb mit Netzwerk und grafischer Oberfläche
    - 6: Systemneustart
    - 0: Systemhalt
- Upstart arbeitet mit zwei Arten von _Jobs_: _Tasks_ (kurzlebige Aufgaben) und
  _Services_ (dauerhaft "im Hintergrund" laufende Vorgänge). Jobs können mit
  `initctl` gesteuert werden.

## Software- und Paketverwaltung

- `file` angewendet auf ausführbare Dateien zeigt an, ob diese dynamisch oder
  statisch gelinkt ist; `ldd` listet die gelinkten Libraries auf, die vom
  dynamischen Linker `ld-linux.so` bei der Programmausführung nachgeladen
  werden. Die Bibliotheken werden aus einem Index geladen, der mit `ldconfig`
  gemäss der in `/etc/ld.so.conf` aufgeführten sowie in `/lib` und `/usr/lib`
  liegenden Verzeichnis aufgebaut wird. Mit `ldconfig -p` kann der aktuelle
  Zustand von diesem Index angezeigt werden. Soll eine Library für einen
  bestimmten Programmaufruf angegeben werden, kann deren Pfad in der
  Umgebungsvariable `LD_LIBRARY_PATH` gesetzt werden (analog zu `PATH`). Dies
  funktioniert aus Sicherheitsgründen jedoch nicht auf Programmen, die Set-UID
  und Set-GID verwenden, da der unpriviligierte Benutzer ansonsten eine
  manipulierte Library mit höheren Rechten ausführen könnte. Die im Index
  aufgelisteten Major-Versionen (z.B. `libncurses.so.5.4`) verweisen per
  symbolischen Link auf die spezifische Datei, sodass Minor-Versionen (z.B.
  `5.3`) einfach aktualisiert werden können.
- TODO: p. 261-296

## Virtualisierung

- Beim Klonen von virtuellen Maschinen ist darauf zu achten, dass Eigenschaften
  wie die MAC-Adresse, die Systemkennung in `/etc/machine-id` oder der
  SSH-Schlüssel in der kopierten Instanz angepasst werden, damit es nicht zu
  Konflikten kommt.
- Mithilfe von `cloud-init` können virtuelle Maschinen anhand von
  bereitgestellten Metadaten automatisch an die Bedürfnisse der jeweiligen
  Cloud-Umgebung angepasst werden.
