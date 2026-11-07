# Requirements and assumptions

## Requirements taken from the coursework brief

The platform is intended to connect ecotourism providers and customers. The database assignment is divided into:

1. **Phase 1 – Requirements analysis:** identify entities, attributes, primary keys, relationships, cardinalities, optionality, and weak entities.
2. **Phase 2 – Modelling:** create ER and UML diagrams and document assumptions.
3. **Phase 3 – SQL implementation:** map entities to tables, select data types, define primary and foreign keys, apply constraints, and document the SQL.

## Main entities and attributes

- **Tourist:** name, age, email, phone number, nationality, travel history, preferences.
- **Guide:** name, languages spoken, special skills, ratings.
- **Destination:** name, location, climate, description.
- **Activity:** name, description, duration, difficulty level, best time to visit, local cuisine.
- **Accommodation:** name, type, location, price range, equipment needed, age limit.
- **Transportation:** type, schedule, price, capacity, accessibility.
- **Reservation:** tourist, activity, accommodation, transportation, reservation date, status, payment status, total cost, special requests, check-in date, check-out date.

## Assumptions introduced for the revised implementation

These are implementation choices, not claims that every detail was explicit in the original brief:

- Every main entity has a generated integer identifier.
- A tourist can be assigned to zero or one guide; a guide can be assigned to multiple tourists.
- Accommodation belongs to one destination; a destination can contain multiple accommodations.
- The many-to-many relationships are implemented with junction tables.
- A reservation references one tourist, one activity, one accommodation, and one transportation option, matching the structure of the supplied Phase 3 schema.
- A reservation has a generated `reservation_id`; it is therefore treated as a regular entity in the relational schema rather than a weak entity.
- Sample data is fictional.
- Optionality is represented with nullable foreign keys where a relationship may not yet be assigned. Reservation service references are required in the supplied model and remain `NOT NULL`.

## Known gaps in the supplied original implementation

- Several conceptual relationships were not represented in the original PostgreSQL export.
- The original SQL report mixes MySQL syntax with a PostgreSQL export.
- Several constraints described in the report were not enforced in the exported schema.
- The Phase 3 report contains a UML heading but no UML diagram content in the supplied text.
