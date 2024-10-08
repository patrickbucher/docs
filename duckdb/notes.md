# DuckDB

- [Heise](https://www.heise.de/blog/Ente-gut-alles-gut-DuckDB-ist-eine-besondere-Datenbank-9753854.html)
- OLAP: online analytical processing
- OLTP: online transactional processing

## Intro

- DuckDB allows you to analyze existing structured data efficiently without
  having to set up infrastructure.
- SQL can be used on top of different file formats without ingesting them into
  tables first.
- DuckDB allows for data transformation, cleanup, and conversion.
- It's an analytics database to efficiently process and query gigabytes of data
  from different sources.
- DuckDB is licensed under the MIT license.
- Data can be processed locally or remotely.
- Various formats are supported
    - files
        - CSV
        - JSON
    - data bases
        - SQLite
        - MySQL
        - PostgreSQL
    - DataFrames
        - Pandas
        - R (?)
- It can handle large amounts of data in seconds (gigabytes).
- Various interfaces are supported: CLI, API, low-level integration.
- The ANSI SQL standard is supported and extended, e.g. with transposition of
  rows/columns, a struct data type.
- DuckDB is:
    - fast
    - easy to use and set up
    - low on resource requirements
    - fast and powerful for data transformation
- SQL can be used directly on structured data without prior ingestion.
- However, DuckDB is _not_ for streaming data; the data must be available (at
  least in batches).
- The data doesn't need to be copied and, thus, can stay on the system.
- DuckDB is _not_ for applications with transactions. It is lightweight as
  SQLite, but has an other purpose. (It's an analytics engine, not a
  transactional data storage.)
- The amount of data that can be processed is limited by the memory available;
  some swapping to disk is possible.
- Nested data can be flattened. No schema needs to be defined upfront; it is
  inferred from the data (and available meta data).
- In addition to the standard data types (varchar, numeric, blog etc.), data
  structures like enums, lists/arrays, maps, and structs are available.
- Powerful aggregations (`SUMMARIZE` clause) are available:
    - statistics: `count`, `min`, `max`, `avg`, `std`, `percentiles`
    - data analysis: `approx_unique`, `null_percentage`
    - visualization: `histogram`, `bar`
- Data can easily be converted with functions (e.g. `strptime`).
- Window functions and subqueries are available, too.
- Data can be dumped using `CREATE TABLE <name> AS SELECT`.

## Getting Started

- DuckDB works on different operating systems (Linux, Windows, macOS) and
  architectures (Intel/AMD and ARM). Various programming languages are
  supported, e.g. Python, JavaScript, Go, Rust. DuckDB can also be used as a
  command line tool.
- The DuckDB CLI can be downloaded from the [GitHub
  Release](https://github.com/duckdb/duckdb/releases) page.
    - For Linux, download the `duckdb_cli-linux-amd64.zip` archive, unzip it,
      and copy the file `duckdb` to `~/.local/bin`.
- The CLI supports various "dot" commands:
    - `.open FILENAME`: open a new database file
    - `.read FILENAME`: read a file containing SQL commands
    - `.tables`: list tables/views
    - `.timer on/off`: toggles SQL timing output
    - `mode`: controls output formats
        - `duckbox`: boxed output (adjusted to display size)
        - `box`: boxed output (complete)
        - `csv`
        - `ascii`
        - `table`
        - `list`
        - `column`
        - `json`
        - `jsonline`
        - `line`
        - `html`
        - `insert`: SQL insert statements
        - `trash`: discard output
    - `.maxrows`: truncates the number of rows to be displayed
    - `.excel`: output as Excel spreadsheet
    - `.prompt '°> '`: set the prompt to `°>`
    - `.exit` or `.quit`: exit the CLI
    - `.help`: display help
- Default options/commands can be defined in `~/.duckdbrc`
- The CLI supports various options: `duckdb [OPTIONS] FILENAME [COMMANDS]`:
    - `-readonly`: open database in read-only mode
    - `-json`/`-line`: sets output mode to `json`/`line`
    - `-unsigned`: allows for loading unsigned extensions
    - `-s COMMAND`/`-c COMMAND`: runs a provided command and then exits
    - `-help`: lists all CLI arguments
- DuckDB supports extensions:
    - Extensions can be queried using the `duckdb_extensions()` function:
        - `SELECT extension_name, loaded, installed FROM duckdb_extensions();`
    - Extensions can be installed using the `INSTALL` and activated using the
      `LOAD` command:
        - `INSTALL httpfs;`
        - `LOAD httpfs;`
        - This installs/loads an extension to query files to be loaded from the
          Internet. (Also supports S3 buckets.)

### Example

Download [population
data](https://github.com/bnokoro/Data-Science/blob/master/countries%20of%20the%20world.csv)
from this CSV file as `population.csv`.

    $ duckdb
    D select * from population.csv;

Convert to JSON:

    $ duckdb -json -c 'select * from "population.csv";' >population.json

### Superleague

    select * from "superleague.json";

    create table league as select * from "superleague.json";

    create view goals as
    select homeTeam, awayTeam, homeGoals, awayGoals, (homeGoals + awayGoals) as goals
    from league;

    select * from goals order by goals desc;

    export database './football';

    import database './football';

### Exoscale

    describe from exoscale.json;

    from exoscale.json select unnext("iam-role") as row;

## Misc

Idea: analyze audit trail of Exoscale (JSON) with DuckDB
