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
