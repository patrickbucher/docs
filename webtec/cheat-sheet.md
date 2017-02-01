<div class="main">

# HTML

## Meta Tags

    <!-- Sprache -->
    <meta http-equiv="language" content="deutsch, de">

    <!-- Automatisches Laden der Seite foobar.html nach 10 Sekunden -->
    <meta http-equiv="refresh" content="10; URL=foobar.html">

    <!-- Seitenbeschreibung -->
    <meta name="description" content="Webseite meiner Brauerei">

    <!-- Autor der Seite -->
    <meta name="author" content="Patrick Bucher, patrick.bucher87@gmail.com>

    <!-- Schlüsselwörter -->
    <meta name="keywords" content="bier, brauen, hopfen, malz">

    <!-- Thema der Seite -->
    <meta name="page-topic" content="Bier brauen">

    <!-- Zielpublikum -->
    <meta name="audience" content="Erwachsene">

    <!-- Verhalten von Suchmaschinen -->
    <meta name="robots" content="index,follow">

    <!-- Intervall für erneute Suchmaschinen-Indizierung -->
    <meta name="revisit-after" content="14 days">

## robots.txt

Im Hauptverzeichnis der Seite abgelegt, Beispiel:

    User-agent: Googlebot
    Disallow: /private/
    Disallow: /pictures/
    Allow: /public/

## Textauszeichnung (Inline)

    <!-- Abkürzung -->
    <abbr>...</abbr>

    <!-- Akronym -->
    <acronym>...</acronym>

    <!-- Zitat -->
    <cite>...</cite>

    <!-- Quellcode -->
    <code>...</code>

    <!-- Definition -->
    <dfn>...</dfn>

    <!-- Betonung (kursiv) -->
    <em>...</em>

    <!-- Tastatureingabe -->
    <kbd>...</kbd>

    <!-- Beispiel -->
    <samp>...</samp>

    <!-- Stark (fett) -->
    <strong>...</strong>

    <!-- Variable -->
    <var>...</var>

## HTML 5 Blockelemente

    <header>
    <footer>
    <figure>
    <figcaption>
    <aside>
    <nav>
    <section>
    <article>
    <address>

## Tabellen
    <table>
        <caption>Tabellenüberschrift</caption>
        <tr>
            <th>Spaltenüberschrift 1</th>
            <th>Spaltenüberschrift 2</th>
        </tr>
        <tr>
            <td>Spalte 1, Zeile 1</td>
            <td>Spalte 2, Zeile 1</td>
        </tr>
        <tr>
            <td>Spalte 1, Zeile 2</td>
            <td>Spalte 2, Zeile 2</td>
        </tr>
    </table>

## Image-Maps

    <map>
        <!-- Rechteck mit linker oberen Ecke (10,20)
         und rechter unteren Ecke (30,40) -->
        <area shape="rect" coords="10, 20, 30, 40" href="...">
        <!-- Kreis mit Zentrum (10,20) und Radius 30 -->
        <area shape="circle" coords="10, 20, 30" href="...">
        <!-- Polygon durch (5,0), (10,5), (5,10), (5,0): eine Raute -->
        <area shape="poly" coords="5,0, 10,5, 5,10 5,0" href="...">
    </map>

## Frames und iFrames

    <!-- anstelle von <body>, nicht in HTML5! -->
    <frameset cols="20%, 80%">
        <frame src="nav.html" name="navigation">
            <a href="info.html" target="content">Info</a>
        </frame>
        <frame src="content.html" name="content" />
    </frameset>

    <iframe src="http://google.com" name="search" />

## HTML 5 Formularelemente

    <!-- Data List -->
    <input type="text" list="mylist">
    <datalist id="mylist">
        <option value="Option A">
        <option value="Option B">
        <option value="Option C">
    </datalist>

    <!-- Platzhalter für Input-Text -->
    <input type="text" placeholder="Ihr Name">

    <!-- Spezielle Texteingaben (Suche, E-Mail, URL, Telefonnummer) -->
    <input type="search">
    <input type="email">
    <input type="url">
    <input type="tel">

    <!-- Slider -->
    <input type="range" min="0" max="10" step="2"

    <!-- Nummmer -->
    <input type="number" min="1" max="100" step="10">

    <!-- Datum und Uhrzeit -->
    <input type="date">
    <input type="datetime">
    <input type="datetime-local">
    <input type="time">
    <input type="month">

    <!-- Validierung mittels Regex (hier: drei oder mehr Ziffern) -->
    <input type="text" pattern="^[0-9]{3,}$">

    <!-- Farbauswahl -->
    <input type="color">

## Definitionslisten

    <!-- Definitionsliste (Glossar) -->
    <dl>...</dl>

    <!-- Definitionsbegriff -->
    <dt>...</dt>

    <!-- Definition -->
    <dd>...</dd>

    <!-- Beispiel einer Definitionsliste -->
    <dl>
        <dt>Yes</dt> <dd>heisst Ja</dd>
        <dt>No</dt> <dd>heisst Nein</dd>
    </dl>

## Multimedia

    <!-- Audio -->
    <audio src="sound.mp3">
    <audio>
        <source src="sound.mp3" type="audio/mpeg">
        <source src="sound.ogg" type="audio/ogg">
    </audio>

    <!-- Video -->
    <video src="movie.mp4" poster="screenshot.jpg">
    <video poster="screenshot.jpg">
        <source src="movie.mp4" type="video/mp4">
        <source src="movie.ogv" type="video/ogg">
    </video>

    <!-- Skalierbare Vektorgrafik -->
    <svg>...</svg>

    <!-- Canvas -->
    <canvas>

## Diverses

    <!-- Viewport automatisch auf die Breite des Bildschirmes setzen -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- fixer Viewport mit einer Breite von 320 Pixel -->
    <meta name="viewpoert" content="width=320">

# CSS

## Einbindung in HTML-Dokument

Im Header:

    <style>
    * {
        font-size: 16pt;
    }
    </style>

Externe CSS-Datei verlinken:

    <link rel="stylesheet" type="text/css" href="style.css">

Inline:

    <body style="font-size: 16pt;">

Medien (per `<link>`-Tag):

    <!-- Bildschirm -->
    <link rel="stylesheet" media="screen" href="screen.css">

    <!-- Drucker -->
    <link rel="stylesheet" media="print" href="print.css">

    <!-- Braille -->
    <link rel="stylesheet" media="embossed" href="embossed.css">

Weitere: `handheld`, `projection`, `speech`, `tty`, `tv`

Medien (mit CSS):

    @import url(screen.css) screen;
    @import url(print.css) print;
    @import url(embossed.css) embossed;

## Priorität (zunehmend)

1. Deklaration des Browsers (Standardeinstellungen)
2. Deklaration des Besuchers
3. Externe CSS-Anweisung des Autors 
4. Interne CSS-Anweisung des Autors
5. Inline CSS-Anweisung des Autors
6. `!important`-Deklaration des Autors
6. `!important`-Deklaration des Benutzers

## Pseudo-Selektoren

- `a:link` Hyperlink
- `a:visited` bereits besucht
- `a:active` angeklickter Hyperlink
- `a:hover` unter dem Mauszeiger
- `a:focus` mit Tastatur ausgewählt

- `p:first-line` erste Zeile
- `p:first-letter` erster Buchstabe

## Farben

- RGB
    - `color: #ff0000;`
    - `color: rgb(255, 0, 0);`
- RGBA (mit Alpha-Channel für Transparenz; 0: völlig transparent)
    - `color: rgba(255, 0, 0, 0.5);`
- HSL (hue, saturation, lightness)
    - `color: hsl(120, 65%, 75%);`
- HSLA (mit Alpha-Channel):
    - `color: hsla(120, 65%, 75%, 0.5);`

## Externe Schriften

    @font-face {
        font-family: "myfont";
        src: url("/fonts/myfont.ttf");
    }

## Selektoren

- `A B`
    - Alle Elemente B, die Kind von Element A sind
- `A>B`
    - Alle Elemente B, die _unmittelbares_ Kind von Element A sind
- `A+B`
    - Alle Elemente B, die auf ein Element A folgen
- `A~B`
    - Alle Elemente B, die _unmittelbar_ auf ein Element A folgen

## nth Child

    p:nth-child(n) {
        // apply to paragraph number n
    }

    p:nth-child(odd) {
        // apply to paragraphs with odd number
    }

    p:nth-child(even) {
        // apply to paragraphs with even number
    }

    p:nth-child(an+b) {
        // apply to paragraph with index
        // a = cycle size (every "a-th" paragraph)
        // b = offset (starting from "b-th" paragraph)
    }

    p:nth-child(3n+2) {
        // apply to every third paragraph
        // starting from the second paragraph
    }

## Media-Queries

    @media screen and (orientation: portrait) {
        /* Styles für das Hochformat */ 
    } 
    @media screen and (orientation: landscape) {
        /* Styles für das Hochformat */ 
    }

    @media (min-width: 800px) {
        /* Styles für breite Bildschirme */
    }
    @media (max-width: 800px) {
        /* Styles für schmale Bildschirme */
    }
    
    @media screen and (device-aspct-ratio: 16/9) {
        /* Styles für das 16:9-Format */
    }

    @media screen and (device-aspct-ratio: 4/3) {
        /* Styles für das 16:9-Format */
    }

## Positionierung

### Absolut

    div {
        position: absolute;
        width: 50%;
        top: 100px;
        left: 50px;
    }

### Relativ (zu übergeordneten, absolut positioniertem Element)

    div {
        position: relative;
        top: 20px;
        left: 10px;
    }

### Float

    div.main {
        margin-right: 30%;
    }

    div.side {
        float: left;
        width: 30%;
    }

### Fixed

    div.footer {
        position: fixed;
        bottom: 0px;
        left: 0px;
        width: 100%;
        height: 50px;
    }

### Flexbox

* Container-Element
    - display
        * flex
    - flex-direction
        * row
        * row-reverse
        * column
        * column-reverse
    - flex-wrap
        * nowrap
        * wrap
        * wrap-reverse;
    - flex-flow
        * [flex-direction] [flex-wrap]
        * Kombination der vorherigen beiden
    - justify-content
        * flex-start
        * flex-end
        * center
        * space-between
        * space-around;`
    - align-items
        * flex-start
        * flex-end
        * center
        * baseline
        * stretch;
    - align-content
        * flex-start
        * flex-end
        * center
        * space-between
        * space-around
        * stretch
* Child-Elemente
    - order
        * [integer]
    - flex-grow
        * [integer]
    - flex-shrink
        * [integer]
    - flex-basis:
        * [length]
        * auto
        * content
    - flex
        * [flex-grow] [flex-shrink] [flex-basis];
        * Kombination der vorherigen drei
    - `align-self
        * auto
        * flex-start
        * flex-end
        * center
        * baseline
        * stretch

# Accessibility

- «Accessibility» bedeutet «Zugänglichkeit».
- Webseiten so gestalten, dass sie jedermann betrachten kann
- Sensibilisierung wichtig
- Gesetzgebung
- «Barrierefreiheit»
- Genügend Zeit bei der Umsetzung von Web-Projekten einplanen!

## Zielgruppe

- Sehbehinderte (auch Farbenblinde)
- Muskel-, Gelenk- und Nervenkranke
    - mausorientierte Navigation
    - Epilepise: blinkende und flackernde Elemente
- Gehörlose
    - Audio- und Videoelemente
- Benutzer textorientierter Browser bzw. mit ausgeschalteter Grafikfunktion
- Tablet-, Netbook- und Smartphone-Benutzer
- bei tiefen Übertragungsraten
- Suchmaschinen-Crawler

## Richtlinien

- WAI (Web Accessibility Initiative)
- Web Content Accessibility Guidelines (1999)
- Schweizer Bundesverfassung
    - Massnahmen zur Beseitigung von Benachteiligungen der Behinderten
- Behindertengleichstellungsgesetz (BehiG, seit 2004)
    - "sämtliche Dienstleistungen öffentlicher Gemeinwesen" (d.h. auch Webseiten) müssen so angeboten werden, dass sie auch von Behinderten ohne Benachteiligung verwendet werden können
    - Möglichkeit, dieses Recht per Beschwerde oder Klage durchzusetzen (Entschädigung!)
    - Bund, Kantone, Gemeinden und bundesnahe Betriebe zu barrierefreiem Webdesign verpflichtet!
- Empfehlungen: access-for-all.ch
- WCAG (Web Content Accessibility Guidelines), eine W3C-Initiative
    - 1.0 (1999)
        - korrekte Verwendung von HTML und CSS
        - 14 Kategorien
        - 66 Gebote/Verbote
        - Prioritäten: muss, soll, darf/kann
        - 3 Konformitäten: WAI-A, WAI-AA, WAI-AAA
    - 2.0 (2008)
        - technologieunabhängige Prinzipien
        - offizielle Empfehlung des W3C
        - Prinzipien, Richtlinien, Erfolgskriterien (normativ)
        - Ausreichende und empfohlene Techniken (informatik)
- Evaluation für Accessibility: w3.org/WAI/eval/Overview.html
- P028 (Richtlinien des Bundes für die Gestaltung von barrierefreien Internetangeboten)
- WCAG 2.0 ist umfangreicher, tiefgehender und präziser
    - für einfache Webseiten und Webapplikationen geeignet
    - trägt der Wichtigkeit von JavaScript Rechnung
    - Einführung von HTML5 in die Richtlinien
    - WAI-ARIA (für Rich Internet Applications)

### WCAG 2.0

- Prinzipien
    1. Wahrnehmbar (perceivable)
        - Textalternativen für Bilder
        - Audio-Untertitel
        - Anpassbarkeit der Darstellung und Farbkontraste
        - Alternativen für zeitbasierte Medien
    2. Bedienbar (operable)
        - Maus- und Tastaturbedienung möglich
        - Farbkontraste
        - Zeitbegrenzungen bei Eingaben
        - Navigierarkeit
        - keine Effekte, die epileptische Anfälle auslösen können
    3. Verständlich (understandable)
        - Lesbarkeit
        - Vorhersagbarkeit
        - Hilfen bei Fehlern und bei der Eingabe
    4. Robust (robust)
        - Browser-Kompatibilität
        - Kompatibilität mit Hilfstechnologien (z.B. Braille-Lesegerät)

## Problemquellen

- Clientseitige Scripts (JavaScript, Java)
- Bilder ohne weiterführende Informationen (`alt`-Attribut, Caption)
- Flash-Animationen
- schlechte Farbwahl
    - tiefer Kontrast
    - Rot-Grün-Blindheit
- schlechte Typographie

# Webdesign

- Design for your target audience
- Test your page on different browsers
- Test your page at various screen resolutions
    * widely used: 1024x768, 1366x768, 1280x800
    * also test for mobile screens
- Website organization: hierarchical, linear, random
    * not too deep (three click rule)
- Visual Design: Repetition, Contrast, Proximity, Alignment
- Design to provide for accessibility: POUR
    * Perceivable: easy to see and hear
    * Operable: by mouse and keyboard
    * Understandable: easy to read content, well-organized
    * Robust: correct syntax, works on different platforms
- Writing for the Web
    * avoid long blocks of text
    * use bullet points instead
    * use headings and subheadings
    * use short paragraphs
- Design "easy to read" text
    * use common fonts
    * use appropriate text size
    * use appropriate line length (50-75 chars)
    * use strong contrasts
    * use columns for wide text areas
- Other considerations
    * choose hyperlink text carefully (bad: "click here")
    * use spell checkers
    * mind the load time
    * mind mobile devices

# JavaScript

## Einbindung

    <script language="JavaScript" src="script.js" type="text/javascript"></script>
    <script language="JavaScript" type="text/javascript">
        document.write("<h1>hello world</h1>");
    </script>

## DOM

### Das `document`-Objekt

- Eigenschaften
    * forms (Formulare)
    * images (Bilder)
    * links (Links)
    * location (URL des angezeigten Dokuments)
- Methoden
    * write(htmlStr); // htmlStr ins Dokument schreiben
    * getSelection(); // markierten Text auslesen
- Events
    * onClick
    * onDblClick // Doppelklick
    * onKeyUp
    * onKeyPress
    * onKeyDown

### Das `window`-Objekt

- Eigenschaften
    * document
    * frames
    * location
- Methoden
    * alert(meldung) // Meldung (Pop-Up)
    * print() // öffnet Druckdialog
    * close() // Fenster schliessen*
    * prompt(message, default) // Eingabeaufforderung
    * resizeTo(x, y) // Fenstergrösse ändern*
    * confirm(meldung) // Bestätigungsdialog anzeigen
- Events
    - onError
    - onFocus
    - onLoad
    - onUnload
    - onResize

\* wird meistens vom Browser abgefangen

## Array

* join()
* sort()
* reverse()
* push(element)
* pop()
* slice(start, ende)

    var arr = ['a', 'b', 'c'];
    var arr2d = [
        ['a', 'b', 'c'],
        ['A', 'B', 'C']
    ];

## Hashes

    var hash = [];
    hash['a'] = 'foo';
    hash['b'] = 'bar';

    console.log(hash['a']);
    console.log(hash.b);

## Objekte

    var o = new Object();
    o.a = 'foo';
    o.b = 'bar';
    o.f = function() { ... }:

    var o = {
        a : 'foo',
        b : 'bar',
        f : function() { ... }
    };

## Fehlerbehandlung

    window.onerror = handleError;
    function handleError(msg, file, line) {
        console.err("error: " + msg + " in +
            file + " on line " + line);
    }

    try {
        if (b == 0) {
            throw("divide by zero");
        } else {
            return a / b;
        }
    } catch (e) {
        console.error(e);
    } finally {
        console.log("always executed");
    }

## Canvas

    var canvas = document.getElementById("canvas");
    var context = canvas.getContext("2d");
    context.fillStyle = "rgb(255, 0, 0)"; // rot
    context.fillRect(30, 0, 50, 40); // Rechteck von (30,0), Höhe 50 und Breite 40

### Figuren/Linien

    context.beginPath(); // anfangen Linie/Figur zu zeichnen

    // Linie von (x1,y1) nach (x2,y2)
    context.moveTo(x1, y1);
    context.lineTo(x1, y2); 

    // 10px dicke, rote Linie
    context.lineWidth=10;
    context.strokeStyle="#ff0000";
    context.stroke();
    context.closePath();

    // Figur blau ausfüllen (Anfangs- und Endpunkt werden automatisch verbunden)
    context.strokeStyle="#0000ff";
    context.fill();

    context.closePath(); // Figur/Linie abschliessen

### Kreisbögen

    context.beginPath();

    // Bogen mit Mittelpunkt (x,y) mit Radius r
    // von Winkel alpha bis omega (von der positiven x-Achse)
    // true: Gegenuhrzeigersinn, false: Uhrzeigersinn
    arc(x, y, r, alpha, omega, true);

    // Halbkreis (Math.PI) mit Mittelpunkt (50,50) und Radius 10
    // vom Punkt (60,50) im Uhrzeigersinn
    arc(50, 50, 10, 0, Math.PI, false);

    // Kreis (2*Math.PI) mit Mittelpunkt (100,100) und Radius 50
    // vom Punkt (150,100) im Uhrzeigersinn (irrelevant, da voller Kreis) 
    arc(100, 100, 50, 0, 2*Math.PI, true);

    context.closePath();

* für Bogen: `fillStyle` setzen
* für Segment: `strokeStyle` setzen

### Text

    // umrahmte Buchstaben
    context.fillText(str, x, y, maxWidth);

    // ausgefüllte Buchstaben
    context.strokeText(str, x, y, maxWidth);

### Canvas "leeren"

    // ein Rechteck von Punkt (x,y) mit Breite w und Höhe h "leeren"
    context.clearRect(x, y, w, h);

## jQuery

    $(document).ready(function() {
        // ...
    });

    $('#element').html("change content");

    var pw = $('#password').val();
    $('#password').val('geheim');

    var numberOfDivs = $('div').length;
    var thirdDiv = $('div').get(3);
    var everyOtherDiv = $('div').eq(2);

    $('div').each(function(i) {
        var div = $(this).html('div number ' + i);
    });

    .next(selector);
    .prev(selector);
    .siblings(selector);
    .children(selector);
    .parent(selector);

    .is(property);
    .find(class);

    .html('<p>hello world</p>');
    .text('hello world');

    $('<h1>).replaceWith('<h1>CENSORED</h1>');
    $('<h1>CENSORED</h1>').replaceAll('h1');

    $('div').append('<p>...</p>');
    $('div').prepend('<p>...</p>');
    $('<p>...</p>').appendTo('div');
    $('<p>...</p>').prependTo('div');

    $('div').empty(); // remove all children
    $('div').remove(); // remove selection

    // put all odd paragraphs to the end
    $('div').remove('nth-child(odd)').appendTo('div');

    $('a').attr('href', 'index.html');
    $('img').attr({
        "src" : "screenshot.png",
        "alt" : "Screenshot"
    });
    $('img').removeAttr('alt');


    $('div').addClass('foo');
    $('div').removeClass('foo');
    $('div').toggleClass('hidden');
    $('div').css('border: 1px solid black;');
    $('div').css({
        "align" : "center",
        "color" : "red"
    });

    var h = $('div').height();
    h += 10;
    $('div').height(h);
    .innerWidth()
    .outerWidth()

    .show("fast");
    .hide("slow)";
    .toggle(100); // 100ms

    .slideUp("fast");
    .slideDown("slow");
    .slideToggle(100);

    .fadeIn("slow");
    .fadeOut(100);
    .fadeTo("fast", 0.5); // to opacity 0.5

## AJAX

### JavaScript

    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == XMLHttpRequest.DONE && xmlhttp.status == 200) {
            // do some stuff
        } else {
            // error, check xmlhttp.status for details
        }
    };
    xmlhttp.open("GET", "content.html", true); // true: async
    xmlhttp.send();

### jQuery

    $.ajax({
        type : 'GET',
        url : src,
        dataType : 'text/html',
        success : function(data) {
            // do something with data
        },
        dataType : "text"
    });

    $.ajax({
        type : 'GET',
        dataType : 'json',
        url : 'data/images.json',
        success : function(data) {
            // handle data
        },
        error : function(err, msg) {
            // handle err, msg
        }
    });

## Cookies

    // receive
    var cookie = document.cookie;

    // set with expiration date
    var expires = new Date();
    expires.setTime(expires.getTime() +
        (1000 * 3600 * 24 * 30)); // 30 days
    var cookieStr = 'style=' + styleName + 
        '; expires=' + expires.toUTCString();

# Internet Networking

## IP-Header

- Version
- Header Length
- Type of Service
- Total Length
- Identification
- Flags
- Offset
- Time to Live
- Protocol
- Checksum
- Source Address
- Destination Address
- Options and Padding

Header + Payload <= 63 kByte

## HTTP

- METHOD URL HTTP/Version
- Methoden: GET, POST, OPTIONS, HEAD, PUT, DELETE, TRACE, CONNECT
- Response Codes
    * 1xx: informelle Meldungen
    * 2xx: Erfolg
        - 200: OK
    * 3xx: weiterleiten
        - 301: Moved Permanently
    * 4xx: Clientfehler
        - 400: Bad Request
        - 401: Unauthorized
        - 403: Forbidden
        - 404: Not Found
    * 5xx: Serverfehler
        - 500: Internal Server Error
        - 503: Service Unavailable
