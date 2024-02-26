# Reguläre Ausdrücke

- Zeichenklassen: `[:alnum:]`, `[:alpha:]` usw. (siehe `man 7 regex`)
    - `[:print:]` ist inkl., `[:graph:]` ist exkl. Leerzeichen
- Quantoren: `*`, `+`, `?`
- Grenzen: `{i}`, `{i,}`, `{i,j}`
- Zweige: `|`
- Referenz: `([a-z]+) \1` (Wiederholung nach Leerzeichen)
- einfache REs benötigen `\` vor den Quantoren `+` und `?` und vor `{` und `}`
  bei Grenzen bzw. vor `(` und `)` bei Gruppen
    - Zweige nur von manchen Programmen unterstützt (escaped)
- Anwendungen:
    - `find`: Flag `-regex` und `-iregex` (case insensitive)
        - `-regextype`: `posix-extended`
    - `less`: Suche mit `/`
