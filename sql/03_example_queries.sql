-- 1. Reservations with tourist and selected service details.
SELECT r.reservation_id, t.name AS tourist, a.name AS activity,
       ac.name AS accommodation, tr.type AS transportation,
       r.status, r.total_cost, r.check_in_date, r.check_out_date
FROM reservation r
JOIN tourist t ON t.tourist_id = r.tourist_id
JOIN activity a ON a.activity_id = r.activity_id
JOIN accommodation ac ON ac.accommodation_id = r.accommodation_id
JOIN transportation tr ON tr.transportation_id = r.transportation_id
ORDER BY r.check_in_date;

-- 2. Count reservations by activity.
SELECT a.name, COUNT(*) AS reservation_count
FROM reservation r
JOIN activity a ON a.activity_id = r.activity_id
GROUP BY a.activity_id, a.name
ORDER BY reservation_count DESC, a.name;

-- 3. Activities available at each destination.
SELECT d.name AS destination, a.name AS activity, a.difficulty_level
FROM activity_destination ad
JOIN destination d ON d.destination_id = ad.destination_id
JOIN activity a ON a.activity_id = ad.activity_id
ORDER BY d.name, a.name;

-- 4. Guides and their average rating.
SELECT name, rating
FROM guide
ORDER BY rating DESC NULLS LAST;

-- 5. Guides qualified for each activity.
SELECT a.name AS activity, g.name AS guide, g.rating
FROM activity_guide ag
JOIN activity a ON a.activity_id = ag.activity_id
JOIN guide g ON g.guide_id = ag.guide_id
ORDER BY a.name, g.name;

-- 6. Accommodation options and destination.
SELECT d.name AS destination, ac.name AS accommodation,
       ac.type, ac.price_per_night
FROM accommodation ac
JOIN destination d ON d.destination_id = ac.destination_id
ORDER BY d.name, ac.price_per_night;

-- 7. Total confirmed booking value.
SELECT COALESCE(SUM(total_cost), 0) AS confirmed_booking_value
FROM reservation
WHERE status = 'Confirmed';

-- 8. Reservations grouped by payment status.
SELECT payment_status, COUNT(*) AS reservation_count,
       COALESCE(SUM(total_cost), 0) AS total_value
FROM reservation
GROUP BY payment_status
ORDER BY payment_status;

-- 9. Tourists without reservations.
SELECT t.tourist_id, t.name, t.email
FROM tourist t
LEFT JOIN reservation r ON r.tourist_id = t.tourist_id
WHERE r.reservation_id IS NULL;

-- 10. Upcoming stays.
SELECT r.reservation_id, t.name, r.check_in_date, r.check_out_date
FROM reservation r
JOIN tourist t ON t.tourist_id = r.tourist_id
WHERE r.check_in_date >= CURRENT_DATE
ORDER BY r.check_in_date;

-- 11. Destinations visited by each tourist.
SELECT t.name AS tourist, d.name AS destination
FROM tourist_destination td
JOIN tourist t ON t.tourist_id = td.tourist_id
JOIN destination d ON d.destination_id = td.destination_id
ORDER BY t.name, d.name;

-- 12. Guides who recommend accommodation.
SELECT g.name AS guide, ac.name AS accommodation
FROM guide_accommodation ga
JOIN guide g ON g.guide_id = ga.guide_id
JOIN accommodation ac ON ac.accommodation_id = ga.accommodation_id
ORDER BY g.name, ac.name;

-- 13. Find activities with duration no longer than four hours.
SELECT name, duration, difficulty_level
FROM activity
WHERE duration <= INTERVAL '4 hours'
ORDER BY duration;

-- 14. Reservations with unpaid balances.
SELECT reservation_id, total_cost, status, check_in_date
FROM reservation
WHERE payment_status = 'Unpaid'
ORDER BY check_in_date;
