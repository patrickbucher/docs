# Setup

Setup PostgreSQL on Arch Linux:

    # pacman -S postgresql
    # mkdir /var/lib/postgres/data
    # chown -R postgres:postgres /var/lib/postgres/data
    # sudo -iu postgres initdb --locale en_US.UTF-8 -E UTF8 -D /var/lib/postgres/data
    # systemctl enable --now postgresql.service

Create a role for your user (e.g. `joe`) able to create databases (`-d`):

    # sudo -iu postgres createuser -d joe

Create your database:

    $ createdb 7dbs

Open the command prompt:

    $ psql 7dbs

# Day 1

Get help about SQL commands:

    =# \h SELECT

Show help about PostgreSQL commands:

    =# \?

Create a table:

```sql
CREATE TABLE country (
    country_code char(2) PRIMARY KEY,
    country_name text UNIQUE
);
```

Inserting data:

```sql
INSERT INTO country (country_code, country_name)
VALUES ('ch', 'Switzerland'), ('de', 'Germany'), ('us', 'United States'),
       ('at', 'Austria'), ('it', 'Italy'), ('ml', 'Molvania');
```

Query data:

```sql
SELECT * FROM country;
```

Delete data:

```sql
DELETE FROM country WHERE country_code = 'ml';
```

Create a table with a foreign key and a compound primary key:

```sql
CREATE TABLE city (
    name text NOT NULL,
    postal_code varchar(9) CHECK (postal_code <> ''),
    country_code char(2) REFERENCES country,
    PRIMARY KEY (country_code, postal_code)
);
```

Insert data with a reference (ok):

```sql
INSERT INTO city (name, postal_code, country_code)
VALUES ('Zurich', '8001', 'ch'), ('Berlin', '10115', 'de'), ('Vienna', '1010', 'at');
```

Insert data without a reference (failure):

```sql
INSERT INTO city (name, postal_code, country_code)
VALUES ('Paris', '75000', NULL), ('Toronto', '66777', NULL), ('Lima', '02002', NULL);
```

Update data:

```sql
UPDATE city SET postal_code = '8000' WHERE name = 'Zurich';
```

Join read:

```sql
SELECT city.*, country_name
FROM city
INNER JOIN country ON city.country_code = country.country_code;
```

Create a table with compound foreign key and enum-like `type` column:

```sql
CREATE TABLE venue (
    venue_id SERIAL PRIMARY KEY,
    name varchar(255),
    street_address text,
    type char(7) CHECK (type in ('public', 'private')) DEFAULT 'public',
    postal_code varchar(9),
    country_code char(2),
    FOREIGN KEY (country_code, postal_code)
        REFERENCES city (country_code, postal_code) MATCH FULL
);
```

Insert an entry with a compound foreign key:

```sql
INSERT INTO venue (name, postal_code, country_code) VALUES
    ('Olympiastadion', '10115', 'de'),
    ('Burgtheater', '1010', 'at'),
    ('Sechseläutenplatz', '8000', 'ch');
```

Shorten referenced table name using an alias with the `AS` keyword:

```sql
SELECT v.venue_id, v.name AS venue, c.name AS city
FROM venue AS v
INNER JOIN city AS c ON
    v.postal_code = c.postal_code AND
    v.country_code = c.country_code;
```

The same without the `AS` keyword:

```sql
SELECT v.venue_id, v.name venue, c.name city
FROM venue v
INNER JOIN city c ON
    v.postal_code = c.postal_code AND
    v.country_code = c.country_code;
```

Insert an entry and return a value of that entry (especially useful for
generated values, like a `SERIAL` id):

```sql
INSERT INTO venue (name, postal_code, country_code) VALUES
    ('Reichstag', '10115', 'de') RETURNING venue_id;
```

Create a table with timestamps and a (non-mandatory) foreign-key column and add
some values into it:

```sql
CREATE TABLE event (
    event_id SERIAL PRIMARY KEY,
    title text,
    starts timestamp,
    ends timestamp,
    venue_id integer,
    FOREIGN KEY (venue_id)
        REFERENCES venue (venue_id)
);

INSERT INTO event (title, starts, ends, venue_id) VALUES
    ('Sechseläuten', '2022-04-25 18:00:00', '2022-04-25 22:00:00', 3),
    ('Fronleichnam', '2022-06-16 00:00:00', '2022-06-16 23:59:50', NULL),
    ('Pfingstmontag', '2022-06-06 00:00:00', '2022-06-06 23:59:50', NULL);
```

Query events with venues as an inner join (yielding only events with a venue):

```sql
SELECT e.title event, e.starts, e.ends, v.name as venue
FROM event e
INNER JOIN venue v ON (e.venue_id = v.venue_id);
```

Query events with venues as an outer join (yielding events with or without a venue):

```sql
SELECT e.title event, e.starts, e.ends, v.name as venue
FROM event e
LEFT OUTER JOIN venue v ON (e.venue_id = v.venue_id);
```

`INNER JOIN` can be shortened as `JOIN`, and `LEFT OUTER JOIN` as `LEFT JOIN`
(the `OUTER` is implied; same for `RIGHT OUTER JOIN`). A `FULL OUTER JOIN`
combines `LEFT JOIN` and `RIGHT JOIN`: yielding rows with missing references on
both sides.
