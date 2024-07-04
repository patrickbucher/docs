# LPIC-1

Anselm Lingnau: LPIC-1. Optimale Vorbereitung auf die LPI-Prüfungen 101 und 102. 7. Auflage (ISBN-13: 978-3-95845-956-4)

## Dokumentation

Gegenüberstellung Manual Pages und GNU Info:

|                             | Manual Pages     | GNU Info          |
|-----------------------------|------------------|-------------------|
| Befehl                      | `man`            | `info`            |
| Verzeichnis                 | `/usr/share/man` | /`usr/share/info` |
| Umgebungsvariable für Pfade | `MANPATH`        | `INFOPATH`        |

Kapitel der Manual Pages:

1. Benutzerkommandos
2. Systemaufrufe
3. Bibliotheksaufrufe
4. Gerätedateien
5. Konfigurationsdateien, Dateiformate
6. Spiele
7. Diverses, Konventionen
8. Systemadministrationskommandos
9. Kernel-Funktionen

Hilfreiche Befehle:

- `man -k STICHWORT` bzw. `apropos STICHWORT`: nach einem Suchbegriff suchen
    - siehe Index `/var/cache/man/index.db`, mit `mandb` aktualisierbar
- `whatis BEFEHL`

Weitere Quellen:

- [Linux Documentation Project](https://tldp.org): HOWTOs, Guides, FAQs usw.
- [LWN.net](https://lwn.net/): Neuigkeiten, Artikel
