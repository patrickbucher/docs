# Security

- Role: user or group of users; independent of operating system user
    - objects and rihts on them can be assigned to roles

## Creating Roles

- create role: `CREATE ROLE foobar;`
- add login permission: `ALTER ROLE foobar LOGIN;`
- a user is a role with `LOGIN` permission:
    - `CREATE USER foobar;`
- additional role attributes:
    - `LOGIN`: login to cluster
    - `SUPERUSER`: circumvent all security checks
    - `CREATEDB`: create databases
    - `CREATEROLE`: create, edit, and delete roles; except `SUPERUSER` roles
    - `PASSWORD`: define a password
- the initial `postgres` user is a `SUPERUSER`

## Granting Rights

- by default, an object belongs to its creator
- grant rights: `GRANT SELECT on table TO role;`
- revoke rights: `REVOKE SELECT on table TO role;`

## User/Role Hierarchies

- A role can both be a specific user and a group of users.
- add user (`joe`) to a role (`managers`):
    - `CREATE ROLE managers;`
    - `CREATE ROLE joe;`
    - `GRANT managers TO joe`;
- temporarely use rights of another role (for the duration of a session):
    - `SET ROLE foobar`;
    - reset: `SET ROLE;`

## Miscellaneous

- query roles: `\du`
- relevant views: `pg_roles` (roles), `pg_authid` (passwords)
- set a password: `ALTER USER foobar PASSWORD 'topsecret';`

