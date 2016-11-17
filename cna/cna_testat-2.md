# CNA: 2. Testatprüfung

## Studienelement Betriebssysteme

### Was macht ein Betriebssystem (BS) ?
Betriebssysteme realisieren eine Softwareschicht zwischen Anwendungen und Hardware, die sich mit der Verwaltung der Hardwarekomponenten beschäftigt und für die Anwendungen einfachere Schnittstellen bereitstellt (System Calls).

### Was sind die Nachteile, wenn ein Rechner ohne Betriebssystem benutzt wird?
* Komplizierter zum Programmieren
* man muss die Hardware kennen
* Eingeschränkte Wiederverwendbarkeit und  Portierbarkeit
* Ressourcen müssen selber verwaltet werden

### Was sind die Vorteile, wenn ein Rechner ohne BS benutzt wird?
* Schlankeres System
* Vollständige Kontrolle
* Bessere Performance
* keine Kosten (für ein Betriebssystem)
* keine Betriebssystem-Updates
* keine Viren

### Welche Möglichkeiten hat das Betriebssystem um auf IO-Geräte zu reagieren?
* Polling (Busy Waiting)
* Interrupts
* DMA (Direct Memory Access)

### Beschreiben Sie die Hauptaufgaben eines BS?
* Ressourcenmanagement
* Benutzerverwaltung
* Prozessmanagement
* IO-Management
* Filesystemverwaltung
* Bereitstellung von System Calls

### Welche Aufgabe erfüllt eine MMU?
Die Memory Management Unit (MMU) macht das Mapping von virtuellen zu physikalischen Adressen (und umgekehrt) und bietet Speicherschutzverwaltung.

### Worin unterscheiden sich Busy-Waiting und Interrupt?
Bei Busy-Waiting ist die CPU blockiert, bei einem Interrupt nicht.

### Was versteht man unter einem BIOS?
Programm auf niedriger Stufe zum starten des BS

### Wozu dienen Systemaufrufe?
Ausführen einer Betriebsystemfunktionalität

### Was ist eine Shell?
Ein Kommandointerpreter

### Was ist ein Prozess?
Abstraktion eines laufenden Programmes

### Worauf muss man bei Mehrprozess-Betriebssystemen besonders achten?
Auf die kritischen Bereiche, und dass jeder irgendwann seine Aufgabe erledigen kann

### In welchen Zuständen kann ein Prozess sein?
* rechnend (running): in Ausführung auf der CPU
* rechenbereit (ready): temporär suspendiert
* blockiert (blocked): wartend auf ein externes Ereignis

### Was ist das Ziel der IPC?
Interprocess Communication (IPC), strukturierter und konfliktfreier Ablauf von Prozessen

### Was ist eine Semaphore?
Integer-Variable, auf die über 2 spezielle unteilbare (atomare) Operationen (Up und Down) zugegriffen wird. (Nicht unterbrechbar)

### Wie funktionieren die Up/Down-Operationen?
* Down/P(s) 
    * wenn Semaphore = 0, sleep
    * wenn Semaphore > 0, dekrement
* Up/V(s)
    * Semaphore erhöhen
    * einen schlafenden Prozess aufwecken

### Was ist ein Mutex?
Variable, die die beiden Zustände unlocked oder locked haben kann und mit der man wechselseitigen Ausschluss beim Zugriff auf eine gemeinsame Ressource realisieren kann.

### Welche grundsätzlich verschiedenen Scheduling-Methoden gibt es?
* Nonpreemptive, solange bis er blockiert oder die CPU freigibt
* Preemptive, automische suspendierung nach einer gewissen Zeit

### Was ist die Aufgabe der Paging-Table?
Mapping von virtuellen zu physikalischen Adressen (und umgekehrt)

### Was versteht man unter Speichermanagement?
Die Verwaltung des Arbeitsspeichers (Strukturierung, virtuellen Speicher verwalten, Paging, Swapping)

### Nennen Sie drei Anforderungen an Dateisysteme.
Presistent, paralleler Zugriff, Zugriffsrechte

### Was ist ein i-Node?
In Unix, Verwaltungsinformation des Dateisystem

### Was bedeuten Protection-Codes?
Zugriffsrechte einer Datei (chmod 777)

### Was ist eine Pipe?
Pseudofile, für Kommunikation zwischen Prozesse (Zwischenpuffer für Daten)

### Wie arbeiten die Systemkomponenten beim einem Client-Server System zusammen?
Client schickt Anforderung, Server sendet Antwort zurück

### Was versteht man unter RPC?
Remote Procedure Call (Starten eines Prozess auf einem anderen Rechner)

### Wofür steht der Name CORBA?
Common Object Request Broker Architecture

### Was ist eine IDL?
Interface Definition Language

### Wie heissen die Stufen einer Drei-Stufen- Architektur?
Benutzeroberfläche, Anwendungsschicht, Datenspeicher

## Studienelement Netzwerk

### Was bezeichnet man als Latenzzeit und wie berechnet man sie?
Die Latenzzeit ist die Zeit, die vergeht, bis ein Paket vollständig beim Empfänger angekommen ist.

Latenzzeit = Distanz/Ausbreitungsgeschwindigkeit + Paketgrösse/Durchsatz + Wartezeit

### Welche Service Primitives gibt es im OSI-Modell?
* Request: Auf System A ruft die höhere Schicht einen Service einer tieferen Schicht auf
* Indication: Auf System B meldet die tiefere Schicht der höheren Schicht, dass ein Request eingegangen ist
* Response: Auf System B gibt die höhere Schicht der tieferen Schicht eine Antwort
* Confirm: Auf System A bestätigt die tiefere Schicht der höheren Schicht die Anfrage

### Wodurch zeichnen sich verbindungsorientierte und verbindngslose Dienste aus?
* verbindungsorientiert
    * Analogie: Telefonverkehrt
    * Nachrichten tragen keine Adressen
    * es gibt eine Verbindung
    * Phasen
        1. Verbindungsaufgau
        2. Datenbertragung
        3. Verbindungsabbau
* verbindungslos
    * Analogie: Briefverkehr
    * Nachrichten tragen Adressen
    * es gibt keine Verbindung

### Was bedeutet OSI-Referenzmodell?
Open Systems Interconnection Reference Model

### Wie heissen die Schichten im OSI- und TCP/IP-Referenzmodell?
| OSI                       | TCP/IP            |
| ------------------------- | ----------------- |
| Application (Anwendung)   | Application       |
| Presentation (Darstellung)|                   |
| Session (Sitzung)         |                   |
| Transport (Transport)     | Transport         |
| Network (Vermittlung)     | Internet          |
| Data Link (Sicherung)     | Host-to-network   |
| Physical (Bitübertragung) |                   |

### Welche Protokolle gibt es im TCP/IP-Referenzmodell?
* Application
    * Telnet
    * FTP
    * SMTP
    * DNS
* Transport
    * TCP
    * UDP
* Network
    * IP
* Host-to-network
    * ADSL
    * WLAN
    * LAN
    * WAN

### Welche Adressierungsebenen gibt es?
* Port-Nummer zur Identifizierung der Anwendung
* Transportprotokolladresse (TCP/UDP)
* Endsystemadresse zur Adressierung des Zielsystems (z.B. IP-Adresse)
* Link-Level-Adressierung (z.B. MAC-Adresse einer Netzwerkkarte)

### Was ist der Hamming-Abstand/die Hamming-Distanz?
Die Anzahl der Bits, in denen sich zwei Codewörter unterscheiden.

* 10110011
* 11010010
* `h=3` (drei unterschiedliche Bits)

Bei `n` Bits gibt es `2^n` mögliche Codewörter. Werden alle diese Codewörter verwendet, beträgt h = 1 (keine Redundanz).

### Wozu dient der Hamming Code?
* Zum erkennen von n Übertragungsfehlern (mit dem Hamming-Abstand `h=n+1`)
* Zum korrigieren von n Übertragungsfehlern (mit dem Hamming-Abstand `h=2n+1`)

### Wie funktioniert ein Paritätsbit?
* Anhängen eines Bits, sodass die Summe aller (inkl. Paritätsbit) 1en
    * ungerade ist
        * `01010101` -> `01010101 1` (ungerade Parität)
    * gerade ist
        * `11010011` -> `11010011 1` (gerade Parität)

### Wie lauten die Aufgaben der Sicherungsschicht?
Gewährleistung einer sicheren Übertragung durch:

* Fehlererkennung
    * Paritäts-Bit
    * Checksumme
    * CRC
* Fehlerkorrektur (falls möglich)
* positive Rückmeldung an Sender bei korrekter Übertragung
* Anforderung an Sender zur Wiederholung bei fehlerhafter Übertragung
* Durchnummerieren der Frames zur Erkennung vorlorener Frames
* Frame erneut senden, sollte die Empfangsbestätigung nach Timeout eintreffen
