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