# Introduction

Install SQLAlchemy:

    pip install sqlalchemy

Create an engine as the interface to a database with pooled connections, then
connect to the database:

    from sqlalchemy import create_engine
    engine = create_engine(connection_string)
    connection = engine.connect()

The `connection_string` consists of the following parts:

1. database type
    - `postgresql`
    - `mysql`
    - `sqlite`
2. dialect (driver)
    - `psycopg2`
    - `pymysql`
3. credentials: `username:password`
4. host indicator
5. port

Example connection strings (PostgreSQL, MySQL, SQLite persistent, and SQLite
in-memory):

    'postgresql+psycopg2://username:password@localhost:5432/database'
    'mysql+pymysql://username:password@localhost'
    'sqlite:///database.db'
    'sqlite:///:memory:'

`create_engine` takes optional keyword arguments:

- `echo` (boolean): log SQL statements and parameters
- `encoding` (string): `'utf-8'` by default
- `isolation_level` (string): vendor specific
- `pool_recycle` (integer): timeout in seconds (`-1` for no timeout)
