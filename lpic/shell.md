# Lektion 1

- `hash -d`: auf Arch nicht vorhanden
- `history`: vergangene Befehle auflisten

# Lektion 2

- `export`: Variablen in Kind-Shells verfügbar machen
- `unset`: Variablen löschen
- `set`: listet alle Variablen _und_ Funktionen auf
- `env`: listet nur exportierte Variablen auf

Beispiel:

```
$ vorname=Hansruedi
$ nachname=Meyerhans
$ export nachname

$ set | grep vorname
vorname=Hansruedi
$ env | grep vorname

$ set | grep nachname
nachname=Meyerhans
$ env | grep nachname
nachname=Meyerhans
```

# Lektion 3

- `bzcat`: `cat` für BZIP2-komprimierte Daten
- `xzcat`: `cat` für XZ-komprimierte Daten
- `zcat`: `cat` für GZIP-komprimierte Daten
- `nl`: Zeilen durchnummerieren
- `od -x`: hexadezimale Ausgabe
- `od -c`: Ausgabe der Bytes (characters)
