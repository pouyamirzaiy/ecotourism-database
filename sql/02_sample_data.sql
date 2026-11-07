-- Fictional demonstration data only. Do not use as real customer information.

INSERT INTO guide (guide_id, name, languages_spoken, special_skills, rating) VALUES
(1, 'Mina Rahimi', ARRAY['English', 'Persian'], ARRAY['Birdwatching', 'Hiking'], 4.80),
(2, 'Arman Kiani', ARRAY['English', 'German'], ARRAY['Rock climbing', 'First aid'], 4.60);

INSERT INTO destination (destination_id, name, location, climate, description) VALUES
(1, 'Alborz Foothills', 'Northern Iran', 'Mountain', 'Mountain villages and hiking routes.'),
(2, 'Hyrcanian Forest', 'Northern Iran', 'Humid subtropical', 'Forest landscapes and biodiversity.'),
(3, 'Kavir Edge', 'Central Iran', 'Arid', 'Desert scenery and night-sky observation.');

INSERT INTO tourist (tourist_id, guide_id, name, age, email, phone_number, nationality, travel_history, preferences) VALUES
(1, 1, 'Alex Morgan', 29, 'alex@example.test', '+10000000001', 'German', ARRAY['Berlin', 'Vienna'], ARRAY['Hiking', 'Local food']),
(2, 1, 'Sam Taylor', 34, 'sam@example.test', '+10000000002', 'Dutch', ARRAY['Amsterdam'], ARRAY['Birdwatching']),
(3, 2, 'Jordan Lee', 26, 'jordan@example.test', '+10000000003', 'Canadian', ARRAY['Toronto'], ARRAY['Climbing', 'Camping']);

INSERT INTO activity (activity_id, name, description, duration, difficulty_level, best_time_to_visit, local_cuisine) VALUES
(1, 'Guided Forest Hike', 'A guided walk through forest trails.', INTERVAL '4 hours', 'Moderate', 'Spring and autumn', ARRAY['Herb rice', 'Local bread']),
(2, 'Birdwatching Tour', 'Observe native and migratory bird species.', INTERVAL '3 hours', 'Easy', 'Spring', ARRAY['Local stew']),
(3, 'Rock Climbing', 'Introductory climbing session with a guide.', INTERVAL '5 hours', 'Challenging', 'Late spring', ARRAY['Mountain tea']);

INSERT INTO accommodation (accommodation_id, destination_id, name, type, location, price_per_night, equipment_needed, age_limit) VALUES
(1, 1, 'Mountain Guesthouse', 'Other', 'Alborz village', 45.00, ARRAY['Hiking shoes'], NULL),
(2, 2, 'Forest Eco Lodge', 'Hotel', 'Hyrcanian Forest area', 68.50, ARRAY['Rain jacket'], NULL),
(3, 3, 'Desert Camp', 'Camping Site', 'Kavir Edge', 32.00, ARRAY['Sleeping bag', 'Water bottle'], 18);

INSERT INTO transportation (transportation_id, type, schedule, price, capacity, accessibility) VALUES
(1, 'Bus', 'Daily morning departure', 12.00, 40, 'Wheelchair access on selected services'),
(2, 'Train', 'Evening service on selected days', 25.00, 180, 'Step-free boarding at major stations'),
(3, 'Other', 'Pre-arranged local transfer', 18.00, 8, 'Contact provider before booking');

INSERT INTO reservation
(reservation_id, tourist_id, activity_id, accommodation_id, transportation_id, reservation_date, status, payment_status, total_cost, special_requests, check_in_date, check_out_date)
VALUES
(1, 1, 1, 1, 1, CURRENT_DATE, 'Confirmed', 'Paid', 102.00, 'Vegetarian meal request', CURRENT_DATE + 14, CURRENT_DATE + 16),
(2, 2, 2, 2, 2, CURRENT_DATE, 'Pending', 'Unpaid', 161.50, NULL, CURRENT_DATE + 30, CURRENT_DATE + 32),
(3, 3, 3, 3, 3, CURRENT_DATE, 'Confirmed', 'Paid', 100.00, 'Please confirm climbing equipment', CURRENT_DATE + 45, CURRENT_DATE + 46);

INSERT INTO tourist_activity VALUES
(1, 1), (1, 2), (2, 2), (3, 3);

INSERT INTO tourist_destination VALUES
(1, 1), (1, 2), (2, 2), (3, 3);

INSERT INTO guide_destination VALUES
(1, 1), (1, 2), (2, 1), (2, 3);

INSERT INTO activity_destination VALUES
(1, 1), (1, 2), (2, 2), (3, 1);

INSERT INTO activity_guide VALUES
(1, 1), (2, 1), (3, 2);

INSERT INTO guide_accommodation VALUES
(1, 1), (1, 2), (2, 3);

INSERT INTO transportation_destination VALUES
(1, 1), (1, 2), (2, 2), (3, 3);

INSERT INTO guide_transportation VALUES
(1, 1), (1, 2), (2, 3);

-- Keep identity sequences in sync after explicit demonstration IDs.
SELECT setval(pg_get_serial_sequence('guide', 'guide_id'), (SELECT MAX(guide_id) FROM guide));
SELECT setval(pg_get_serial_sequence('destination', 'destination_id'), (SELECT MAX(destination_id) FROM destination));
SELECT setval(pg_get_serial_sequence('tourist', 'tourist_id'), (SELECT MAX(tourist_id) FROM tourist));
SELECT setval(pg_get_serial_sequence('activity', 'activity_id'), (SELECT MAX(activity_id) FROM activity));
SELECT setval(pg_get_serial_sequence('accommodation', 'accommodation_id'), (SELECT MAX(accommodation_id) FROM accommodation));
SELECT setval(pg_get_serial_sequence('transportation', 'transportation_id'), (SELECT MAX(transportation_id) FROM transportation));
SELECT setval(pg_get_serial_sequence('reservation', 'reservation_id'), (SELECT MAX(reservation_id) FROM reservation));
