# Zugriffsberechtigungen

Details zu Verzeichnis anzeigen:

    $ ls -ld DIRECTORY

Dateitypen (erste Spalte):

- `-`: normale Datei
- `d`: Verzeichnis
- `l`: symbolischer Link
- `b`: Blockgerät (z.B. Disk)
- `c`: Zeichengerät (z.B. TTY)
- `s`: Socket

Ausführungsberechtigungen genügen zum Ausführen einer Datei, es braucht hierzu
keine Leseberechtigungen! (Das enthaltene Verzeichnis muss dem jeweiligen
Benutzer jedoch Ausführungsberechtigungen geben.)

- `chmod`: Zugriffsberechtigungen ändern
    - symbolischer Modus: `chmod o+rwx,g+rx,o-rwx /usr/local/bin/foo`
        - `u`: Besitzer, `g`: Gruppe, `o`: Rest, `a`: alle
        - `+`: hinzufügen, `-`: entfernen, `=`: setzen
        - `r`: lesen, `w`: schreiben, `x`: ausführen
    - oktaler Modus: `chmod 750 /usr/local/bin/foo`
        - Reihenfolge: Besitzer, Gruppe, Rest
        - `r`: 4, `w`: 2, `x`: 1
    - `-R`: rekursiver Modus
- `chown`: Besitzer (und Gruppe) ändern
- `chgrp`: Gruppe ändern
- `getent`: Einträge anzeigen lassen
    - `getent group`: Gruppen anzeigen
- `groups`: Gruppen eines Benutzers anzeigen lassen
- `groupmens`: Benutzer einer Grupe auflisten
    - `# group -g GROUP -l`
- `umask`: Maske anzeigen und ändern
    - `umask -S`: symbolischer Modus
    - `umask u=rwx,g=rwx,o=rwx`: Standardberechtigungen auf 755 setzen

Spezielle Berechtigungen:

- 1: Sticky Bit für Verzeichnisse
    - Flag `t` statt `x` auf "other"-Berechtigung
    - Benutzer kann nur als Besitzer in einem Verzeichnis Dateien entfernen/umbenennen.
    - `chmod 1755`: setzt Sticky Bit und Berechtigungen 755
- 2: SetGID: Set Group ID
    - Flag `s` statt `x` auf Gruppenberechtigung
    - bei Dateien: Programm wird mit Berechtigungen der Besitzergruppe ausgeführt
    - bei Verzeichnissen: Einträge (Dateien, Verzeichnisse) erben die Benutzergruppe
- 4: SetUID: Set User ID
    - Flag `s` statt `x` auf Benutzer-Berechtigungen
    - gilt nur für Dateien
    - Prozess wird mit Berechtigungen des Besitzers der Datei gestartet
