# systemd

Der Startvorgang eines Betriebssystems wird von einem `init`-Programm
gesteuert, der immre die Prozess-ID (PID) 1 hat. Das traditionelle
`init`-Programm der Unix-artigen Betriebssysteme (u.a. verschiedene
Linux-Distributionen und BSD-Derivate) heisst SysV-`init` ("System five init"),
da es von der fünften Ausgabe des ursprünglichen Unix-Betriebssystems aus den
1970er-Jahren stammt.

Dieses System startet alle Prozesse streng _sequenziell_ in einer mittels
Prioritätsnummer festgelegten Reihenfolge. Diese Prozesse werden mithilfe von
Shell-Skripten gestartet, welche teilweise sehr umfangreich sind und nicht
immer einheitlich geschrieben werden. Für die Steuerung dieser Skripte gibt es
zudem verschiedene Werkzeuge, die auf verschiedenen Distributionen (z.B. Debian
oder Red Hat) zum Einsatz kommen.

Das traditionelle `init` basiert auf sog. _Runlevels_ (zu Deutsch etwa:
"Ausführungsstufen"), wie z.B. Systemstart, Rettungsmodus, Einbenutzerbetrieb
(mit und ohne Netzwerk), Mehrbenutzerbetrieb und grafische Oberfläche. Zu jedem
Übergang von einem Runlevel zu einem anderen gibt es eine Reihe von Prozessen,
die aufgestartet oder beendet werden müssen. (Vom Übergang vom
Mehrbenutzerbetrieb auf die grafische Oberfläche muss u.a. ein grafischer
Login-Manager gestartet werden.) Leider sind diese Runlevels nicht einheitlich
über die verschiedenen Distributionen hinweg festgelegt.

Das streng sequenzielle Aufstarten von Prozessen in einer zuvor festgelegten
Reihenfolge ist relativ langsam. Gerade auf Systemen mit mehreren
Prozessorkernen werden freie Rechenkapazitäten schlecht ausgenutzt, wodurch
sich der Systemstart unnötig verlangsamt.

Aus diesen Gründen -- umständliche und uneinheitliche Konfiguration und
Bedienung, langsame Startzeiten -- wurden Alternativen zu SysV-`init`
entwickelt: Zuerst `upstart`, das von Canonical für Ubuntu Linux entwickelt
worden ist -- sich aber nicht durchsetzen konnte. Später dann `systemd` von Red
Hat, welches heute unter den Linux-Distributionen das am häufigsten eingesetzte
`init`-System ist.

## Konfigurations- und Binärdateien

Die `systemd`-Konfigurationsdateien sind in `/etc/systemd` abgelegt. Das
Vorhandensein einer Konfigurationsdatei für eine bestimmte Komponente bedeutet
jedoch nicht, dass diese auch tatsächlich in Gebrauch ist. Die Datei
`/etc/systemd/system.conf` enthält die grundlegende Konfiguration von
`systemd`. Die Einstellungen sind standardmässig auskommentiert. Hierbei handelt
es sich um die Standardwerte, die in `systemd` hineinkompiliert worden sind.

Mit dem Präfix `system-` findet man zu verschiedenen Konfigurationsdateien eine
Manpage, z.B. `systemd-system.conf` für die Konfigurationsdatei
`/etc/systemd/system.conf`:

    $ man systemd-system.conf

Die meisten Binärdaten der `systemd`-Programme befinden sich im Verzeichnis
`/lib/systemd/`. Von `/bin` bzw. `/usr/bin` aus gibt es symbolische Links
("symlinks", d.h. Verknüpfungen) zu den Programmen in `/lib/systemd`.

Die aktuelle gelade Konfiguration kann mit folgendem Befehl angezeigt werden:

    $ systemctl show

Einzelne Einstellugen können mithilfe der `--property`-Option angezeigt werden:

    $ systemctl show --property=LogLevel
    LogLevel=info

## Units

`systemd` fasst Services, Sockets usw. unter einem gemeinsamen Konzept namens
_Units_ zusammen. Zu jeder Unit gibt es ein _Unit File_. Die vom System
vorgegebenen Unit Files befinden sich um Verzeichnis `/lib/systemd/system`.
Diese können von den Unit Files im Verzeichnis `/etc/systemd/system`
überschrieben werden.

Grundlegende Informationen über Units sind in der Manpage `systemd.unit` zu
finden. Zu den verschiedenen Arten von Units gibt es separate Manpages, etwa
`systemd.service` zu den Service-Units:

    $ man systemd.unit
    $ man systemd.service

Ein Unit File wird per Konvention mit der Dateiendung abgespeichert, die den Art
der Unit bezeichnet. Dies sind:

- `service`: zur Konfiguration von Diensten (Services)
- `socket`: zur Kommunikation von Services untereinander und zum automatischen
  Aktivieren eines Services per Verbindungsanfrage
- `slice`: zur Konfiguration sogenannter `cgroups` (Beschränkung von Ressourcen)
- `mount` und `automount`: zum Einhängen von Dateisystemen
- `target`: zur Gruppierung von Units beim Systemstart
- `timer`: zur Konfiguration von Jobs, die zu bestimmten Zeitpunkten ausgelöst
  werden (als Alternative zu Cronjobs)
- `path`: zur Aktivierung von Services basierend auf dem Zustand des
  Dateisystems (z.B. starten eines Services, wenn eine Datei verändert worden
  ist)
- `swap`: zur Information über sogenannte Swap-Partitionen (Auslagerung von
  Arbeitsspeicher auf das Dateisystem)

### Informationen über Units

Eines der wichtigsten Programme von `systemd` ist `systemctl`. Mithilfe des
`list-units`-Befehls können die verschiedenen Units aufgelistet werden. Der
Befehl `list-unit-files` zeig die Unit Files an:

    $ systemctl list-units
    $ systemctl list-unit-files

Inaktive Units werden standardmässig nicht angezeigt und können mithilfe des
`--all`-Flags eingeblendet werden:

    $ systemctl list-units --all

Die Art der Units (siehe Liste oben) Kann mit der Option `-t` gefiltert werden:

    $ systemctl list-units -t service
    $ systemctl list-units -t socket

Weiter kann mithilfe der `--state`-Option auf den Zustand der Unit eingeschränkt
werden:

    $ systemctl list-units --state=active
    $ systemctl list-units --state=dead

Mit `--state=help` werden die möglichen Stati aufgelistet:

    $ systemctl list-units --state=help

Am wichtigsten sind die Stati `active` (der Service läuft) und `inactive` (der
Servie läuft nicht).

Auch zu den Unit Files gibt es verschiedene Zustände:

    $ systemctl list-unit-files --state=help

Am wichtigsten sind die Stati `enabled` (der Service wird automatisch gestartet)
und `disabled` (der Service muss bei Bedarf manuell gestartet werden).

Die Befehle `is-active` und `is-enabled` zeigen an, ob ein Service aktiv oder inaktiv
bzw. ob er automatisch oder manuell gestartet wird:

    $ systemctl is-enabled ntpd.service
    $ systemctl is-active  ntpd.service

### Direktiven

Jede Unit besteht aus einer Reihe von _Direktiven_. Diese sind in der
Manpage `systemd.directives(7)` aufgelistet. Zu jeder Direktive ist eine
weiterführende Manpage aufgelistet; z.B. wird für die Direktive `ExecStart` auf
die Manpage `systemd.service(5)` verwiesen, weil diese Direktive für
Service-Units von Belang ist.

### Service Units

Eine minimale Konfigurationsdatei für eine Service-Unit sieht folgendermassen
aus:

```
[Unit]
Description=prints "Hello, World" repeatedly

[Service]
ExecStart=/usr/local/bin/hello-loop

[Install]
WantedBy=multi-user.target
```

Die Unit besteht aus drei Bereichen:

- `[Unit]`: Allgemeine Einstellungen über die Unit. Diese
  Konfigurationseinstellungen können unabhängig von der Art der Unit gesetzt
  werden.
- `[Service]`: Spezifische Einstellungen für eine Service-Unit.
- `[Install]`: Informationen, wie die Unit installiert werden soll.

Informationen über die einzelnen Abschnitte finden sich in der Manpage
`systemd.unit(5)`.

Die einzelnen Direktiven haben die folgende Bedeutung:

- `Description`: Diese Zeichenkette soll den Zweck der Unit kurz und prägnant
  beschreiben. Diese Zeile wird von `systemctl status [unit]` angezeigt.
- `ExecStart`: Der Befehl zur Ausführung des Service-Programms.
- `WantedBy`: Das Target, das die vorliegende Unit aktivieren soll.
  (Vergleichbar mit einem Runlevel.)

Häufig sind im `[Unit]`-Abschnitt auch folgende Direktiven gesetzt:

- `Documentation`: Ein Verweis auf die Dokumentation zur Unit, oftmals eine URL
  oder der Verweis auf eine Manpage.
- `After`: Eine Reihe von Targets, die aktiviert sein müssen, damit die
  vorliegende Unit aktiviert werden kann.

Der `[Service]`-Abschnitt bietet eine Vielzahl von Einstellungsmöglichkeiten,
wovon hier einige der wichtigsten erläutert werden:

- `Type`: Steuert, wie der Prozess gestartet werden soll. Hierfür gibt es u.a.
  folgende Möglichkeiten:
    - `simple` (Standard): Sobald der durch `ExecStart` definierte Prozess
      gestartet worden ist, gilt der Service als laufend. (Es wird davon
      ausgegangen, dass es sich beim gestarteten Prozess um den Hauptprozess des
      Services handelt.) Die Ausführung (`systemctl start`) gilt auch dann als
      Erfolgreich, wenn etwa die unter `ExecStart` angegebene Binärdatei _nicht_
      gefunden wird.
    - `exec`: Vergleichbar mit `simple`, mit einigen Unterschieden; so gilt die
      Ausführung nur als erfolgreich, wenn der Prozess gestartet werden konnte.
    - `notify`: Vergleichbar mit `exec`, doch es wird gewartet, bis der
      gestartete Prozess den Erfolg seines Starts mit `sd_notify(3)` (o.ä.)
      zurückmeldet.
    - `forking`: Es wird davon ausgegangen, dass der durch `ExecStart`
      gestartete Prozess selbst einen Fork erzeugt, und der Elternprozess sich
      dann selbst beendet. Diese Einstellung sollte im Zusammenhang mit der
      Direktive `PIDFile` verwendet werden, damit `systemd` den Elternprozess
      identifizieren kann.

# Quellen

- Donald A. Tevault: _Linux Service Management Made Easy with systemd_. (Packt
  Publishing, 2022)
