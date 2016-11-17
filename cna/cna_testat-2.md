# CNA: 2. Testatprüfung

## Was macht ein Betriebssystem (BS) ?
Betriebssysteme realisieren eine Softwareschicht zwischen Anwendungen und Hardware, die sich mit der Verwaltung der Hardwarekomponenten beschäftigt und für die Anwendungen einfachere Schnittstellen bereitstellt.

## Was sind die Nachteile, wenn ein Rechner ohne Betriebssystem benutzt wird?
Komplizierter zum Programmieren, man muss die Hardware kennen, Eingeschränkte Wiederverwendbarkeit, Portierbarkeit, Ressourcen müssen selber verwaltete werden

## Was sind die Vorteile, wenn ein Rechner ohne BS benutzt wird?
Schlankeres System, Vollständige Kontrolle, Bessere Performance, keine Kosten, keine Updates, keine Viren

## Welche Möglichkeiten hat das BS auf IO-Geräte zu reagieren?
* Polling (Busy Waiting)
* Interrupts
* DMA (Direct Memory Access)

## Beschreiben Sie die Hauptaufgaben eines BS?
Ressourcenmanagement, Benutzerverwaltung, Prozessmanagement, IO-Management, Filesystemverwaltung

## Welche Aufgabe erfüllt eine MMU?
Memory Management Unit (MMU), Umsetzung der virtuellen und physikalischen Adressen, Speicherschutzverwaltung

## Worin unterscheiden sich Busy-Waiting und Interrupt?
Bei Busy-Waiting ist die CPU blockiert, bei einem Interrupt nicht

## Was versteht man unter einem BIOS?
Programm auf niedriger Stufe zum starten des BS

## Wozu dienen Systemaufrufe?
Ausführen einer Betriebsystemfunktionalität

## Was ist eine Shell?
Ein Kommandointerpreter

## Was ist ein Prozess?
Abstraktion eines laufenden Programmes

## Worauf muss man bei Mehrprozess-Betriebssystemen besonders achten?
Auf die kritischen Bereiche und dass jeder irgendwann seine Aufgabe erledigen kann

## In welchen Zuständen kann ein Prozess sein?
* rechnend (running): in Ausführung auf der CPU
* rechenbereit (ready): temporär suspendiert
* blockiert (blocked): wartend auf ein externes Ereignis

## Was ist das Ziel der IPC?
Interprocess Communication (IPC), strukturierter und konfliktfreier Ablauf von Prozessen

## Was ist eine Semaphor?
Integer-Variable, auf die über 2 spezielle unteilbare (atomare) Operationen
zugegriffen wird. (Nicht unterbrechbar)

## Was ist ein Mutex?
Variable, die die beiden Zustände unlocked oder locked haben kann und mit der man wechselseitigen Ausschluss beim Zugriff auf eine gemeinsame Ressource realisieren kann.

## Welche grundsätzlich verschiedenen Scheduling-Methoden gibt es?
* Nonpreemptive, solange bis er blockiert oder die CPU freigibt
* Preemptive, automische suspendierung nach einer gewissen Zeit

## Was ist die Aufgabe der Paging-Table?
Verbindung zwischen virtuellen und physikalischen Adressen

## Was versteht man unter Speichermanagement?
Die Verwaltung des Arbeitsspeichers (Struckturierung, Virtueller Speicher verwalten, Paging, Swapping)

## Nennen Sie drei Anforderungen an Dateisysteme.
Presistent, paraleller Zugriff, Zugriffsrechte

## Was ist ein i-Node?
In Unix, Verwaltungsinformation des Dateisystem

## Was bedeuten Protection-Codes?
Zugriffsrechte einer Datei (chmod 777)

## Was ist eine Pipe?
Pseudofile, für Kommunikation zwischen Prozesse (Zwischenpuffer für Daten)

## Wie arbeiten die Systemkomponenten beim einem Client-Server System zusammen?
CLient schickt Anforderung, Server sendet Antwort zurück

## Was versteht man unter RPC?
Remote Procedure Call (Starten eines Prozess auf einem anderen Rechner)

## Wofür steht der Name CORBA?
Common Object Request Broker Architecture

## Was ist eine IDL?
Interface Definition Language

## Wie heissen die Stufen einer Drei-Stufen- Architektur?
Benutzeroberfläche, Anwendungsschicht, Datenspeicher
