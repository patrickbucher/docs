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
