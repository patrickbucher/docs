# Practical SQL

- Book: [Practical SQL, 2nd Edition](https://github.com/anthonydb/practical-sql-2/)
- Repository: [anthonydb/practical-sql-2](https://github.com/anthonydb/practical-sql-2/)

## Setup

### Arch Linux

Install PostgreSQL:

    sudo pacman -S postgresql

Initialize the database cluster as `postgres` with proper locale and encoding:

    sudo -u postgres initdb --locale en_US.UTF-8 --encoding UTF8 -D /var/lib/postgres/data

Enable and start the service:

    sudo systemctl enable --now postgresql.service

### Debian GNU/Linux

Install PostgreSQL (version 15 on Debian 12 "Bookworm"):

    sudo apt install -y postgresql

The service `postgresql@15-main.service` is started automatically.

### Basic Configuration

Connect to the database `postgres` using the `postgres` user:

    sudo -u postgres psql postgres

Check version:

    # select version();

Set a password for the `postgres` user:

    # \password postgres

Create an additional user (same as the operating system user), e.g. `debian`:

    # create user debian superuser;

Connect to the database `postgres` using the `debian` user:

    psql postgres debian

By default, PostgreSQL uses _peer authentication_, i.e. the user information
provided by the operating system. The authentication method can be switched
from `peer` to `md5` in `pg_hba.conf`. Its path can be obtained as follows:

    # show hba_file;

## Create Databases and Tables

Create a database `company`:

```sql
create database company;
```

Create a table `employee`:

```sql
create table employee (
    id serial,
    first_name varchar(50),
    last_name varchar(50),
    born date,
    hired date,
    salary numeric
);
```

Insert some records:

```sql
insert into employee
    (first_name, last_name, born, hired, salary)
values
    ('Bertram', 'Gilfoyle', '1983-05-13', '2012-04-01', 120000),
    ('Erlich', 'Bachmann', '1975-01-31', '2012-01-01', 250000),
    ('Jared', 'Dunn', '1978-11-20', '2012-08-01', 80000);
```

## Selecting Data

PostgreSQL supports various comparison and matching operators:

- `=`: equality
- `<>`: inequality
- `!=`: inequality (non-standard!)
- `<`, `>`, `<=`, `>=`: less than, greater than, less than or equal, greater than or equal
- `between`: range check (inclusive on both ends), e.g. `where salary between 100000 and 200000`
- `in`: match in a set of values, e.g. `where grade in ('A', 'B', 'C')`
- `like`: pattern matching (case sensitive)
- `ilike`: pattern matching (non-standard!)
- `not`: negation of condition

The `like` and `ilike` operators support patterns using wildcards:

- `%`: one or more characters
- `_`: one character

## Data Types

- textual
    - `char(n)`: fixed-length with `n` characters, hardly used
    - `varchar(n)`: variable-length with max. `n` characters
    - `text`: variable-length without limit, non-standard
- numeric
    - integers
        - `smallint`: ~short (2 bytes)
        - `integer`: ~int (4 bytes)
        - `bigint`: ~long (8 bytes)
    - serials (non-standard auto increment), sizes as integer data types
        - `smallserial`
        - `serial`
        - `bigserial`
    - identity (standard, more verbose)
        - `id integer generated always as identity`: always automatic value
        - `id integer generated by default as identity`: automatic value if missing
    - decimals (fixed width, non-standard)
        - `numeric(precision, scale)` or `decimal(precision, scale)`
            - `precision`: total number of digits
            - `scale`: number of digits right of the comma
    - floating poitns (standard)
        - `real`: ~float (4 bytes)
        - `double precision`: ~double (8 bytes)
- temporal
    - `timestamp`: date & time (8 bytes)
    - `timestamptz`: date, time & time zone
    - `date`: date only (4 bytes)
    - `time`: time only (8 bytes)
    - `interval`: supporting textual indications, e.g. `3 days` (16 bytes)
- json
    - `json`: exact textual copy
    - `jsonb`: binary representation of JSON data structure (allows for indexing)
- others
    - UUID
    - `boolean`
    - geometric types
    - text search types
    - network address types
    - range
    - binary data
    - XML

Casting syntax:

    cast(COLUMN as TYPE)
    COLUMN::TYPE

## Math

When mixing data types, casting takes place as follows: `integer` -> `numeric` -> `float`.

- Arithmetic Operators
    - addition: `+`
    - subtraction: `-`
    - multiplication: `*`
    - division: `\`
    - exponentiation: `^`
    - square root: `|/` or `sqrt`
    - cube root: `||/`
    - factorial: `factorial(x)`
- Aggregate Functions (working on columns)
    - sum: `sum`
    - average: `avg`
    - percentiles
        - `percentile_cont(n)`: continuous percentiles (uses average of middle
          two items if needed; median)
        - `percentile_disc(n)`: discrete percentiles (returns the closest
          member of the set)
    - mode: `mode`

Percentile syntax:

    select percentile_cont(0.5) within group (order by pages) from book;

Quartiles (using an array):

    select percentile_disc(array[0.25,0.50,0.75]) within group (order by pages) from book;

Unpack resulting array into rows:

    select unnest(percentile_disc(array[0.25,0.50,0.75]) within group (order by pages)) from book;

see also: `select * from pg_operator;`

## Joins

Syntax:

    select * from foo join bar on foo.key = bar.key;

Using table aliases:

    select * from foo as f join bar as b on f.key = b.key;

Same, without `as` (shorter but equivalent):

    select * from foo f join bar b on f.key = b.key;

If the column to be joined on has the same name on both sides, the syntax can
be simplified:

    select * from foo f join bar b using key;

There are different types of joins:

- `join` or `inner join`: results that exist on both sides
- `left join`: all results from the left side, combined with results from the right side, or empty (if missing)
- `right join`: all results from the right side, combined with results from the left side, or empty (if missing)
- `full outer join`: all results from both sides, or empty (if missing)
- `cross join`: carthesian product (combining each left entry with each right entry)

Multiple queries can be combined using the following set operations:

- `union`: append rows of both query results
- `union all`: same, but retain duplicates
- `intersect`: intersection of query results
- `except`: difference (results from first query result that do not exist in
  the second query result)

## Table Design

Commonly, `snake_case` is used in PostgreSQL. Unless wrapped in double quotes,
identifiers are converted automatically to lowercase. Identifiers are limited
to a length of 63 characters.

There are different kinds of constraints:

- `primary key`: unique identifier
    - natural key: one or more data columns
    - surrogate key: additional, artificial key (serial, UUID)
- `check`: validation predicates
- `unique`: non-null entries must be unique
- `not null`: value required

Constraints can be defined:

- for the column
    - `id integer constraint customer_pk primary key` (the name is set to `customer_pk` manually)
    - `id integer constraint primary key` (the name is set automatically)
- for the table
    - `constraint customer_pk primary key (first_name, last_name, birthdate)`

Automatically generated ids can be overwritten:

1. `insert into … overriding system value … (17, …);`
2. `alter table … alter column id restart with 18;`

Foreign keys:

- column definition: `customer_id integer references customer (id)`
- with cascading deletion: `customer_id integer references customer (id) on delete cascade`

Check constraints:

- table definition
    - `constraint check_grade check (grade in ('A', 'B', 'C', 'D', 'E', 'F'))`
    - `constraint min_wage check (wage >= 40000)`

Remove constraints:

- drop a `check` constraint: `alter table … drop constraint …;`
- drop `not null` definition on a column: `alter table … alter column … drop not null;`
- add `not null` definition on a column: `alter table … alter column … set not null;`

Indexes:

- a B-Tree (balanced tree) index is automatically created for primary keys
- indices speed up `select` queries, but slow down insertion (re-balancing of the index tree required)
- an index can be added manually
    - add index: `create index name_index on customer (name);`
    - remove index: `alter table customer drop index name_index;`

## Using `psql`

Execute query from a script (`employee.sql`) on a particular database (`company`):

    psql company -f employee.sql

## Import/Export

Import from CSV:

```sql
copy TABLE from 'PATH' with (format csv, header, delimiter ',', quote '"');
```

Export to CSV:

```sql
copy TABLE to 'PATH' with (format csv, header, delimiter ',', quote '"');
```

Options:

- format: `csv`, `text`, `binary`
- header: ignore first row (PostgreSQL won't match CSV headers to table columns)
- delimiter: field delimiter (`,` by default)
- quote: quotation character (`"` by default)

Import/Export only a subset of columns:

```sql
copy table (col1, col2, …, col3) …
```

Since PostgreSQL 12, import also works with a `where` clause.

Create a temporary table for import:

```sql
create temporary table NAME (like ORIGINAL_TABLE_NAME including all);
```

Using `including all`, indexes, constraints and the like are also copied from the original table.

Export a query result:

```sql
copy (select …) …
```

Hint: If access to the CSV file is denied, use `\copy` instead of `copy`.
