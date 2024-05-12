# PostgreSQL concepts

This folder contains scripts to generate useful abstractions of raw MIMIC-IV data ("concepts"). The
scripts are intended to be run against the MIMIC-IV data in a PostgreSQL database.
If you would like to contribute a correction, it should be for the corresponding file in the concepts folder.

To generate concepts, change to this directory and run `psql`. Then within psql, run:

```sql
\i postgres-make-concepts.sql
```

... or, run the SQL files in your GUI of choice.

The postgres-functions.sql contains definitions for a few functions which exist in BigQuery but do not exist in PostgreSQL. It is not required but these functions are convenient if you find yourself switching back and forth between the two.


```sql
\i E:/workspace/mimic/mimic-code/mimic-iv/concepts_postgres/postgres-functions.sql
\cd E:/workspace/mimic/mimic-code/mimic-iv/concepts_postgres
\i E:/workspace/mimic/mimic-code/mimic-iv/concepts_postgres/postgres-make-concepts.sql

```
