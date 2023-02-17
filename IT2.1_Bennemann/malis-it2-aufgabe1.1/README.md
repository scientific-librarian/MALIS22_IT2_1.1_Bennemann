# Aufgabe 1.1 im Modul IT2 des MALIS

## Aufgabe

- Nach Vorgabe von validen (Ordner `examples/valid`) und nicht-validen (Ordner `examples/invalid`) Beispieldokumenten sowie eines Testskripts (`test.sh`), soll ein JSON-Schema erstellt werden.
- Die Dateien im `examples`-Ordner dürfen dabei **nicht** verändert werden, lediglich die Schema-Dateien im `schemas`-Ordner.
- Ergebnis: Ein JSON-Schema, dass die Dokumente entsprechend den Vorgaben (valide oder nicht-valide) validiert.

## Bewertungskriterien

Die Aufgabe ist bestanden, wenn das Testskript keine Fehler auswirft und die Beispieldateien im `examples`-Ordner sowie das Testskript selbst nicht verändert wurden.

## Lernziele

Die Teilnehmer:innen haben nach Bearbeitung der Aufgabe ein vertieftes Verständnis von JSON und JSON Schema.

## Abgabe

Es gibt zwei Möglichkeiten der Abgabe:

1. Anlegen eines Kontos bei [codeberg.org](https://codeberg.org), [gitlab.com](https://gitlab.com/) oder [github.com](https://gitlab.com/) und [`git push`](https://librarycarpentry.org/lc-git/03-sharing/index.html) des bearbeiteten Repos dorthin. Abgegeben werden muss dann nur der Link zum Repo.
2. Packen des `malis-it2-aufgabe1.1`-Ordners in ein zip-Archiv und Hochladen auf die Moodle-Plattform.

## Technische Voraussetzungen

### Shell

Von optimal zu weniger optimal:

1. Nutzung eines Linux-Systems (z.B. [Linux Mint Cinnamon Edition](https://linuxmint.com/edition.php?id=288))
1. Nutzung der Shell auf MacOS
1. Nutzung des Linux Subsystems für Windows

Siehe auch die [Installationstipps](https://malis21.acka47.net/#/page/installationstipps).

### Texteditor

Der Texteditor der Wahl. Falls noch keiner vorhanden, z.B. [VS Code](https://code.visualstudio.com/) oder die Telemetrie-freie Variante davon [VS Codium](https://vscodium.com/) oder [Atom](https://atom.io/), [Sublime Text](https://www.sublimetext.com/)...

### ajv-cli

ajv ist ein JSON Schema Validator für Node.js, der es ermöglicht, JSON anhand eines JSON-Schemas zu validieren. `ajv-cli` ermöglicht die Nutzung von ajv auf der Kommandozeile und in bash-Skripten. In Kontext dieser Aufgabe muss `ajv-cli` installiert werden, um auf dem eigenen System zu sehen, wie weit der Fortschritt bei der Lösung der Aufgabe ist.

Website: https://ajv.js.org/

<table><tr><td>ℹ️ Um ajv installieren zu können, müssen node und npm installiert sein. Siehe dazu https://docs.npmjs.com/cli/v8/configuring-npm/install.</td></tr></table>

Die [ajv-cli-Installation](https://ajv.js.org/guide/getting-started.html#install) (zusammen mit dem Paket `ajv-formats`, das ebenfalls benötigt wird) ist dann recht einfach mit dem folgenden Befehl umgesetzt:

`$ npm install -g ajv-cli ajv-formats`

### git (optional)

Idealerweise wird die Aufgabe mit git auf den lokalen Rechner geklont:

`$ git clone https://codeberg.org/acka47/malis-it2-aufgabe1.1.git` bzw. via ssh `$ git clone git@codeberg.org:acka47/malis-it2-aufgabe1.1.git`

Die Änderungen an den einzelnen Schema-Dateien werden mit git commits getrackt, z.B. nach Bearbeitung der `gender.json`-Datei:

- `$ git add .`
- `git commit -m "Ergänzung des "gender"-Schemas"`

Siehe für eine git-Einführung auch [https://librarycarpentry.org/lc-git/01-what-is-git/index.html](https://librarycarpentry.org/lc-git/01-what-is-git/index.html).

## Tipps für die Durchführung

Nachdem der Ordner der Aufgabe (per git oder auf anderem Wege) auf ihrem lokalen Rechner liegt und ajv installiert ist, kann die Bearbeitung der Aufgabe beginnen.

### Ausführen des Testskripts

Um das Testskript ausführen zu können, wechseln Sie in der Shell in das Verzeichnis zu dieser Übung, das Sie sich idealerweise mit `git clone` (siehe oben) auf Ihren lokalen Rechner gezogen haben.

`$ cd <pfad-zum-ordner>/malis-it2-aufgabe1.1`

Die Testdatei `test.sh` liegt als ausführbares Bash-Skript in diesem Ordner und wird wie folgt ausgeführt:

`$ sh ./test.sh`

### Der Test-Output

Wenn wir noch keine Änderungen an den Dateien im `schemas`-Ordner vorgenommen haben, sieht der Output wie folgt aus:

```shell
$ sh ./test.sh
examples/valid/1078122261.json passed test
examples/valid/119232022.json passed test
examples/valid/123191580.json passed test
examples/valid/124767095.json passed test
examples/invalid/gender-without-array.json failed test
examples/invalid/id-as-array.json failed test
examples/invalid/missing-context.json failed test
examples/invalid/missing-default-type.json failed test
examples/invalid/missing-gndIdentifier.json failed test
examples/invalid/missing-id.json failed test
examples/invalid/missing-preferredName.json failed test
examples/invalid/missingType.json failed test
examples/invalid/non-binary-gender.json failed test
examples/invalid/preferredName-as-array.json failed test
examples/invalid/profession-without-array.json failed test
examples/invalid/variant-name-without-array.json failed test
examples/invalid/wrong-context.json failed test
examples/invalid/wrong-geographic-are-code.json failed test
examples/invalid/wrong-id.json failed test
examples/invalid/wrong-profession-id.json failed test
```

Das Skript geht zunächst alle Dateien im `examples/valid`-Ordner durch und validiert diese gegen das Schema `schema.json`, das wiederum auf – aus >Gründen der Übersichtlichkeit in eigenen Dateien abgelegte – Unterschemas für jedes einzelne Feld verweist: in `id.json` wird definiert, wie das Feld `id` validiert werden soll, in `gndIdentifier.json`, das Feld `gndIdentifier` usw.

Da in diesen Schema-Dateien bisher keinerlei Bedingungen definiert sind, wird jede valide JSON-Datei den Test bestehen. Dementsprechend bestehen auch alle vier Dateien im `examples/valid`-Ordner die Tests.

Allerdings fallen alle Dateien im `examples/invalid`-Ordner anfangs durch den Test, weil dieser eben erwartet, dass die Dateien **nicht** Schema-konform sind.

### Das Ziel

Ziel ist es, die Schema-Dateien `context-schema.json`, `gender.json`, `geographicAreaCode.json`, `gndIdentifier.json`, `id.json`, `preferredName.json`, `professionOrOccupation.json`, `schema.json`, `type.json`, `variantName.json` so anzupassen, dass am Ende des `test.sh`-Outputs steht:

`-e All tests PASSED`

Eine sinnvolle Vorgehensweise ist:

- Schritt für Schritt die invaliden Dateien durchzugehen und das Schema jeweils so zu erweitern, dass sie als nicht-Schema-konform erkannt werden. Dafür muss die jeweilige Abweichung der invaliden Datei von den validen Dateien erkannt werden.

💡 Hinweis: Jede invalide Datei weicht nur in einer Eigenschaft von einer validen Datei ab. Der Dateiname deutet auf die Abweichung hin.

Viel Erfolg!

## Nützliche Online-Ressourcen

* Die Folien aus der Präsenzveranstaltung (vorerst noch vom MALIS21):
  * [Folien 13 bis 22 zu JSON](https://malis21.acka47.net/slides/2021-11-13.html#/13)
  * [Folien 39 bis 50 zu JSON Schema](https://malis21.acka47.net/slides/2021-11-13.html#/39)
* [Understanding JSON Schema](https://json-schema.org/understanding-json-schema/), eine übersichtliche und durchsuchbare JSON-Schema-Referenz
* Für manche Anpassungen muss eine *Regular Expression* geschrieben werden. Dafür gibt es auch hilfreiche Online-Tools, z.B.:
  * [RegExr](https://regexr.com/)
  * [RegEx101](https://regex101.com/)
  
  
  Output test.sh nach Schema Anwendung:
  


