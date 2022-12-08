Ziel: Eine verschlüsselte Datenverbindung zweier Server über öffentliches
Netzwerk herstellen und darüber Daten austauschen.

Alternativen:

- SCP: für Dateiübertragungen sinnvoll, nicht für beliebige Datenverbindungen
- GPG: für einzelne Nachrichten sinnvoll, nicht für bestehende Verbindungen
- SSH: TODO

Werkzeuge:

- VirtualBox
    - zwei VMs
    - Host-Only-Networking (Austausch zweier VMs)
- ufw
    - Zugriff von bestimmter IP aus erlauben
        - evtl. auf Port einschränken
- netcat (`nc`)
    - erlaubt unverschlüsselte Socketverbindung
- `dd`, `base64`, `/dev/urandom`
    - geheimen Schlüssel generieren
- `spiped`
    - sicheren Kanal erstellen

# Befehle

Schlüssel generieren:

    dd if=/dev/urandom of=/dev/stdout bs=64 count=1 | base64 -w 0 > secret.key

Lokale, unverschlüsselte Datenverbindung:

    # receive data
    nc -l 5000

    # send data
    echo 'hello' | nc localhost 5000

Verschlüsselnde Verbindung einrichten:

    spiped -e -s 0.0.0.0:2000 -t 127.0.0.1:3000 -k secret.key

Auf die verschlüsselnde Verbindung hören:

    nc -l -p 3000

Eine Nachricht zur Verschlüsselung übertragen:

    echo 'top secret message' | nc 127.0.0.1 2000

Entschlüsselnde Verbindung einrichten:

    spiped -d -s 127.0.0.1:3000 -t 127.0.0.1:4000 -k secret.key

Auf die entschlüsselnde Verbindung hören:

    nc -l -p 4000

Eine Nachricht zur Ver- und Entschlüsselung übertragen:

    echo 'another secret message' | nc 127.0.0.1 2000

# Videos

- Playlist: Verschlüsselte Verbindung mit spiped
    - Video 1: Motivation erläutern (Grafiken)
    - Video 2: VirtualBox Host-only-Netzwerk einrichten
    - Video 3: VM klonen, kopieren
    - Video 4: Firewall konfigurieren, Übertragung mit Netcat
    - Video 5: spiped
