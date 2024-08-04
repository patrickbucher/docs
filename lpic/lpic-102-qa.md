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

```bash
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

```bash
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

## (107.1) Benutzer-und Gruppenkonten und dazugehörige Systemdateien verwalten

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

### Wie ist der Zugriff auf `at` und `cron` geregelt?

### Wie sehen `crontab`-Dateien aus?

### Wofür ist das Programm `crontab` gut? Warum wird es gebraucht?

### Wie funktionieren systemd-Timer-Units?

## (107.3) Lokalisierung und Internationalisierung

### Welche Zeichencodierungen gibt es und wie unterscheiden sie sich?

### Wie können Sie Dateien in andere Zeichencodierungen konvertieren?

### Wie wird eine Linux-Sitzung an einen Kulturkreis angepasst?

### Wie funktionieren Zeitzonen in Linux?
