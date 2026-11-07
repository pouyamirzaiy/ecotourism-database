# Ecotourism Database

A PostgreSQL relational database for an ecotourism platform. The coursework brief describes a platform connecting tourists with ecotourism destinations, guides, activities, accommodation, and transportation.

This repository contains:
- requirements and design documentation based on the three coursework phases;
- the original ER/schema images supplied with the coursework;
- a cleaned-up PostgreSQL implementation;
- sample data and example SQL queries.

> **Coursework and refinement note:** The original coursework artifacts are preserved in `original-material/` and `diagrams/`. The SQL in `sql/` is a revised, internally consistent portfolio implementation based on the requirements. It is not a byte-for-byte copy of the original database export. The revised schema makes several explicit design decisions and adds integrity constraints and relationship tables that were described in the requirements but were not present in the supplied export.

## Technology

- PostgreSQL 14+ (uses identity columns, arrays, `CHECK` constraints, and `NUMERIC`)
- SQL
- ER modelling / relational schema design

## Domain model

Core entities:
- `tourist`
- `guide`
- `destination`
- `activity`
- `accommodation`
- `transportation`
- `reservation`

Associative tables represent many-to-many relationships:
- `tourist_activity`
- `tourist_destination`
- `guide_destination`
- `activity_destination`
- `activity_guide`
- `guide_accommodation`
- `transportation_destination`
- `guide_transportation`

`accommodation.destination_id` represents the one-to-many Accommodation–Destination relationship. `tourist.guide_id` represents the stated rule that each tourist may be assigned to one guide, while a guide may serve multiple tourists. A reservation connects a tourist with a selected activity, accommodation, and transportation option.

## Repository layout

```text
ecotourism-database/
├── README.md
├── docs/
│   ├── database-design-report.md
│   ├── requirements-and-assumptions.md
│   └── data-dictionary.md
├── diagrams/
│   ├── ecotourism-er-diagram.mmd
│   ├── original-hand-drawn-er.png
│   └── original-postgresql-schema.png
├── original-material/
│   └── phase-3-original-report.txt
└── sql/
    ├── 01_schema.sql
    ├── 02_sample_data.sql
    ├── 03_example_queries.sql
    └── 04_validation_checks.sql
```

## Run locally

Create a database, then run the scripts in order:

```bash
createdb ecotourism
psql -d ecotourism -f sql/01_schema.sql
psql -d ecotourism -f sql/02_sample_data.sql
psql -d ecotourism -f sql/03_example_queries.sql
psql -d ecotourism -f sql/04_validation_checks.sql
```

Alternatively, from `psql`:

```sql
CREATE DATABASE ecotourism;
```

Then connect to it and execute the four scripts in order. `01_schema.sql` creates objects in the current database; it does not create the database itself.

## Example queries

`sql/03_example_queries.sql` includes examples of:
- joining reservations to tourists, activities, accommodation, and transportation;
- counting reservations by destination;
- finding activities by destination and difficulty;
- calculating guide ratings;
- identifying popular activities;
- revenue summaries;
- tourists who have not made a reservation;
- checking upcoming stays.

## Design notes and limitations

1. The original brief calls Reservation a weak entity, but the supplied design gives it its own `reservation_id`. In the revised relational schema it is modelled as a regular entity with a surrogate primary key and foreign keys to its related records.
2. The requirements describe several many-to-many relationships. The revised implementation represents these with junction tables.
3. `languages_spoken`, `special_skills`, `travel_history`, `preferences`, `equipment_needed`, and `local_cuisine` are PostgreSQL text arrays for a compact coursework-scale implementation. A larger production system could normalize these into lookup and association tables.
4. The project does not implement a web application, authentication, booking concurrency, payment processing, or deployment infrastructure.
5. Sample records are fictional and included only to demonstrate queries.
6. The ER diagram in Mermaid is a logical overview. The supplied original diagrams are retained separately as coursework artifacts.

## Validation

Run:

```bash
psql -d ecotourism -f sql/04_validation_checks.sql
```

The validation script runs read-only checks and returns rows that should be empty when the sample data satisfies the documented rules. It does not replace automated integration tests.

## Academic context

This repository is based on a three-phase university database project:
1. requirements analysis and entity identification;
2. ER/UML modelling;
3. SQL implementation and table creation.

The original coursework material is retained separately from the revised implementation so the distinction between submitted work and later portfolio cleanup remains clear.
