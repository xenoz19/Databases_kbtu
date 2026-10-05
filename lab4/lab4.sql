-- 1
SELECT UPPER(airline_name) AS airline_name_upper
FROM airline;


-- 2
SELECT REPLACE(airline_name, 'Air', 'Aero') AS changed_name
FROM airline;


--  3
SELECT flight_no
FROM flights
WHERE airline_id = 1

INTERSECT

SELECT flight_no
FROM flights
WHERE airline_id = 2;


--  4
SELECT *
FROM airport
WHERE airport_name ILIKE '%Reginal%'
  AND airport_name ILIKE '%Air%';


--  5
SELECT
    first_name,
    last_name,
    TO_CHAR(date_of_birth, 'Month DD, YYYY') AS birth_date
FROM passengers;


--  6
SELECT flight_no
FROM flights
WHERE status = 'Delayed';


--  7
SELECT flight_no
FROM flights
WHERE actual_arrival > scheduled_arrival;


--  8
SELECT *
FROM airline
WHERE airline_country IN ('France', 'Portugal', 'Poland')
  AND created_at BETWEEN '2023-11-01' AND '2024-03-31';


--  9
SELECT *
FROM baggage
WHERE weight_in_kg > 25
ORDER BY weight_in_kg DESC
LIMIT 3;


--  10
SELECT first_name || ' ' || last_name AS full_name
FROM passengers
ORDER BY date_of_birth DESC
LIMIT 1;


--  11
SELECT booking_platform, MIN(price) AS cheapest_price
FROM booking
GROUP BY booking_platform;


--  12
SELECT *
FROM airline
WHERE airline_code ~ '[0-9]';


--  13
SELECT *
FROM airline
ORDER BY created_at DESC
LIMIT 5;


--  14
SELECT *
FROM baggage_check
WHERE booking_id BETWEEN 200 AND 300
  AND check_result <> 'Checked';


--  15
SELECT *
FROM baggage_check
WHERE EXTRACT(YEAR FROM update_at) = EXTRACT(YEAR FROM created_at)
  AND EXTRACT(MONTH FROM update_at) = EXTRACT(MONTH FROM created_at)
  AND update_at < created_at;