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

TODO
