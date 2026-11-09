
--1
CREATE INDEX IF NOT EXISTS idx_flights_actual_departure
ON flights(actual_departure);

--2
SELECT flight_no, scheduled_departure, COUNT(*) AS total
FROM flights
GROUP BY flight_no, scheduled_departure
HAVING COUNT(*) > 1;


--3
CREATE INDEX IF NOT EXISTS idx_flights_dep_arr
ON flights(departure_airport_id, arrival_airport_id);

--4

DROP INDEX IF EXISTS idx_flights_actual_departure;
EXPLAIN ANALYZE
SELECT *
FROM flights
WHERE actual_departure = DATE '2024-02-09';

CREATE INDEX idx_flights_actual_departure
ON flights(actual_departure);
ANALYZE flights;
EXPLAIN ANALYZE
SELECT *
FROM flights
WHERE actual_departure = DATE '2024-02-09';

--5
EXPLAIN ANALYZE
SELECT *
FROM flights
WHERE departure_airport_id = 1
  AND arrival_airport_id = 2;

--6
CREATE UNIQUE INDEX IF NOT EXISTS idx_passengers_passport_unique
ON passengers(passport_number);

SELECT indexname, indexdef
FROM pg_indexes
WHERE schemaname = current_schema()
  AND tablename = 'passengers'
  AND indexname = 'idx_passengers_passport_unique';

INSERT INTO passengers
    (passenger_id, first_name, last_name, date_of_birth,
     gender, country_of_citizenship, country_of_residence, passport_number)
SELECT m.max_id + g.n,
       CASE WHEN g.n = 1 THEN 'Almas' ELSE 'Aruzhan' END,
       'LabSeven', DATE '2000-01-01',
       CASE WHEN g.n = 1 THEN 'Male' ELSE 'Female' END,
       'Kazakhstan', 'Kazakhstan',
       'LAB7-' || (m.max_id + g.n)::text
FROM (SELECT COALESCE(MAX(passenger_id), 0) AS max_id FROM passengers) AS m
CROSS JOIN generate_series(1, 2) AS g(n);

SELECT passenger_id, first_name, last_name, passport_number
FROM passengers
WHERE last_name = 'LabSeven';


--7
CREATE INDEX IF NOT EXISTS idx_passengers_country_dob_name
ON passengers(country_of_citizenship, date_of_birth, first_name, last_name);

EXPLAIN ANALYZE
SELECT first_name, last_name, date_of_birth, country_of_citizenship
FROM passengers
WHERE country_of_citizenship = 'Philippines'
  AND date_of_birth >= DATE '1984-01-01'
  AND date_of_birth < DATE '1985-01-01';

--8
SELECT indexname, indexdef
FROM pg_indexes
WHERE schemaname = current_schema()
  AND tablename = 'passengers';

DROP INDEX IF EXISTS idx_passengers_passport_unique;
DROP INDEX IF EXISTS idx_passengers_country_dob_name;

--9
DROP INDEX IF EXISTS idx_booking_passenger;
EXPLAIN ANALYZE
SELECT *
FROM booking
WHERE passenger_id = 100;

CREATE INDEX idx_booking_passenger
ON booking(passenger_id);
ANALYZE booking;
EXPLAIN ANALYZE
SELECT *
FROM booking
WHERE passenger_id = 100;

--10
CREATE INDEX IF NOT EXISTS idx_booking_flight_pair
ON booking_flight(booking_id, flight_id);

EXPLAIN ANALYZE
SELECT f.flight_no, b.price
FROM booking AS b
JOIN booking_flight AS bf ON b.booking_id = bf.booking_id
JOIN flights AS f ON bf.flight_id = f.flight_id
WHERE b.price > 9000;

--11
CREATE INDEX IF NOT EXISTS idx_flights_status
ON flights(status);

EXPLAIN ANALYZE
SELECT * FROM flights WHERE status = 'Departed';

EXPLAIN ANALYZE
SELECT * FROM flights WHERE status = 'Boarding';

SELECT status, COUNT(*) AS total
FROM flights
WHERE status IN ('Departed', 'Boarding')
GROUP BY status;

--12
CREATE INDEX IF NOT EXISTS idx_baggage_weight
ON baggage(weight_in_kg);

EXPLAIN ANALYZE
SELECT * FROM baggage WHERE weight_in_kg > 49;

EXPLAIN ANALYZE
SELECT * FROM baggage WHERE weight_in_kg > 5;

--13
CREATE INDEX IF NOT EXISTS idx_airport_name_pattern
ON airport(airport_name varchar_pattern_ops);

EXPLAIN ANALYZE
SELECT * FROM airport WHERE airport_name LIKE 'A%';

EXPLAIN ANALYZE
SELECT * FROM airport WHERE airport_name LIKE '%Airport';

--14
CREATE INDEX IF NOT EXISTS idx_airport_country_city
ON airport(country, city);

EXPLAIN ANALYZE
SELECT * FROM airport WHERE country = 'Kazakhstan';

EXPLAIN ANALYZE
SELECT * FROM airport WHERE city = 'Almaty';

EXPLAIN ANALYZE
SELECT * FROM airport
WHERE country = 'Kazakhstan' AND city = 'Almaty';

--15
CREATE INDEX IF NOT EXISTS idx_passengers_lower_last_name
ON passengers(LOWER(last_name));

EXPLAIN ANALYZE
SELECT * FROM passengers WHERE LOWER(last_name) = 'irnis';

EXPLAIN ANALYZE
SELECT * FROM passengers WHERE last_name = 'Irnis';

--16
CREATE INDEX IF NOT EXISTS idx_booking_covering
ON booking(passenger_id) INCLUDE (price);

EXPLAIN ANALYZE
SELECT price
FROM booking
WHERE passenger_id = 100;

--17
SELECT airline_code, COUNT(*) AS total
FROM airline
WHERE airline_code IS NOT NULL
GROUP BY airline_code
HAVING COUNT(*) > 1;

CREATE UNIQUE INDEX IF NOT EXISTS idx_airline_code_unique
ON airline(airline_code);

SELECT indexname, indexdef
FROM pg_indexes
WHERE schemaname = current_schema()
  AND tablename = 'airline'
  AND indexname = 'idx_airline_code_unique';
