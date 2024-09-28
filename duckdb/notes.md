# DuckDB

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

## Misc

Idea: analyze audit trail of Exoscale (JSON) with DuckDB
