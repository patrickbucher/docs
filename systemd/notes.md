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
