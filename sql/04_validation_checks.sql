-- Read-only sanity checks. Each query should return zero rows unless noted.
-- 1. Invalid guide ratings.
SELECT guide_id, rating FROM guide
WHERE rating IS NOT NULL AND rating NOT BETWEEN 0 AND 5;

-- 2. Invalid tourist ages.
SELECT tourist_id, age FROM tourist WHERE age <= 0;

-- 3. Invalid stay date ranges.
SELECT reservation_id, check_in_date, check_out_date
FROM reservation WHERE check_out_date <= check_in_date;

-- 4. Negative monetary values.
SELECT 'accommodation' AS source, accommodation_id AS record_id
FROM accommodation WHERE price_per_night < 0
UNION ALL
SELECT 'transportation', transportation_id
FROM transportation WHERE price < 0
UNION ALL
SELECT 'reservation', reservation_id
FROM reservation WHERE total_cost < 0;

-- 5. Duplicate tourist/activity associations (should be impossible due to PK).
SELECT tourist_id, activity_id, COUNT(*)
FROM tourist_activity
GROUP BY tourist_id, activity_id
HAVING COUNT(*) > 1;

-- 6. Table row counts (informational).
SELECT 'tourist' AS table_name, COUNT(*) AS row_count FROM tourist
UNION ALL SELECT 'guide', COUNT(*) FROM guide
UNION ALL SELECT 'destination', COUNT(*) FROM destination
UNION ALL SELECT 'activity', COUNT(*) FROM activity
UNION ALL SELECT 'accommodation', COUNT(*) FROM accommodation
UNION ALL SELECT 'transportation', COUNT(*) FROM transportation
UNION ALL SELECT 'reservation', COUNT(*) FROM reservation
ORDER BY table_name;
