# Linux-Scheduler

- Prozessparameter
    - Schedulingrichtlinie und Schedulingpriorität
- Echtzeitrichtlinien -> anhand Priorität eingeplant
    - 0‥99 (100 Stufen)
- normale Richtlinien -> anhand nice-Wert eingeplant
    - 100‥139 (40 Stufen)
    - Standard: 120
    - höchste: 100
    - tiefste: 139
- siehe `grep ^prio /proc/$$/sched`
- `ps -l`: Spalte PRI (-40‥99), 40 dazuaddieren!
- `top`: Spalte PR (-100‥39), 100 dazuaddieren!
    - negative Zahl: Echtzeitprozess
- nice-Wert
    - 0: Standard (Priorität 120)
    - -20: nicht nett (höchste Priorität)
    - +19: sehr nett (tiefste Priorität)
    - `top` und `ps`: Spalte `NI`
    - `root` kann Priorität erhöhen

```
$ ps l $$
F   UID     PID    PPID PRI  NI    VSZ   RSS WCHAN  STAT TTY        TIME COMMAND
0  1000    1216    1213  20   0  15280 11860 do_wai Ss   pts/1      0:00 /bin/bash
```

Prozess mit tieferer Priorität starten (nice-Wert standardmässig auf 10):

```
$ nice bash
$ ps l $$
F   UID     PID    PPID PRI  NI    VSZ   RSS WCHAN  STAT TTY        TIME COMMAND
0  1000    1553    1216  30  10  15124 11740 do_wai SN   pts/1      0:00 bash

$ nice -n 5 bash
$ ps l $$
F   UID     PID    PPID PRI  NI    VSZ   RSS WCHAN  STAT TTY        TIME COMMAND
0  1000    1590    1216  25   5  15124 11868 do_wai SN   pts/1      0:00 bash
```

Negative nice-Werte können nur durch `root` gesetzt werden:

```
$ nice -n -10 bash
nice: cannot set niceness: Permission denied

$ sudo nice -n -10 bash
F   UID     PID    PPID PRI  NI    VSZ   RSS WCHAN  STAT TTY        TIME COMMAND
4     0    1579    1578  29   9   7784  4480 do_wai SN   pts/2      0:00 bash
```

Der nice-Wert kann mit `renice` von einem laufenden Prozess verändert werden:

```
$ renice 5 -p 1213
1213 (process ID) old priority 0, new priority 5

$ renice -5 -p 1213
renice: failed to set priority for 1213 (process ID): Permission denied

$ sudo renice -5 -p 1213
1213 (process ID) old priority 5, new priority -5
```

Die Priorität für alle Prozesse eines Benutzers:

```
$ sudo renice -5 -u $USER
```

In `top` kann `renice` mit `r` und einer PID ausgeführt werden.
