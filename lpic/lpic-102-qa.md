# Shells und Skripte

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

```
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

### Was ist ein Shell-Skript?

Ein Shell-Skript ist eine Textdatei, welche Shell-Befehle, Kontrollstrukturen,
Funktionen usw. enthält. Alle Befehle und Kontrollstrukturen, die man interaktiv
verwenden kann, lassen sich auch in Shell-Skripten verwenden, sodass sich diese
hervorragend zur Automatisierung manueller Tätigkeiten eignen.

### Wie starten Sie Skripte?

Ein Skript (z.B. `script.sh`) kann direkt über die jeweilige Shell aufgerufen werden:

```
$ bash script.sh
```

Ein Skript kann auch ausführbar gemacht und dann ohne expliziten Aufruf der
Shell gestartet werden:

```
$ chmod +x script.sh
$ ./script.sh
```

Das Skript sollte hierzu auf der ersten Zeile den absoluten Pfad zum Interpreter
mit einer speziellen Kommentar-Zeile, der _Shebang_, angeben:

```
#!/bin/bash
```

Liegt das Skript in einem Verzeichnis, das von `$PATH` referenziert wird (z.B.
`~/bin`, welches sich anzulegen und in `$PATH` aufzunehmen für
benutzerdefinierte Skripte lohnt), kann es direkt unter seinem Dateinamen
aufgerufen werden:

```
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

```
$ echo $$
21578

$ bash
$ echo $$
21582

$ exec bash
$ echo $$
21582
```

# Oberflächen und Desktops

## (106.1) X11 installieren und konfigurieren

### Was ist ein X-Server? Ein X-Client?

Ein X-Server ist ein Dienst, der auf einem Arbeitsplatzrechner mit
Peripherie-Hardware (Ein- und Ausgabegeräten) läuft.

Ein X-Client ist ein Anwendungsprogramm, das auf dem gleichen oder auf einem
entfernten Rechner läuft.

X-Server und -Client tauschen Grafikbefehle (Zeichnen von Linien, Textzeichen)
und Ereignisse (Tastendrücke, Mausbewegungen) über das X-Protokoll aus, welches
lokal über eine Unix-Domain-Socket-Verbindung läuft bzw. über TCP/IP bei einer
Verbindung zu einem entfernten Server auf Port 6000.

### Gibt es unter Linux «Grafikkartentreiber»?

Ja, es gibt Kernel-Treiber für Grafikchips und einen Treiber für X.org für die
Konfiguration der Grafikausgabe.

### Was ist Wayland?

Da X11 keine 3D-Grafik unterstützt, lässt es Anwendungen ihre 3D-Darstellungen
selber berechnen und zeichen, wozu es dem jeweiligen Client Arbeitsspeicher auf
der Grafikkarte zur Verfügung stellt. Der _Compositor_ ist ein spezieller
X11-Client, der sich darum kümmert, dass die Ausgaben verschiedener Clients in
der richtigen Reihenfolge dargestellt werden.

Wayland ist ein Protokoll zur Kommunikation zwischen dem Compositor und dem
Kernel. Wayland-Clients zeichnen ihre Grafikinhalte selber und benachrichtigen
den Compositor über neue Inhalte.

X11-Clients können mit einem X11-Server namens XWayland kommunizieren, der
Clients per Wayland rendert, um X11-Grafikprimitiven verwenden zu können.
Moderne Grafik-Toolkits (GTK, Qt) unterstützen Wayland direkt.

### Wozu dient die Umgebungsvariable `DISPLAY`?

Die Umgebungsvariable `DISPLAY` enthält eine Referenz auf einen Server inkl.
Displaynamen und bezeichnet den X-Server, mit dem ein X-Client kommuniziert. Es
können auf einem Rechner mehrere X-Server laufen, und verschiedene X-Clients
können verschiedene X-Server verwenden, aber jeweils nur auf einen.

Bei einem lokal laufenden X-Server hat `DISPLAY` den Wert `:0`.; bei einem
entfernten X-Server geht diesem Displaynamen eine Domain voraus (z.B.
`host.domain.com:0`). Mehrere Bildschirme können mit `:0.0`, `:0.1` usw.
angesprochen werden. Alternativ unterstützen X-Clients die Option `-display`,
der entsprechende Referenzen auf den X-Server mitgegeben werden können. (Dank
Xinerama werden mehrere Bildschirme wie ein einziger grosser Bildschirm
verwaltet.)

### Wie halten Sie andere lokale Benutzer von Ihrer Grafiksitzung fern?

Mit `xhost` kann rechnerbasierter Zugriff auf einzelne Hosts erlaubt (+) bzw.
verboten (-) werden:

```
$ xhost +good.domain.com # Erlaubnis
$ xhost good2.domain.com # Erlaubnis
$ xhost -evil.domain.com # Verwehrung
```

Da `xhost` _allen_ Benutzern des jeweiligen Hosts Zugriff gewährt, sollte es
nicht eingesetzt werden.

Bei `xauth` wird beim Start beim Start des X-Servers ein Cookie erzeugt und in
der Datei `~/.Xauthority` des angemeldeten Benutzers abgelegt, worauf nur dieser
Zugriff hat. Der Server akzeptiert nur Verbindungen von Servern, die diesen
Cookie vorweisen können.

Über die Option `-nolisten tcp` werden TCP-Verbindungen zum X-Server nicht
erlaubt, was heutzutage bei vielen Distributionen standardmässig so
voreingestellt ist.

### Wie können Sie ein auf einem anderen entfernten Rechner laufendes Programm lokal X11-Grafik anzeigen lassen?

Das standardmässig unverschlüsselte X-Protokoll wird über SSH per _X11
Forwarding_ per verschlüsselter Verbindung angeboten. X11 Forwarding wird mit
dem Flag `-X` (restriktiver) bzw. `-Y` (weniger restriktiv) aufgebaut:

```
$ ssh -X host.domain.com
$ ssh -Y host.domain.com
```

## (106.2) Grafische Arbeitsumgebungen

### Was sind die wichtigsten grafischen Arbeitsplatzumgebungen?

Die wichtigsten Umgebungen sind GNOME (basierend auf GTK) und KDE (basierend auf
Qt). Schlankere Umgebungen sind Xfce, LXDE und LXQt. Die Cinnamon-Umgebung ist
ähnlich zur grafischen Benutzeroberfläche von Windows. MATE basiert auf einer
älteren Version von GNOME. Gemeinsame Standards werden vom
Freedesktop.org-Projekt gesetzt.

### Was ist XDMCP? VNC? SPICE?

- XDMCP: Das _X Display Manager Control Protocol_ dient dazu, dass ein
  Terminal-Client, auf dem selber kein X-Server läuft, eine Textkonsole auf
  einem entfernten X-Server ausführen kann (heutzutage ungebräuchlich).
- VNC: Mit _Virtual Network Computing_ kann ein Fernzugriff über verschiedene
  Rechnerplattformen hinweg bewerkstelligt werden, mittlerweile auch
  verschlüsselt oder als read-only-Verbindung. Hierbei werden nicht
  Render-Anweisungen sondern direkt Bildschirminhalte übertragen.
- SPICE: Das _Simple Protocol for Independent Computing Environments_ wurde zur
  grafischen Kommunikation mit virtuellen Maschinen erschaffen. Es arbeitet
  hybrid, d.h. unterstützt die Übertragung von Render-Anweisungen als auch
  von Bildschirminhalten (mit Optimierungen).

## (106.3) Hilfen für Behinderte

### Welche Hilfsmittel gibt es bei der Tastatureingabe?

- Klebende Tasten (_sticky keys_) erlauben das Eingeben von Tastenkombinationen
  als Sequenz anstelle gleichzeitiger Tastendrücke, was die Bedienung mit einem
  Stock ermöglicht.
- Langsame Tasten (_slow keys_) lassen das System versehentliche (kurze)
  Tastendrücke ignorieren.
- Zurückschnellende Tasten (_bounce keys_) lassen das System überzählige
  Betätigungen derselben Taste ignorieren.
- Wiederholungstasten (_repeat keys_) erlauben es einzustellen, ob eine
  lang gedrückte Taste als ein Tastendruck oder als mehrere Tastendrücke
  behandelt werden sollen.
- Maustasten (_mouse keys_) lassen die Maus über den numerischen Tastaturblock
  steuern.

Diese Hilfsmittel können über die XKEYBOARD-Erweiterung und das
Konfigurationsprogramm `xkbset` aktiviert und konfiguriert werden. Grafische
Benutzeroberflächen bieten hierzu zusätzliche Werkzeuge (Stichwort
"Zugangshilfen").

Bildschirmtastaturprogramme (GOK für GNOME, XVKBD usw.) zeigen eine Tastatur an,
die sich per Maus bedienen lässt.

### Wie können Grafikoberflächen für Sehbehinderte angepasst werden?

- Mauszeiger können angepasst werden (Grösse, Design) damit diese besser
  sichtbar werden.
- Die Schriftgrösse lässt sich umstellen (erhöhen).
- Der Kontrast kann durch spezielle Farbschemas erhöht werden.
- Bildschirmlupen (z.B. KMagnifier für KDE) erlauben das Vergrössern einzelner
  Bildschirmausschnitte.
- Sprachausgabe und Braille-Zeilen erlauben Blinden das Anhören bzw. Ertasten
  textueller Ausgaben.
- Spracherkennung und -steuerung steckt unter Linux noch in den Kinderschuhen
  und ist v.a. auf Englisch und Chinesisch verfügbar.

# Administrative Aufgaben

## (107.1) Benutzer- und Gruppenkonten und dazugehörige Systemdateien verwalten

### Wie und wo werden Kennwörter gespeichert?

Kennwörter für Benutzer werden in `/etc/shadow` gespeichert. Für (heute eher
ungebräuchliche) Gruppenkennwörter gibt es die Datei `/etc/gshadow`. Zwar
verfügen die Dateien `/etc/passwd` (Benuterkonti) und `/etc/group` (Gruppen)
auch über ein Kennwortfeld, dieses enthält aber unter Linux nicht das Kennwort,
sondern den Wert `x` als Verweis auf die entsprechende Shadow-Datei.

### Was bedeuten die Einträge in `/etc/passwd` und `/etc/shadow`?

In der Datei `/etc/passwd` steht jede Zeile für einen Benutzer gemäss der
folgenden Form:

    Benutzername:Kennwort:UID:GID:GECOS:Heim-Verzeichnis:Login-Shell

Die Felder haben die folgende Bedeutung:

- Benutzername (Pflicht): Der eindeutige, textuelle Benutzernamen des Benutzers.
- Kennwort: Der Wert `x` als Hinweis, dass das verschlüsselte Kennwort in
  `/etc/shadow` abgelegt ist.
- UID (Pflicht): Die eindeutige, numerische Identifikation des Benutzers (0:
  `root`, 0-99: Systembenutzer, 100-499: für Softwarepakete, ab 1000: echte
  Benutzer)
- GID (Pflicht): Die numerische Identifikation der primären Gruppe des Benutzers
- GECOS: Eine komma-separierte Liste von zusätzlichen Informationen über den
  Benutzer: u.a. Vollname, Zimmer- & Telefonnummer. (Die Bezeichnung stammt vom
  Hersteller GECOS, dessen Geräte in den Bell Labs verwendet wurden.)
- Heim-Verzeichnis (Pflicht): Der absolute Pfad zum Heim-Verzeichnis des
  Benutzers, in dem er sich nach dem Login befindet (z.B. `/home/patrick`).
- Login-Shell: Der absolute Pfad zum Shell-Programm, das nach dem Login
  gestartet wird (z.B. `/bin/bash`). Verfügbare Shells sind in `/etc/shells`
  aufgelistet. Soll der Benutzer keinen Shell-Zugang haben, können Programme wie
  `/bin/true` oder `/usr/bin/nologin` verwendet werden.

In der Datei `/etc/shadow` steht jede Zeile für ein Benutzerpasswort gemäss der
folgenden Form:

    Benutzername:Kennwort:Änderung:Min:Max:Warnung:Frist:Sperre:Reserviert

Die Felder haben die folgende Bedeutung:

- Benutzername: siehe oben (`/etc/passwd`)
- Kennwort: Das verschlüsselte (genauer: gehashte) Kennwort des Benutzers. Ist
  das Feld leer, kann sich der Benutzer ohne Kennwort einloggen. Ein `*` oder
  `!` bedeutet, dass sich der Benutzer nicht einloggen kann (gesperrter
  Benutzer).
- Änderung: Das Datum der letzten Kennwortänderung in Tagen seit dem 01.01.1970.
- Min: Mindestanzahl Tage, nach denen ein Kennwort erneut geändert werden kann.
- Max: Höchstanzahl Tage, innert denen ein Kennwort geändert werden muss.
- Warnung: Anzahl Tage vor der Max-Frist, an denen der Benutzer eine Warnung zum
  Zurücksetzen seines Kennworts erhält.
- Frist: Anzahl Tage nach dem Ablauf der Max-Frist, nach denen der Benutzer nach
  verpasster Kennwortänderung gesperrt wird.
- Sperre: Datum, an dem das Konto definitiv gesperrt wird in Tagen seit dem
  01.01.1970.

### Wie würden Sie die UID eines Benutzers ändern?

Das Editieren der Benutzerinformationen in der Datei `/etc/passwd` ist
fehleranfällig, weswegen besser der Befehl `usermod` verwendet werden sollte.

Die UID eines Benutzers kann folgendermassen geändert werden, wozu der
betreffende Benutzer ausgeloggt sein muss:

    # usermod -u NEUE-UID BENUTZERNAME
    # usermod --uid NEUE-UID BENUTZERNAME

### Wozu dient `vipw`?

Das Programm `vipw` dient zum Editieren der Datei `/etc/passwd`, welche hierzu
geschützt wird, damit niemand anderes diese Datei gleichzeitig mit `vipw`
bearbeiten kann. Der aufzurufende Texteditor wird anhand der Umgebungsvariablen
`VISUAL` und `EDITOR` bestimmt; sind diese nicht gesetzt, wird `vi` verwendet.

## (107.2) Systemadministrationsaufgaben durch Einplanen von Jobs automatisieren

### Wozu dient `at`? `cron`?

#### `at`

Mit `at` lassen sich Kommandozeilenbefehle _einmalig_ an einem bestimmten
Zeitpunkt in der Zukunft ausführen:

```
$ at 20:11
> systemd-cat echo 'Hello, at!'
> [Ctrl]-[D]
```

Die Zeit kann um relative (z.B. `today` oder `tomorrow`) oder absolute
Datumsangaben (z.B. `August 10`, `10.08.2024`, `2024-08-10` oder `08/10/2024`)
ergänzt werden:

Wird die Uhrzeit weggelassen, gilt die aktuelle Uhrzeit am jeweiligen Datum.

```
$ at 20:15 tomorrow
> systemd-cat echo 'Good evening, at!'
> [Ctrl]-[D]
```

Zeitangaben können auch relativ angegeben werden, z.B. als `now + 3 hours` oder
`noon + 2 days` (erlaubte Einheiten: `minutes`, `hours`, `days`, `weeks`).

Sollen die Befehle nicht interaktiv eingegeben sondern aus einer Datei gelesen
werden, kann hierzu die Option `-f SKRIPT` verwendet werden.

Die Befehle werden mit der Umgebung ausgeführt, in welcher `at` ursprünglich
instruiert worden ist.

Zu `at` gibt es eine Reihe von Hilfsprogrammen:

- `atd`: _at daemon_; Verwaltung und Aufstarten der Aufträge im Hintergrund
- `atq`: Inspektion der Aufträge in der Warteschlange
- `atrm`: Aufträge anhand derer Nummer stornieren
- `batch`: Verwaltung von Aufträgen _ohne_ Zeitangabe, die baldmöglichst
  ausgeführt werden sollen (d.h. sobald genügend Systemressourcen dafür zur
  Verfügung stehen)

Die Aufträge liegen im Verzeichnis `/var/spool/atjobs`. Die Ausgaben der
Aufträge werden im Verzeichnis `/var/spool/atspool` zwischengespeichert.

#### `cron`

Mit `cron` lassen sich Kommandozeilenbefehle _mehrmals_ zu wiederkehrenden
Zeiten ausführen.

### Wie ist der Zugriff auf `at` und `cron` geregelt?

Für `at` gibt es zwei Dateien zur Zugangskontrolle, in welcher Benutzer
aufgelistet werden:

1. `/etc/at.allow`: Die aufgelisteten Benutzer dürfen Aufträge einreichen.
2. `/etc/at.deny`: Die aufgelisteten Benutzer dürfen _keine_ Aufträge einreichen.

Existiert die erste Datei nicht, sind alle Benutzer berechtigt, die _nicht_ in
der zweiten Datei stehen. Ist die erste Datei leer, dürfen _alle_ Benutzer
Aufträge einreichen.

Bei `cron` gibt es analog dazu die Dateien `/etc/cron.allow` und
`/etc/cron.deny`.

### Wie sehen `crontab`-Dateien aus?

Die Aufträge sind pro Benutzer im Verzeichnis `/var/spool/cron` abgelegt, z.B.
`var/spool/cron/patrick`. Diese `crontab`-Dateien sind folgendermassen
aufgebaut:

- Jede Zeile steht für eine wiederkehrende Aufgabe (bzw. für eine
  Kommentarzeile, wenn diese mit `#` beginnt).
- Es gibt sechs Spalten, fünf für die Zeitangabe und eine für den Befehl:
    1. Minute (0-59)
    2. Stunde (0-23)
    3. Tag im Monat (1-31)
    4. Monat (1-12 bzw. englischer Name)
    5. Wochentag (0-7, wobei 0 und 7 für den Sonntag stehen bzw. englischer Name)
    6. der auszuführende Befehl, der mit `/bin/sh` bzw. der `SHELL`
       referenzierten Shell ausgeführt wird

Die systemweite Datei `/etc/crontab` darf nur durch den Administrator geändert
werden und hat eine zusätzliche Spalte für den auszuführenden Benutzer vor der
Befehlsspalte.

Es kann entweder der Tag im Monat (Spalte 3) oder der Wochentag (Spalte 5)
definiert werden; ist eine Zeitangabe unerheblich, gibt man `*` an. Es können
auch Listen (`0,30`), Bereiche (`3-5`) Kombinationen davon (`1,3,5-10`) oder
Schrittweiten (`*/10`) angegeben werden. Monats- und Wochentage können mit den
jeweils ersten drei Buchstaben abgekürzt werden (`jan`, `feb`, `mar`, … bzw.
`mon`, `tue`, `wed`, …)

Beispiele:

    # täglich um 20:15 Uhr
    15 20 * * * echo "Movie Prime-Time"

    # alle fünf Minuten
    */5 * * * * echo "fünf Minuten sind um"

    # wochentags vor Mitternacht
    59 23 * * 1-5 echo "ein Werktag ist vorbei"

    # Adventskalender
    0 8 1-24 12 * echo "es weihnachtet gar sehr"

Oben an einer `crontab`-Datei können die folgenden Umgebungsvariablen gesetzt
werden:

- `SHELL`: Shell zur Ausführung der Befehle (absoluter Pfad; standardmässig
  `/bin/sh`)
- `LOGNAME`: Name des Benutzers aus `/etc/passwd` (kann nicht geändert werden)
- `HOME`: Arbeitsverzeichnis für Befehle (standardmässig das Home-Verzeichnis
  aus `/etc/passwd`)
- `MAILTO`: Nachrichtenempfänger der Befehlsausgaben; `""` damit keine
  Nachrichten verschickt werden

Weitere Aufgaben können in `/etc/cron.d` definiert werden. In
`/etc/cron.hourly`, `/etc/cron.weekly` usw. können Skripte zur periodischen
Ausführung abgelegt werden. Die Aufgabenliste wird einmal pro Minute auf
Änderungen der genannten Dateien geprüft.

### Wofür ist das Programm `crontab` gut? Warum wird es gebraucht?

Die `crontab`-Datei wird sinnvollerweise mit dem Programm `crontab` editiert:

    $ crontab -e

Dadurch wird die jeweilige `crontab`-Datei des Benutzers im bevorzugten
Texteditor (`VISUAL`/`EDITOR`) geöffnet, vorher gesichert und beim Verlassen des
Texteditors automatisch installiert.

Weitere Parameter von `crontab` sind u.a.:

- `-T PFAD`: syntaktische Validierung der angegebenen `crontab`-Datei
- `-l`: Auflistung der jeweiligen `crontab`-Datei
- `-r`: Entfernung der jeweiligen `crontab`-Datei
- `-u BENUTZER`: Verwendung der `crontab`-Datei eines anderen Benutzers (v.a.
  durch die Benutzung von `root` sinnvoll); kann z.B. mit `-l`, `-r` und `-e`
  kombiniert werden

### Wie funktionieren systemd-Timer-Units?

Systemd kombiniert die Funktionen von `at` und `cron` und erlaubt die Ausführung
von Service-Units wie z.B. der folgenden (`/etc/systemd/system/hello.service`):

```ini
[Unit]
Description=demonstrate timer units

[Service]
Type=oneshot
ExecStart=systemd-cat -t hello echo "Hello from systemd timer"
User=patrick
Group=patrick
```

Wird eine dazugehörige Timer-Unit definiert (`hello.timer`), startet diese
standardmässig die dazugehörige Service-Unit (`hello.service`). Der
auszuführende Service kann jedoch mit der Einstellung `Unit=` überschrieben
werden.

Timer-Units müssen nach ihrer Definition aktiviert und gestartet werden:

```
# systemctl daemon-reload
# systemctl enable --now hello.timer
```

Die Unit-Datei kann folgendermassen überprüft werden, wozu der Daemon _nicht_
neu geladen werden muss (das Programm arbeitet direkt auf der Datei):

```
$ systemd-analyze verify hello.timer
```

#### Einmalige Ausführung (analog `at`)

Einmalige Ereignisse (analog zu `at`) werden mithilfe der Ausführungszeit
`OnActivateSec=` definiert:

```ini
[Timer]
OnActiveSec=1m

[Install]
WantedBy=multi-user.target
```

Die Zeitangabe (hier `1m` für "eine Minute") kann auf verschiedene Weisen
erfolgen. Ob ein Wert gültig ist, und wie er interpretiert wird, lässt sich am
besten mit `systemd-analyze timespan ZEITANGABE` überprüfen:

```
$ systemd-analyze timespan "2d1h45m20m5s"
Original: 2d1h45m20m5s
      μs: 180305000000
   Human: 2d 2h 5min 5s
```

Die Zeiten werden aufaddiert, sodass `45m` und `20m` als eine Stunde und fünf
Minuten interpretiert werden.

Mit `OnBoot=` kann die Zeitspanne ab dem Systemstart angegeben werden.

#### Periodische Ausführung (analog `cron`)

Mehrmalige Ereignisse (analog zu `cron`) werden mithilfe der Kalenderangabe
`OnCalendar=` definiert:

```ini
[Timer]
OnCalendar=minutely

[Install]
WantedBy=multi-user.target
```

Die Kalender-Angaben können mit `systemd-analyze calendar` überprüft werden:

```
$ systemd-analyze calendar "2024-*-01 08:00"
  Original form: 2024-*-01 08:00
Normalized form: 2024-*-01 08:00:00
    Next elapse: Sun 2024-09-01 08:00:00 CEST
       (in UTC): Sun 2024-09-01 06:00:00 UTC
       From now: 3 weeks 5 days left
```

Hier einige Beispiele:

- `*-12-1..24 08:00`: Vom 1. bis 24. Dezember jeweils um 8 Uhr morgens.
- `Fri 17:00`: Jeweils freitags um 17 Uhr.
- `Mon..Fri 23:59`: wochentags vor Mitternacht
- `*:00/5`: alle fünf Minuten

Hierbei gibt es folgende Regeln zu beachten:

- Der Wochentag ist optional; wird er angegeben, muss er zum Datum passen.
- Datum und Uhrzeit sind optional; standardmässig gilt `00:00:00`.
- Die Zeitzone ist optional; standardmässig gilt die aktuell eingestellte
  Zeitzone.
- Komplizierte Regeln können mit mehreren `OnCalendar=`-Regeln modelliert
  werden, die dann alle gelten.

#### Startgenauigkeit und -Verzögerung

Systemd versucht die Ausführung von Services zu bündeln, weshalb Timer-Units
nicht sofort, sondern innerhalb eines Aktivierungsfensters `AccuracySec=`
gestartet wird (standardmässig innerhalb einer Minute: `1m`).

Möchte man sicherstellen, dass nicht alle Timer-Units gleichzeitig getriggert
werden, kann man mit `RandomizedDelaySec=` ein maximales Wartefenster definiert
werden, innerhalb dessen eine zufällige Zeitspanne abgewartet wird.

### Aktivierung ohne Timer-Unit

Mithilfe `systemd-run` können einzelne Kommandos ohne die vorherige Definition
einer Timer-Unit definiert werden:

```
# systemd-run --on-active=10s \
    --timer-property=AccuracySec=1s \
    --timer-property=RandomizedDelaySec=5s \
    systemd-cat -t hello echo 'Hello, once.'

# systemd-run --on-calendar='*:00/1' \
    --timer-property=AccuracySec=1s \
    --timer-property=RandomizedDelaySec=5s \
    systemd-cat -t hello echo 'Hello, again.'
```

Für die Angaben `OnActive=` bzw. `OnCalendar=` stehen die entsprechenden
Optionen `--on-active=` und `--on-calendar=` zur Verfügung. Die weiteren
Eigenschaften für die Timer-Unit werden mittels `--timer-property=KEY=VALUE`
bzw. für die Service-Unit mittels `--property=KEY=VALUE` angegeben.

Mittels `systemd-run` gestartete Units sind nur temporär vorhanden. Die
Funktionsweise von `at` kann dadurch abgedeckt werden; als `cron`-Ersatz taugt
`systemd-run` zum Experimentieren, benötigt aber für den produktiven Betrieb
Timer-Unit-Dateien.

## (107.3) Lokalisierung und Internationalisierung

### Welche Zeichencodierungen gibt es und wie unterscheiden sie sich?

ISO 10646 ist eine Untermenge von Unicode; ersteres definiert eine
Zeichentabelle, letzteres auch Aspekte wie Sortierung, Normalisierung und
bidirektionales Schreiben (etwa für Arabisch und Hebräisch). Der Standard
definiert Codepunkte, insgesamt 1.1 Mio., wovon die ersten 65'536 (die _basic
multilingual plane_ BMP) weit verbreitet sind.

Für die Darstellung dieser Zeichen gibt es verschiedene Codierungen:

- **UCS-2** codiert jeden Codepunkt mit zwei Bytes, d.h. kann nur die 65'536
  Zeichen der BMP codieren. Für ASCII-Zeichen, die sich auch mit einem Byte
  darstellen liessen, ist das eine Platzverschwendung. (UTF-16 ist eine
  Abwandlung von UCS-2, die mehr Zeichen codieren kann.)
- **UTF-8** kann den kompletten Unicode-Zeichensatz codieren, wofür je nach
  Zeichen 1-4 Bytes verwendet werden. Zeichen der Zeichensätze ASCII ISO-8859-1
  (latin-1) werden mit einem Byte codiert, wodurch UTF-8 zu ASCII
  vorwärtskompatibel ist. UTF-8 ist effizienter, einfacher und robuster als
  UTF-16, im Gegensatz zu welchem es keine _Byte Order Marks_ (BOM) verwendet.

UTF-8 hat sich auf Linux-Systemen weitgehend durchgesetzt.

### Wie können Sie Dateien in andere Zeichencodierungen konvertieren?

Mit `iconv` kann eine Datei oder ein Datenstrom von einer Ausgangscodierung
(`-f`/`--from-code`) in eine Zielcodierung (`-t`/`--to-code`) umgewandelt
werden:

```
$ iconv -f UTF-8 -t ISO-8859-1 -o out.txt in.txt
$ iconv --from-code=UTF-8 --to-code=ISO-8859-1 --output=out.txt in.txt
```

Wird keine Eingabedatei angegeben, liest das Programm von der Standardeingabe.
Wird die Ausgabedatei weggelassen, wird das Ergebnis auf die Standardausgabe
geschrieben.

Enthält die Eingabe Zeichen, die in der Zielkodierung nicht dargestellt werden
können, wird ein Fehler ausgegeben:

```
$ echo 'äöü' | iconv -f UTF-8 -t ASCII
iconv: illegal input sequence at position 0
$ echo $?
1
```

Zum Umgang mit solchen Zeilen kann der Codierung eines der folgenden beide
Suffixe mitgegeben werden:

- `//TRANSLIT`: das Zeichen wird als Umschreibung ausgegeben.
- `//IGNORE`: das Zeichen wird in der Ausgabe weggelassen.

Mit `-c` werden nicht kodierbare Zeichen kommentarlos ignoriert.

```
$ echo 'Döner' | iconv -f UTF-8 -t ASCII//TRANSLIT
Doner
$ echo $?
0

$ echo 'Döner' | iconv -f UTF-8 -t ASCII//IGNORE
Dner
iconv: illegal input sequence at position 7
$ echo $?
1

$ echo 'Döner' | iconv -f UTF-8 -t ASCII -c
Dner
$ echo $?
0
```

Eine Liste der unterstützten Codierungen erhält man mittels Parameter
`-l`/`--list`.

### Wie wird eine Linux-Sitzung an einen Kulturkreis angepasst?

Die Sprache einer Sitzung wird mit der Umgebungsvariable `LANG` spezifiziert und
an Unterprozesse vererbt. Erlaubte Werte von `LANG` setzen sich folgendermassen
zusammen:

- zwingend: Sprachcode (ISO 639)
- optional (nach einem `_`): Ländercode (ISO 3166)
- optional (nach einem `.`): Zeichencodierung
- optional (nach einem `@`): Variante

Mögliche Beispiele sind:

- `de` (nur Sprachcode)
- `de_CH` (Sprach- und Ländercode)
- `de_CH.UTF-8` (Sprach-, Ländercode und Codierung)
- `de_DE@euro` (Sprach-, Ländercode und Variante)

Durch `LANG` wird nicht nur die Sprachausgabe sondern auch u.a. die
Datumsausgabe, die Zahlenformatierung oder die Sortierreihenfolge von Zeichen
beeinflusst. Beispiel mit dem Datum 01.01.1970 (Timestamp 0):

```
$ LANG=de_CH.UTF-8 date +'%d. %B %Y' --date '@0'
01. Januar 1970
$ LANG=en_US date +'%d. %B %Y' --date '@0'
01. January 1970
$ LANG=ru_RU.UTF-8 date +'%d. %B %Y' --date '@0'
01. января 1970
```

Programme, die GNU-gettext verwenden, beachten die Umgebungsvariable `LANGUAGE`,
die als Präferenzliste fungiert und mehrere durch `:` getrennte Angaben erlaubt:

    LANGUAGE=de_CH.UTF-8:de_DE:UTF-8:de_AT.UTF-8:en_US.UTF-8

Um einzelne Aspekte der Lokalisierung feingranularer einstellen zu können,
stehen verschiedene Umgebungsvariablen mit dem Präfix `LC_` zur Verfügung, z.B.:

- `LC_CTYPE`: Zeichenklassifizierungen, Gross- und Kleinschreibung
- `LC_MONETARY`: Formatierung von Geldbeträgen
- `LC_TIME`: Formatierung von Datums- und Zeitangaben
- `LC_ALL`: alle Einstellungen

Die aktuell geltenden Einstellungen können mit dem Befehl `locale` ausgegeben
werden. Einzelne Einstellungen können im Detail betrachtet werden:

```
$ locale -k LC_PAPER
height=279
width=216
paper-codeset="UTF-8"
```

Mit `locale -a` können alle verfügbaren Einstellungen ausgegeben werden. Der
Wert `C` sollte in jedem Fall existieren und kann verwendet werden um
sicherzustellen, dass die Ausgabe einheitlich erfolgt (z.B. bei `ls -l`, das
u.a. das Änderungsdatum der Dateien ausgibt).

Die verschiedenen Variablen werden nach folgenden Regeln ausgewertet:

1. Ist `LC_ALL` gesetzt, gilt dessen Wert.
2. Ist `LC_ALL` _nicht_ gesetzt, gilt die jeweilige `LC_`-Variable für den
   Anwendungsbereich.
3. Ist weder `LC_ALL` noch die passende `LC_`-Variable gesetzt, gilt der Wert
   von `LANG`.
4. Ist keine der genannten Variablen gesetzt, wird ein Standardwert des
   jeweiligen Programms verwendet.

### Wie funktionieren Zeitzonen in Linux?

Wie bei der Sprache ist auch die Zeitzone ein prozessweiter Wert, der an
Unterprozesse weitervererbt wird. Die Zeitzone ist in `/etc/timezone` definiert

Zeitzonen sind in `/usr/share/zoneinfo` definiert, z.B.
in der Datei `/usr/share/zoneinfo/Europe/Zurich` für die Zeitzone, die in der
Schweiz verwendet wird.

Es gibt zwei Dateien, über welche die aktuell gültige Zeitzone gesetzt werden
kann:

1. `/etc/localtime`: indem ein symbolischer Link zu einer Datei in oben
   genannten Verzeichnis gesetzt, oder indem die entsprechende Datei kopiert
   wird.
2. `/etc/timezone`: indem ein Wert wie `Europe/Zurich` (relative Pfade innerhalb
   von `/usr/share/zoneinfo`) in die Datei eingetragen wird.

Auf Prozessebene kann die Zeitzone über die Variable `TZ` eingestellt werden
(als Name einer Zeitzone, oder als Offset):

```
$ TZ=Asia/Tokyo date
Wed Aug  7 04:29:19 AM JST 2024
$ TZ=America/New_York date
Tue Aug  6 03:29:41 PM EDT 2024

$ TZ=UTC date
Tue Aug  6 07:30:55 PM UTC 2024
$ TZ=CET-2 date
Tue Aug  6 09:31:32 PM CET 2024
```

# Grundlegende Systemdienste

## (108.1) Die Systemzeit verwalten

### Wie stellt Linux die Zeit dar?

Die Kernel-Uhr zählt die Zeit in fortlaufenden Sekunden seit dem 01.01.1970 um
00:00 Uhr UTC.

### Was ist die CMOS-Uhr und wie benutzt Linux sie?

Beim Systemstart liest der Linux-Kernel die Zeit aus der CMOS-Uhr vom BIOS,
welche mit `hwclock` ausgelesen werden kann:

```
# hwclock
2024-08-05 08:47:06.514425+02:00
```

### Wie könne Sie die Uhr stellen?

Die aktuelle Kernelzeit kann mit `date` ausgelesen und im Format
`MMDDhhmmYYYY.ss` gesetzt werden; mit der Option `-u` wird die Zeit als UTC
interpretiert:

```
$ date
Mon Aug  5 08:51:18 AM CEST 2024
$ date -u
Mon Aug  5 06:51:18 AM UTC 2024
# date 080508512024.18
```

Die Systemzeit kann auf die CMOS-Uhr geschrieben werden ("system to hardware
clock"):

```
# hwclock --systohc
```

Die Systemzeit kann von der CMOS-Uhr übernommen werden ("hardware clock to
system"):

```
# hwclock --hctosys
```

### Was tut NTP ud wofür ist es nötig?

Um plötzliche Zeitsprünge zu vermeiden und die Ungenauigkeiten der CMOS-Uhr zu
umgehen empfiehlt sich die Synchronisation mittels _Network Time Protocol_
(NTP) über den `ntpd`-Daemon, der über die Datei `/etc/ntp.conf` konfiguriert
wird:

```
server 0.pool.ntp.org
server 1.pool.ntp.org
server 2.pool.ntp.org
server 3.pool.ntp.org

driftfile /var/lib/ntp/ntp.drift
```

Mit `ntpdate SERVER` kann die Systemzeit vom angegebenen Server übernommen
werden. Die Option `-q` zeigt die empfangene Zeit an ohne sie zu setzen.

Im _Driftfile_ werden systematische Abweichungen von der CMOS-Uhr gespeichert,
sodass beim Systemstart eine relativ genaue Systemzeit angenommen werden kann,
bevor ein Abgleich per NTP stattfindet.

In einem grösseren Netzwerk lohnt es sich, interne Zeitserver zu betreiben, die
ihre Zeit dann wiederum mit einem öffentlichen NTP-Server synchronisieren.

### Was ist der NTP-Pool?

Der NTP-Pool ist eine Reihe öffentlicher Zeitserver, die nicht direkt über die
IP-Adresse eines konkreten Systems, sondern über eine Pool-Adresse angesprochen
werden. Die einzelnen Servers, die zu einem Pool gehören, werden im
"Ringelreihen"-Verfahren abwechslungsweise verwendet. Dadurch gleicht sich die
Last zwischen den Servern besser aus.

### Was ist Chrony?

Chrony (mit dem `chronyd`-Daemon, der Konfigurationsdatei `/etc/chrony.conf` und
dem Steuerprogramm `chronyc`) ist eine Alternative zu `ntpd`, welche auch als
Zeitserver agieren kann.

### Wie können Sie mit `timedatectl` die Zeitsynchronisierung aktivieren?

Systemd kann die Systemzeit mit dem NTP-Client `systemd-timesyncd` und dem
Kommando `timedatectl` verwalten:

- Aktivierung: `# timedatectl set-ntp true`
- Statusprüfung: `# timedatectl timesync-status`

## (108.2) Systemprotokollierung

### Wozu dient `rsyslogd`?

Hintergrundprozesse haben kein Terminal für Ausgaben angehängt und benötigen
einen anderen Mechanismus zum Festhalten von Meldungen. Der Syslog-Daemon
`rsyslogd` bietet eine Schnittstelle, damit solche Prozesse ihre Meldungen
abliefern können. Die Meldungen können in Dateien gespeichert oder übers
Netzwerk an ein anderes System weitergeleitet werden und dienen zur späteren
Fehlersuche und -analyse. Dies funktioniert folgendermassen:

- _Quellen_ leiten _Nachrichten_ an _Regelsätze_ weiter.
- Ein _Regelsatz_ besteht aus beliebig vielen _Regeln_.
- Jede Regel besteht aus einem _Filter_ und aus einer _Aktionsliste_.
- Ein Filter entscheidet darüber, ob für eine eingehende Meldung eine Aktion
  ausgeführt werden soll.
- Für jede Nachricht werden alle Regeln im Regelsatz sequenziell
  abgearbeitet.
- Eine Aktionsliste besteht aus einer oder mehreren Aktionen, die bestimmen, was
  mit der jeweiligen Meldung geschieht.
- Die Ausgabe der Meldung lässt sich per _Templates_ (Vorlagen) steuern.

Die Konfiguration erfolgt in der Datei `/etc/rsyslog.conf` auf drei mögliche
Arten:

1. in der traditionellen Syntax vom Vorgänger `sysklogd`
2. in einer veralteten Syntax ("legacy rsyslog"), wobei Befehle mit `$` beginnen
3. in der aktuellen Syntax ("RainerScript"), die am mächtigsten ist

Meldungen können _synchron_ (sinnvoll bei kritischen Nachrichten) oder
_asynchron_ in eine Datei, auf ein Gerät (z.B. `/dev/tty0`), über eine _benannte
Pipe_, direkt auf ein Benutzer-Terminal oder per UDP bzw. TCP übers Netzwerk
weitergeleitet werden, wobei TCP nicht vom offiziellen Syslog-Protokoll sondern
nur von der Implementierung `rsyslog` unterstützt wird.

### Wo erscheinen Protokollmeldungen von `su`?

Diese Meldungen erscheinen in der Datei `/var/log/auth.log`, zumindest unter
Debian GNU/Linux.

### Wie unterscheiden Syslog und Syslog-NG sich von `rsyslogd`?

- `syslogd` ist der Vorgänger von Rsyslog und unter BSD-Systemen verbreitet.  Es
  wird in der Datei `/etc/syslog.conf` konfiguriert, wobei nur einer Untermenge
  der Konfigurationsmöglichkeiten von `rsyslogd` zur Verfügung stehen. Mittels
  `klogd` und `imklog` können auch Kernel-Meldungen entgegengenommen und
  verarbeitet werden.
- Syslog-NG ("New Generation") ist ein Nachfolger vom alten Syslog und bietet
  ähnliche Möglichkeiten wie Rsyslog. Das ausführbare Programm heisst
  `syslog-ng` und wird unter `/etc/syslog-ng/syslog-ng.conf` konfiguriert.

### Was macht `logrotate` und wie wird es konfiguriert?

Mithilfe von `logrotate` werden Logdateien periodisch auf bestimmte Kriterien
(z.B. Grösse) überwacht und bei Bedarf gekürzt, wobei alte Meldungen gelöscht
oder archiviert werden. `logrotate` ist kein Daemon, sondern wird über einen
Cronjob regelmässig ausgeführt. Es wird über `/etc/logrotate.conf` und die
Dateien in `/etc/logrotate.d/` konfiguriert

### Wie können Sie den Protokolldienst testen?

Mit dem Programm `logger` können Syslog-Meldungen auf der Kommandozeile erstellt
werden. Es werden verschiedene Optionen wie `-p` für die Priorität oder `-t` für
einen _Tag_ unterstützt:

```
$ logger -p local0.err -t TEST "Hello, World!"
```

### Was ist «das Journal» und wie unterscheidet es sich vom traditionellen Systemprotokollmechanismus?

Das systemd-Journal erlaubt es Programmen, ihre Meldungen auf die
Standardfehlerausgabe zu schreiben, worauf diese eingesammelt und festgehalten
werden. Das Journal ist eine binäre Datenbank und lässt sich nach verschiedenen
Kriterien filtern. (Diese Kriterien müssen nicht selber Teil der Meldung
sondern können auch Metadaten sein.) Meldungen werden in `/var/log/journal`
abgelegt, sofern dieses Verzeichnis existiert; ansonsten werden sie temporär in
`/run/log/journal` gesammelt.

Das Journal wird in `/etc/systemd/journald.conf` konfiguriert
(Grössenbeschränkung, Rotationsregeln usw.) und kann mit dem Programm
`journalctl` abgefragt und bearbeitet werden. Der Aufrufer bekommt nur die
Meldungen zu sehen, für die er Berechtigt ist: `root` sieht alle Meldungen,
andere Benutzer sehen nur eine Untermenge davon. Die Ausgabe kann nach
systemd-Unit (mit `-u UNIT`), nach Priorität (`-p`) oder vielen weiteren
Kriterien wie einem Zeitfenster (`-since`/`-until`) eingeschränkt werden. Mit
`--output=verbose` werden auch die (sehr umfassenden) Metadaten zu jeder Meldung
angezeigt. Die Filterung kann auch direkt nach diesen Metadaten-Feldern
erfolgen, wie z.B. mittels `_PID=3121` oder `_SYSTEMD_UNIT=nginx.service`

### Was tut `systemd-cat`?

Das Programm `systemd-cat` nimmt für das systemd-Journal die Rolle ein, die
`logger` für Rsyslog hat. Es kann mit Prioritäten und Tags arbeiten:

```
$ systemd-cat -t foobar -p info echo 'Hello, World!'
```

Meldungen lassen sich nach dem Tag filtern:

```
$ journalctl -f -t foobar
```

## (108.3) Grundlagen von Mal Transfer Agents (MTAs)

### Wozu dient ein MTA?

E-Mail-Systeme bestehen aus drei verschiedenartigen Komponenten:

- **MTA**: Ein _Mail Transfer Agent_ kann E-Mails empfangen und weiterleiten.
  (z.B. Sendmail, Exim, Postfix, Qmail)
    - Ein MTA verwendet das SMTP-Protokoll (TCP-Port 25), worüber er mit anderen
      MTAs übers Internet kommuniziert und als Daemon im Hintergrund fungiert.
    - E-Mails von lokalen MUAs leitet er direkt an lokale Benutzer bzw. via SMTP
      an andere zuständige MTAs weiter.
    - _Sendmail_ ist alt, komplex zu konfigurieren und hat eine lange Geschichte
      von Sicherheitslücken. Wie auch bei _Exim_ läuft der komplette MTA als ein
      einziger Prozess, was sicherheitstechnisch problematisch ist.
    - _Postfix_ teilt die MTA-Funktionalität auf mehrere Prozesse auf, die mit
      minimalen Rechten laufen und über wohldefinierte Schnittstellen
      untereinander kommunizieren.
- **MUA**: Ein _Mail User Agent_ dient dem Endbenutzer zum Lesen, Schreiben und
  Verwalten von E-Mails. (z.B. KMail, Mutt, Outlook)
    - Ein MUA benötigt einen MTA, damit die E-Mails befördert werden können.
- **MDA**: Ein _Mail Delivery Agent_ schreibt E-Mails in die Postfächer von
  Empfängern und leitet diese bei Bedarf weiter.

E-Mails an lokale Benutzer landen in deren Postfächer unter `/var/mail`, wo
jeder Benutzer über eine Datei entsprechend seinem Benutzernamen verfügt (z.B.
`/var/mail/patrick`). Neue Nachrichten werden unten an die Datei angehängt. Als
Alternativformat bieten Postfix und Exim _Maildir_, das die E-Mails in einer
Verzeichnisstruktur verwaltet und so etwa eine Auslagerung in die
Home-Verzeichnisse der Benutzer ermöglicht.

### Wie können Sie systemweite und benutzerbezogene Mail-Weiterleitung konfigurieren?

Sollen E-Mails an lokale Empfänger _nicht_ in `/var/mail` landen, gibt es
verschiedene WeiterleitungsmÖglichkeiten:

Systemweit kann die Datei `/etc/aliases` bzw. `/etc/mail/aliases` mit folgenden
Regeln ausgestattet werden:

```
root:   joe
joe:    \joe, joe@acme.org
```

1. E-Mails an `root` werden an den Benutzer `joe` weitergeleitet, da `root` aus
   Sicherheitsgründen nicht selber E-Mails lesen sollte.
2. E-Mails an `joe` werden einerseits lokal an die Mailbox von `joe`
   eingereicht, andererseits aber auch an seine E-Mail-Adresse `joe@acme.org`
   weitergeleitet. (Mit dem `\` vor `joe` wird eine Endlosschleife unterbunden.)

Es können auch andersartige Regeln formuliert werden:

```
mike:   /tmp/mikes-mail.txt
robert: "!/usr/local/bin/robmail --foo --bar"
dudes:  :include:/var/lib/everybody.txt
```

1. E-Mails an `mike` werden der Datei `/tmp/mikes-mail.txt` angehängt.
2. E-Mails an `robert` werden an das angegebene Programm per Standardeingabe
   durchgegeben, was sicherheitstechnisch problematisch sein kann.
3. E-Mails an `dudes` werden anhand der Regeln in der Datei
   `/var/lib/everybody.txt` verarbeitet, was etwa bei Mailinglisten sinnvoll
   sein kann.

MUAs arbeiten nicht direkt mit `/etc/aliases`, sondern kompilieren diese Regeln
in ein schneller lesbares Binärformat mit dem Programm `newaliases` bzw.
zusätzlich `postalias` bei Postfix.

Auf Benutzerebene können den rechten Teil solcher Regeln auch in der Datei
`~/.forward` definieren, etwa für die automatische Beantwortung von E-Mails
mittels `vacation`-Programm:

```
\joe, "|/usr/bin/vacation joe"
```

### Wie können Sie die Mail-Warteschlange verwalten?

Nachrichten, die nicht sofort versendet werden, landen in einer Queue:
`/var/spool/mqueue` (Sendmail), `/var/spool/postfix` (Postfix) und
`/var/spool/exim` (Exim). Diese kann mittels `mailq` abgefragt werden; bei
Sendmail auch mit `sendmail -bp`. Dies kann mittels `sendmail -bd -q30m` in
einem periodischen Abstand von 30 Minuten automatisch erledigt werden. Mit
`sendmail -q` wird die Warteschlange sofort abgearbeitet.

## (108.4) Drucker und Drockvorgänge verwalten

# Netz-Grundlagen

## (109.1) Grundlagen von Internet-Protokollen

## (109.2) Dauerhafte Netz-Konfiguration

## (109.3) Grundlegende Netz-Fehlersuche

## (109.4) Clientseitiges DNS konfigurieren

# Sicherheit

## (110.1) Administrationsaufgaben für Sicherheit durchführen

## (110.2) Einen Rechner absichern

## (110.3) Daten durch Verschlüsselung schützen
