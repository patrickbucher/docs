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

### Wie funktioniert Broadcasting?
* Mehrere Sender können auf einen Übertragungskanal zugreifen
* Nachrichten werden als Pakete gesendet
* Pakete können von allen angeschlossenen Rechnern empfangen werden
* Ein Adressfeld im Paket gibt das Ziel an
    * Broadcasting: Versand an alle
    * Multicasting: Versand an eine Gruppe
    * Unicasting: Versand an einen einzelnen Empfänger

### Was ist MAC?
Beim Senden auf einem gemeinsamen Kanal kann es zu Kollisionen kommen, wenn mehrere Sender gleichzeitig den Übertragungskanal verwenden wollen. Medium Access Control (MAC, Layer 2) regelt die Vergabe des Zugriffsrechts auf den gemeinsamen Übertragungskanal.

### Welche MAC-Zugriffsverfahren gibt es?
* ALOHA
    * Erneutes Senden nach zufälliger Wartezeit nach negativer Rückmeldung
    * Slotted ALOHA: Übertragung nur zu Beginn von definierten Zeitabschnitten möglich
* CSMA (Carrier Sense Multiple Access)
    * Sender hört den Datenverkehr auf der Leitung ab
    * Sobald der Kanal frei ist, wird gesendet
    * Im Falle einer Kollision wird nach einer zufälligen Wartezeit erneut gesendet
    * CSMA/CD (Carrier Sense Multiple Access/Collission Detection)
        * Abbruch der Übertragung bei einem Fehler
    * CSMA/CA (Carrier Sense Multiple Access/Collission Avoidance)
        * Teilnehmerkennung (= Priorität)

### In welche Unterschichten wird die Sicherungsschicht unterteilt?
* LLC: Logic Link Control
    * Fügt jedem Frame einen LLC-Header hinzu
    * dieser enthält Folge- und Bestätigungsnummern
    * Dienste
        * Unzuverlässiger Datagrammdienst
        * Bestätigter Datagrammdienst
        * Zuverlässiger, verbindungsorientierter Dienst
* MAC: Vergabe des Kanal-Zugriffsrechts 

### Welche Protokolle definiert IEEE-802?
* 802.1 Internetworking, Layer 3
* 802.2 LLC, Layer 2
* 802.3 Ethernet, Layer 1/2
* 802.5 Tokenring, Layer 1/2
* 802.11 WLAN, Layer 1/2
* 802.15 WPAN (Bluetooth), Layer 1/2

### Was ist die Aufgabe der Vermittlungsschicht?
Der Transport von Paketen von einer Quelle bis zu einem Ziel durch das gesamte Netzwerk bzw. durch ein Teilnetzwerk.

### Welche Netzwerkarten gibt es?
* PAN: Personal Area Network
    * Peripherie zu PC, Smartphone zu Laptop
* LAN: Local Area Network
    * Vernetzung innerhalb eines Gebäudes bzw. auf einem Firmengelände
* MAN: Metropolitan Area Network
    * Vernetzung einer Stadt (z.B. EWL Glasfasernetzwerk)
* WAN: Wide Area Network
    * Vernetzung von Städten, Ländern, Kontinenten

### Wie funktioniert das Store-and-Forward-Verfahren?
* Pakete werden jeweils an den nächsten Router gesendet
* Zwischenspeicherung des Pakets beim Router (Sicherungsschicht)
* Weiterleitung des Pakets zum nächsten Router
* usw. bis Ankunft beim Ziel-Host

### Auf welche beiden Arten kann die Vermittlungsschicht arbeiten?
1. Verbindungslos
    * Vermittlung einzelner Pakete durch das Netzwerk
    * Jedes Paket trägt die vollständige Zieladresse
    * Jedes Paket kann einen anderen Weg nehmen
    * Fehlerüberwachung erfolgt durch Hosts
    * Beispiel: IP
1. Verbindungsorientiert (virtuelle Verbindung)
    * Verbindung wird auf- und abgebaut
    * Jedes Paket trägt eine Verbindungskennung
    * Alle Pakete nehmen den gleichen Weg durchs Netzwerk
    * Gewährleistung der Verbindungsqualität
    * Beispiel: ISDN

### Wie werden Routing-Tabellen erstellt?
* statisch: durch Initialisierung beim Start
    * einfacher
* dynamisch: durch Berechnung während des Betriebs
    * erfordert zusätzlichen Informationsaustausch zwischen den Routern

### Wozu dienen Routing-Algorithmen?
Sie füllen die Routing-Tabelle aufgrund von Messungen und/oder Schätzungen auf und können sich dabei der Topologie anpassen.

### Was sind Anforderungen an einen Routing-Algorithmus?
* Genauigkeit
* Einfachheit
* Robustheit
* Fairness
* Optimum

Zwischen Fairness und Optimum kann es konflikte geben: optimale Auslastung vs. faire Verteilung.

### Welche Routing-Algorithmen gibt es?
* Shortest Path Routing (nach Dijkstra)
* Flooding (Fluten)
* Distance Vector Routing (dynamisch, berücksichtigt Netzlast)
* Link State Routing/Shortest Path First
* Hierarchisches Routing
* Broadcast-Routing
* Multicast-Routing

### Womit werden Netzwerke auf verschiedenen Schichten miteinander verbunden?
* Anwendungsschicht: Applikations-Gateways
* Transportschicht: Transport-Gateways
* Vermittlungsschicht: Router
* Sicherungsschicht
    * Bridge: verbindet Netzwerke; weiss, welche MAC-Adresse zu welcher Seite gehören
        * transparente Bridge: verbindet zwei lokale Netzwerke mit gleichem Layer-2-Protokoll
        * übersetzende Bridge: verbindet zwei lokale Netzwerke mit unterschiedlichem Layer-2-Protokoll
        * Remote-Bridge (Tunnel): schliesst weit entfernte LANs über ein WAN zusammen
    * Switch: "intelligentes" Hub, schickt Pakete nur an Zielhost weiter
* Bitübertragungsschicht
    * Repeater: Regeneriert das Signal auf der Leitung
    * Hub: Sternförmige Verkabelung der Busteilnehmer (simuliert gemeinsames Ethernetkabel)
* Alle Schichten
    * Gateway

### Was ist ein Internet-Steuerprotokoll?
Ein Protokoll, das parallel zu IP auf der Vermittlungsschicht angesiedelt ist. Beispiele:

* ICMP: Internet Control Messag Protocol (für Roter, ping)
* ARP: Address Resolution Protocol (Auflösung von MAC- zu IP-Adresse)
* DHCP: Dynamic Host Configuratoin Protocol (Vergabe dynamischer IP-Adressen)
