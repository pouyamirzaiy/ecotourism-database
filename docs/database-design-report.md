# Ecotourism Database Design and Implementation Report

## 1. Project overview

The project models the data requirements of an ecotourism platform intended to connect tourists with tourism-related services. The platform domain includes tourists, guides, destinations, activities, accommodation, transportation, and reservations.

The work follows the three phases in the coursework brief: requirements analysis, conceptual modelling, and SQL implementation.

## 2. Scope

The database stores:
- tourist profile and contact information;
- guide profile, spoken languages, skills, and ratings;
- destination descriptions and climate information;
- activities, duration, difficulty, preferred visiting period, and local cuisine;
- accommodation type, location, price, equipment requirements, and age limit;
- transportation type, schedule, price, capacity, and accessibility;
- reservations and their dates, status, payment state, total cost, and special requests.

The database is a coursework-scale relational design. It is not a complete booking product.

## 3. Conceptual entities

| Entity | Purpose | Primary key |
|---|---|---|
| Tourist | Stores people using the platform | tourist_id |
| Guide | Stores guide profiles | guide_id |
| Destination | Stores places offered by the platform | destination_id |
| Activity | Stores bookable or discoverable activities | activity_id |
| Accommodation | Stores lodging options | accommodation_id |
| Transportation | Stores transport options | transportation_id |
| Reservation | Records a tourist's selected services | reservation_id |

## 4. Relationships

The requirements identify the following relationships:

| Relationship | Cardinality | Relational implementation |
|---|---|---|
| Tourist–Activity | Many-to-many | tourist_activity |
| Tourist–Guide | Many tourists to one guide | tourist.guide_id |
| Tourist–Accommodation | A tourist may use accommodation; accommodation can serve many tourists | reservation foreign key |
| Tourist–Transportation | A tourist may use transport; transport can serve many tourists | reservation foreign key |
| Guide–Destination | Many-to-many | guide_destination |
| Activity–Destination | Many-to-many | activity_destination |
| Activity–Guide | Many-to-many | activity_guide |
| Guide–Accommodation | Many-to-many | guide_accommodation |
| Tourist–Destination | Many-to-many | tourist_destination |
| Accommodation–Destination | One destination to many accommodations | accommodation.destination_id |
| Transportation–Destination | Many-to-many | transportation_destination |
| Guide–Transportation | Many-to-many | guide_transportation |

A reservation references one tourist, activity, accommodation, and transportation option in this implementation. This follows the supplied Phase 3 relational structure. A more flexible commercial booking system might allow a reservation to contain multiple line items and optional service categories.

## 5. Relational design decisions

### 5.1 Primary keys

Each main entity has a generated integer primary key. Junction tables use composite primary keys formed from their two foreign keys. This prevents the same association from being inserted twice.

### 5.2 Foreign keys

Foreign keys enforce referential integrity between reservations, profile entities, and association tables. The revised schema uses `ON DELETE CASCADE` for junction-table rows so that associations are removed when a referenced record is deleted. Main reservation references use `ON DELETE RESTRICT` to avoid silently deleting booking history.

### 5.3 Domain and business constraints

The schema uses:
- positive-value checks for age, capacity, and duration;
- non-negative checks for prices and total cost;
- a 0–5 range for guide ratings;
- enumerated-value checks for activity difficulty, accommodation type, transportation type, reservation status, and payment status;
- a date-order check requiring check-out to be later than check-in;
- a unique constraint on tourist email.

### 5.4 Data types

`NUMERIC(10,2)` is used for monetary values to avoid floating-point rounding errors. `DATE` stores reservation and stay dates. `INTERVAL` stores activity duration. `TEXT[]` stores compact lists such as languages and equipment in this PostgreSQL implementation.

## 6. Normalization and future improvements

The design uses separate entity tables and junction tables for many-to-many relationships. Some multi-valued attributes remain arrays for simplicity. In a larger application, they could be normalized into dedicated tables, for example `guide_language`, `guide_skill`, `tourist_preference`, and `accommodation_equipment`.

Further improvements could include:
- a reservation-line model supporting multiple activities or services per booking;
- payment transactions rather than a single payment-status field;
- time-specific guide availability and transport schedules;
- destination-specific accommodation inventory;
- audit fields and soft deletion;
- automated tests and migration tooling.

## 7. Implementation

The PostgreSQL implementation is in `sql/01_schema.sql`. Fictional sample data is in `sql/02_sample_data.sql`. Demonstration queries are in `sql/03_example_queries.sql`. Read-only validation queries are in `sql/04_validation_checks.sql`.

## 8. Original coursework versus revised portfolio version

The supplied coursework report and diagrams are preserved in `original-material/` and `diagrams/`. The revised SQL is a cleaned-up implementation derived from the stated requirements. It adds relationship tables and integrity constraints that were missing from the supplied database export, and standardizes the implementation on PostgreSQL.

The original Phase 3 report contains MySQL-style syntax (`AUTO_INCREMENT` and `USE`) while the supplied database export is PostgreSQL. The revised implementation uses PostgreSQL consistently.

The original material labels Reservation as a weak entity, although it assigns Reservation its own identifier. In the relational implementation here, Reservation is modelled as a regular entity with a generated primary key.

## 9. Conclusion

The project demonstrates a basic database development workflow: analysing requirements, identifying entities and relationships, translating a conceptual model into relational tables, enforcing integrity constraints, and writing SQL queries. The repository is suitable as an academic portfolio example of relational database design and PostgreSQL fundamentals.
