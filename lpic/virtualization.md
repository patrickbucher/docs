# Linux als Virtualisierungs-Gast

- Hypervisor: Verwaltet die Hardware-Ressourcen des Host-Systems um sie dem
  Gast-System zur Verfügung zu stellen.
- Typ-1-Hypervisor: Funktioniert ohne zugrundeliegendes Betriebssystem.
- Typ-2-Hypervisor: Benötigt ein zugrundeliegendes Betriebssystem.
- Xen: Typ-1-Hypervisor
- KVM: Typ-1/2-Hypervisor, der mit `libvirt` verwendet wird
- VirtualBox: Typ-2-Hypervisor für verschiedene Plattformen
- Migration: Verschiebung einer virtuellen Maschine von einem Host zum anderen
- Livemigration: Verschiebung bei laufendem Gast
- vollständige Virtualisierung: alle Anweisungen laufen über den Hypervisor;
  Gast benötigt keine Softwaretreiber; Gast weiss nicht, dass er als VM läuft.
- Paravirtualisierung: modifizierter Kernel mit Gästetreiber; VM weiss, dass
  sie als VM läuft.
- hybride Virtualisierung: Mischung zwischen vollständiger und Paravirtualisierung

## `libvirt`

Verzeichnisstruktur:

- `/etc/libvirt/qemu`
    - pro VM (z.B. `bookworm`): `bookworm.xml`
        - Beispiel: virtuelle Maschine `bookworm.xml` (`/etc/libvirt/qemu/bookworm.xml`)
    - Netzwerk: `networks/default.xml`
- `/var/lib/libvirt/`
    - Images: `images/`
    - Arten
        - COW: Copy-on-Write, basierend auf Basisimage, bei dem nur tatsächlich
          benötigte Daten geschrieben werden und Platz benötigen. (Endung:
          `.qcow2`)
        - RAW: Speicherplatz bereits vollständig zugewiesen. Schneller beim
          Schreiben, benötigt jedoch Überwachung der Speichergrenze.

## D-Bus-Maschinenkennung

Identifikationsnummer, die beim Klonen neu vergeben werden muss.

Ist eine D-Bus-Maschinenkennung vorhanden?

    $ dbus-uuidgen --ensure
    $ echo $?
    0

Die D-Bus-Maschinenkennung anzeigen:

    $ dbus-uuidgen --get
    a07efb1aecd9495f9bce09573a2ca441

    $ cat /var/lib/dbus/machine-id 
    a07efb1aecd9495f9bce09573a2ca441

Letztere Datei ist ein symbolischer Link:

    $ ls -l /var/lib/dbus/machine-id
    /var/lib/dbus/machine-id -> /etc/machine-id

## `cloud-init`

Konfiguriert VM in der Cloud anhand von YAML-Konfigurationsdateien
