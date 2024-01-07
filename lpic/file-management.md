# Lektion 1

[Quelle](https://learning.lpi.org/de/learning-materials/101-500/103/103.3/103.3_01/)

- `touch`
    - `-a`: Zugriffszeit
    - `-m`: Änderungszeit
- `mv`, `rm`
    - `-i`: interaktiv (Bestätigung bei existierenden Dateien)
- `rmdir`: entfernen _leerer_ Verzeichnisse
- `ls`
    - `-R`: rekursive Auflistung
- Glob-Pattern
    - `*`: beliebige Anzahl beliebiger Zeichen
    - `?`: beliebiges Zeichen
    - `[]`: Listen und Bereiche von Zeichen
        - `[aeiou]`: Vokale
        - `[A-Z]`: Grossbuchstaben

# Lektion 2

[Quelle](https://learning.lpi.org/de/learning-materials/101-500/103/103.3/103.3_02/)

- `find`
    - `-type`
        - `l`: symbolischer Link
    - `-iname`: wie `-name` (ignore case)
    - `-not`: Negierung
    - `-maxdepth N`: Verzeichnistiefe N
    - `-mtime D`: in Tagen
    - `-size`
        - `100M`: genau 100 MB
        - `+2G`: grösser als 2 GB
        - `-1M`: kleiner als 1 MB
    - `-print`: Ausgabe (trotz Verwndung von `-exec`)
    - `-delete`: Löschen
- `tar`
    - `--create`/`-c`: Archiv erstellen
    - `--extract`/`-e`: Archiv extrahieren
        - `-C`: Zielverzeichnis angeben
    - `--list`/`-l`: Archivinhalte auflisten
    - `--file ARCHIVE`/`-f ARCHIVE`: Archiv angeben
    - Kompression
        - `-z`: GZIP (schneller)
        - `-j`: BZIP2 (kompakter)
- `cpio`: Dateien aus/in Archiv kopieren
    - `ls *.jpg | cpio -o > jpegs.tar`
        - `-o`: Kompression ("output")
    - `cpio -id < jpegs.tar`
        - `-i`: Extraktion ("input")
        - `-d`: Zielordner (bei Bedarf) erstellen
- `dd`
    - `conv=`: Konvertierung (z.B. `ucase`)
    - `status=progress`: Fortschritt anzeigen
