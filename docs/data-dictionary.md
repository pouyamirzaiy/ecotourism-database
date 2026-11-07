# Data dictionary

## Main tables

| Table | Important columns | Notes |
|---|---|---|
| tourist | tourist_id, guide_id, name, age, email, phone_number, nationality, travel_history, preferences | `guide_id` is nullable; email is unique. |
| guide | guide_id, name, languages_spoken, special_skills, rating | Rating is constrained to 0–5. |
| destination | destination_id, name, location, climate, description | Destination catalogue. |
| activity | activity_id, name, description, duration, difficulty_level, best_time_to_visit, local_cuisine | Duration must be positive. |
| accommodation | accommodation_id, destination_id, name, type, location, price_per_night, equipment_needed, age_limit | Belongs to one destination. |
| transportation | transportation_id, type, schedule, price, capacity, accessibility | Price is non-negative; capacity is positive. |
| reservation | reservation_id, tourist_id, activity_id, accommodation_id, transportation_id, reservation_date, status, payment_status, total_cost, special_requests, check_in_date, check_out_date | Check-out must be later than check-in. |

## Junction tables

Each junction table has a composite primary key and foreign keys to the related entities.

- `tourist_activity(tourist_id, activity_id)`
- `tourist_destination(tourist_id, destination_id)`
- `guide_destination(guide_id, destination_id)`
- `activity_destination(activity_id, destination_id)`
- `activity_guide(activity_id, guide_id)`
- `guide_accommodation(guide_id, accommodation_id)`
- `transportation_destination(transportation_id, destination_id)`
- `guide_transportation(guide_id, transportation_id)`
