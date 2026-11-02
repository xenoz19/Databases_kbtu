--1
SELECT
    f.flight_no,
    a.airline_name
FROM flights f
JOIN airline a
ON f.airline_id = a.airline_id
WHERE a.airline_id = 5;


--2
SELECT
    f.flight_no,
    ap.airport_name
FROM flights f
JOIN airport ap
ON f.departure_airport_id = ap.airport_id;


--3
SELECT
    a.airline_name
FROM airline a
LEFT JOIN flights f
ON a.airline_id = f.airline_id
AND f.scheduled_departure >=
    DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '1 month'
AND f.scheduled_departure <
    DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '2 months'
GROUP BY a.airline_id, a.airline_name
HAVING COUNT(f.flight_id) = 0;


--4
SELECT
    p.first_name,
    p.last_name,
    f.flight_no
FROM passengers p
JOIN booking b
ON p.passenger_id = b.passenger_id
JOIN booking_flight bf
ON b.booking_id = bf.booking_id
JOIN flights f
ON bf.flight_id = f.flight_id
WHERE f.flight_id = 1;


--5
SELECT
    f.flight_no,
    AVG(b.price) AS average_price,
    SUM(b.price) AS total_price,
    MAX(b.price) AS max_price,
    MIN(b.price) AS min_price
FROM flights f
JOIN booking_flight bf
ON f.flight_id = bf.flight_id
JOIN booking b
ON bf.booking_id = b.booking_id
GROUP BY f.flight_id, f.flight_no;


--6
SELECT
    f.flight_no,
    a.airline_name,
    ap.airport_name,
    ap.country
FROM flights f
JOIN airline a
ON f.airline_id = a.airline_id
JOIN airport ap
ON f.arrival_airport_id = ap.airport_id
WHERE ap.country = 'China';


--7
SELECT
    p.first_name,
    p.last_name,
    p.date_of_birth,
    ap.city AS arrival_city,
    ap.country AS arrival_country
FROM passengers p
JOIN booking b
ON p.passenger_id = b.passenger_id
JOIN booking_flight bf
ON b.booking_id = bf.booking_id
JOIN flights f
ON bf.flight_id = f.flight_id
JOIN airport ap
ON f.arrival_airport_id = ap.airport_id
WHERE p.date_of_birth > CURRENT_DATE - INTERVAL '18 years';


--8
SELECT
    p.first_name,
    p.last_name,
    p.passport_number,
    f.actual_arrival
FROM passengers p
JOIN booking b
ON p.passenger_id = b.passenger_id
JOIN booking_flight bf
ON b.booking_id = bf.booking_id
JOIN flights f
ON bf.flight_id = f.flight_id;


--9
SELECT
    ap.country,
    COUNT(f.flight_id) AS total_flights
FROM flights f
JOIN airline a
ON f.airline_id = a.airline_id
JOIN airport ap
ON f.departure_airport_id = ap.airport_id
WHERE a.airline_country = ap.country
GROUP BY ap.country;


--10
SELECT
    f.flight_no,
    a.airline_name,
    dep.airport_name AS departure_airport,
    arr.airport_name AS arrival_airport
FROM flights f
JOIN airline a
ON f.airline_id = a.airline_id
JOIN airport dep
ON f.departure_airport_id = dep.airport_id
JOIN airport arr
ON f.arrival_airport_id = arr.airport_id;


--11
SELECT
    p.first_name,
    p.last_name,
    f.flight_no
FROM passengers p
JOIN booking b
ON p.passenger_id = b.passenger_id
JOIN booking_flight bf
ON b.booking_id = bf.booking_id
JOIN flights f
ON bf.flight_id = f.flight_id
JOIN airline a
ON f.airline_id = a.airline_id
WHERE a.airline_id = 5;


--12
SELECT
    f.flight_no,
    ap.country AS destination_country,
    COUNT(b.passenger_id) AS total_passengers
FROM flights f
JOIN airport ap
ON f.arrival_airport_id = ap.airport_id
LEFT JOIN booking_flight bf
ON f.flight_id = bf.flight_id
LEFT JOIN booking b
ON bf.booking_id = b.booking_id
GROUP BY f.flight_id, f.flight_no, ap.country;


--13
SELECT
    p.first_name,
    p.last_name
FROM passengers p
LEFT JOIN booking b
ON p.passenger_id = b.passenger_id
WHERE b.booking_id IS NULL;


--14
SELECT
    a.airline_name,
    COUNT(f.flight_id) AS total_flights
FROM airline a
LEFT JOIN flights f
ON a.airline_id = f.airline_id
GROUP BY a.airline_id, a.airline_name;


--15
SELECT
    a.airline_name,
    f.flight_no,
    ap.city AS departure_city
FROM flights f
JOIN airline a
ON f.airline_id = a.airline_id
JOIN airport ap
ON f.departure_airport_id = ap.airport_id
WHERE ap.country = 'China';