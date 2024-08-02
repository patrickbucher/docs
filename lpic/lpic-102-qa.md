# Shells, Skripte und Datenverwaltung

## (105.1) Die Shell-Umgebung anpassen und verwenden

### In welchen Dateien können Sie Voreinstellugen für die Shell hinterlegen? Wie werden diese gefunden?

Beim Anmelden (lokal oder via SSH) wird der Parameter `-` an die Shell übergeben
(alternativ: `bash -l`), wobei diese zu einer Login-Shell wird.

Eine Login-Shell für zuerst `/etc/profile` aus. Anschliessend wird _nur die
erste_ im `$HOME`-Verzeichnis des jeweiligen Benutzers gefundene der drei
folgenden Dateien ausgeführt:

1. `.bash_profile`
2. `.bash_login`
3. `.profile`

Bei der Abmeldung wird die Datei `.bash_logout` ausgeführt, falls sie existiert.

Wird Bash interaktiv aber nicht als Login-Shell ausgeführt, wird nur die Datei
`$HOME/.bashrc` ausgeführt.

Nicht-interaktive Shells führen beim Start standardmässig keine Skripts aus,
ausser man übergibt ihr per Umgebungsvariable `BASH_ENV` einen entsprechenden
Dateinamen. Bei nicht-interaktiven Shells stehen eigens definierte Funktionen
und Aliase (etwa in `.bashrc`) _nicht_ zur Verfügung!

Oftmals veranlasst die Datei `~/.profile` das Nachladen der Datei `~/.bashrc`,
damit für Login-Shells und interaktive Shells nicht keine doppelten Definitionen
vorgenommen und gepflegt werden müssen:

```bash
test -r ~/.bashrc && . ~/.bashrc
```

Erweiterungen von Variablen wie `$PATH` sollten in `.profile` vorgenommen
werden, damit nicht jede interaktive Untershell diese erneut redundant
verlängert.

Bei der Arbeit mit einer grafischen Oberfläche steht keine Login-Shell zur
Verfügung, die `~/.profile` einlesen würde. Als Alternative steht die Datei
`~/.xsession` zur Verfügung.

Im Verzeichnis `/etc/skel` können Muster-Dateien (z.B. `/etc/skel/.bashrc`)
definiert werden, welche ins `$HOME`-Verzeichnis neu erstellter Benutzer kopiert
werden. Dateien wie `/etc/profile` sollten nicht direkt modifiziert, sondern
mittels einer Datei wie `/etc/profile.local` erweitert werden, damit die
Änderungen beim nächsten Systemupdate nicht verlorengehen.

### Was ist der Unterschied zwischen Shell- und Umgebungsvariablen?

Eine Umgebungsvariable wird an Untershells weitervererbt, während eine
Shell-Variable für Unterprozesse unbekannt bleibt. Mit `export VARIABLE` kann
eine Shell-Variable zu einer Umgebungsvariable gemacht werden; mit `export -n
VARIABLE` wird sie wieder zu einer Shell-Variable, die für Unterprozesse
unsichtbar ist.

Shell-Variablen können mit `set`, Umgebungsvariable mit `env` oder `export`
aufgelistet werden.

Mit `env VARIABLE=WERT PROGRAMM` kann eine Variable nur für einen bestimmten
Programmaufruf überschrieben werden; mit `env -U VARIABLE PROGRAMM` kann die
Zuweisung wieder aufgehoben werden.

### Wie heissen die wichtigsten Variablen für die Shell-Konfiguration?

Die `bash` kennt u.a. folgende nur lesbare vordefinierte Variablen:

- `$?`: Rückgabewert des letzten Befehls
- `$$`: PID der aktuellen Shell
- `$!`: PID des letzten Hintergrundprozesses
- `$#`: Anzahl übergebener Parameter
- `$*`: alle übergebene Parameter in der Form `"$1 $2 $3 …"`
- `$@`: alle übergebene Parameter in der Form `"$1" "$2" "$3" …"`
- `$n`: Parameter `n`, z.B. `$1`, `$2`, `$3` usw. (ab 10: `${10}`)

### Wie können Sie für die Shell die Tastatur umdefinieren?

Auf einem virtuellen Terminal kann das Tastaturlayout mit dem Befehl `loadkeys`
mit `root`-Berechtigungen umgestellt werden:

```bash
# loadkeys en
# loadkeys en us
```

In der grafischen Oberfläche können Tastenzuordnungen mit `xmodmap` umgestellt
werden. Das Programm `xkeycaps` bietet eine grafische Oberfläche hierfür.

In der Datei `~/.inputrc` (benutzerewit) bzw. `/etc/inputrc` (systemweit) können
Einstellungen vorgenommen werden, wie z.B. das Deaktivieren der Glocke oder
Tastenkürzel für bestimmte Readline-Modi:

    set bell-style none

    $if mode=vi
        set keymap vi-command
        Control-l: clear-screen

        set keymap vi-insert
        Control-l: clear-screen
    $endif

### Was sind Shell-Funktionen und wie werden sie erstellt?

Shell-Funktionen erlauben es, Code-Abschnitte wiederverwendbar und unter einem
bestimmten Namen als Befehl ansprechbar zu machen. Funktionen können mittels
`FUNKTIONSNAME () { … }` oder `function FUNKTIONSNAME { … }` Die folgende
Funktion löscht temporäre Dateien, die Älter als sieben Tage sind:

```bash
oldtmpdel () {
    sudo find /tmp/ -type f -mtime +7 -exec rm {} \;
}
```

Dem Befehl mitgegebene Parameter stehen unter den Variablen `$1`, `$2` usw. zur
Verfügung. Die Funktion `bk` sichert die als Parameter angegebene Datei, falls
die Zieldatei nicht schon vorhanden ist:

```bash
function bk {
    if [ -z "$1" ]
    then
        echo "usage: bk FILE"
        return 1
    fi

    new_name="$1.bak"
    if [ -e "$new_name" ]
    then
        echo "target backup file $new_name already exists"
        return 2
    else
        cp "$1" $new_name
    fi
}
```

Definierte Funktionen können mit `declare` aufgelistet werden, `declare -f
FUNKTION` zeigt die Definition der angegebenen Funktion (in einer äquivalenten
Form) an.

## (105.2) Einfache Skripte anpassen und schreiben

TODO: p. 315

### Was ist ein Shell-Skript?

Ein Shell-Skript ist eine Textdatei, welche Shell-Befehle, Kontrollstrukturen,
Funktionen usw. enthält. Alle Befehle und Kontrollstrukturen, die man interaktiv
verwenden kann, lassen sich auch in Shell-Skripten verwenden, sodass sich diese
hervorragend zur Automatisierung manueller Tätigkeiten eignen.

### Wie starten Sie Skripte?

Ein Skript (z.B. `script.sh`) kann direkt über die jeweilige Shell aufgerufen werden:

```bash
$ bash script.sh
```

Ein Skript kann auch ausführbar gemacht und dann ohne expliziten Aufruf der
Shell gestartet werden:

```bash
$ chmod +x script.sh
$ ./script.sh
```

Das Skript sollte hierzu auf der ersten Zeile den absoluten Pfad zum Interpreter
mit einer speziellen Kommentar-Zeile, der _Shebang_, angeben:

```bash
#!/bin/bash
```

Liegt das Skript in einem Verzeichnis, das von `$PATH` referenziert wird (z.B.
`~/bin`, welches sich anzulegen und in `$PATH` aufzunehmen für
benutzerdefinierte Skripte lohnt), kann es direkt unter seinem Dateinamen
aufgerufen werden:

```bash
$ script.sh
```

Die Endung `.sh` ist optional, vermeidet aber Verwechslungen mit eingebauten
Befehlen.

Auf den Rückgabewert eines Skripts oder Befehls kann über die Variable `$?`
des Elternprozesses zugegriffen werden, wobei 0 Erfolg und alle anderen Werte
Misserfolg signalisieren. Der Befehl `test`  bietet eine Vielzahl von
Möglichkeiten, diesen Rückgabewert auszuwerten.

In Shell-Skripten wird `test` unter dem Alias `[` angesprochen, welches durch
eine schliessende Klammern am Ende des Aufrufs ergänzt wird:

```bash
test $x -gt 7
[ $x -gt 7 ]
```

### Was sind wichtige Kontrollstrukturen in Shell-Skripten?

Befehle können mit den logischen Operatoren `&&` und `||` verkettet werden:

```bash
mkdir foo && touch foo/bar.txt
stat qux || mkdir qux
```

Im ersten Fall wird die Datei `foo/bar.txt` nur angelegt, wenn das Erzeugen von
`foo` funktioniert hat. Im zweiten Fall wird `qux` nur angelegt, wenn es nicht
bereits existiert.

Mit `;` auf einer Zeile verkettete Befehle werden als Sequenz ausgeführt.

Mit dem Konstrukt `if`/`then`/`else`/`fi` lassen sich Fallunterscheidungen
formulieren:

```bash
if [ -d foobar ]
then
    chmod 750 foobar
else
    mkdir foobar
fi
```

Mit dem `while`/`do`/`done`-Konstrukt können Befehle wiederholt ausgeführt
werden, solange eine Bedingung zutrifft:

```bash
i=$1
n=$2
while [ $i -le $2 ]
do
    echo $i
    i=$(( $i+1 ))
done
```

Mit dem `for`/`do`/`done`-Konstrukt kann über die Werte einer Liste iteriert
werden:

```bash
for i in {1..10}
do
    echo $i
done
```

Sequenzen können mit dem Befehl `seq` erzeugt werden. Wird keine Liste
angegeben, erfolgt die Iteration über die Parameter `$1`, `$2` usw.

Wird ein Befehl mithilfe von `exec` aufgerufen, wird der aktuelle Prozess für
die Ausführung dieses Befehls wiederverwendet:

```bash
$ echo $$
21578

$ bash
$ echo $$
21582

$ exec bash
$ echo $$
21582
```
