--  1
ALTER TABLE passengers
ADD CONSTRAINT check_passenger_age
CHECK (date_of_birth <= CURRENT_DATE - INTERVAL '10 years');


--  2
ALTER TABLE booking
ADD CONSTRAINT check_booking_price
CHECK (price >= 0 AND price <= 50000);


--  3
ALTER TABLE baggage
ADD CONSTRAINT check_baggage_weight
CHECK (weight_in_kg BETWEEN 1 AND 23);


--  4
ALTER TABLE airport
ADD CONSTRAINT check_airport_name_length
CHECK (LENGTH(airport_name) >= 10);


--  5
ALTER TABLE airline
ADD CONSTRAINT uq_airline_id UNIQUE (airline_id);

ALTER TABLE airport
ADD CONSTRAINT uq_airport_id UNIQUE (airport_id);

ALTER TABLE baggage_check
ADD CONSTRAINT uq_baggage_check_id UNIQUE (baggage_check_id);

ALTER TABLE baggage
ADD CONSTRAINT uq_baggage_id UNIQUE (baggage_id);


--  6
ALTER TABLE passengers
ADD CONSTRAINT check_gender_age
CHECK (
    (gender = 'Male'
        AND date_of_birth <= CURRENT_DATE - INTERVAL '18 years')
    OR
    (gender = 'Female'
        AND date_of_birth <= CURRENT_DATE - INTERVAL '19 years')
)
NOT VALID;


--  7
ALTER TABLE passengers
ADD CONSTRAINT check_citizenship_age
CHECK (
    (country_of_citizenship = 'Kazakhstan'
        AND date_of_birth <= CURRENT_DATE - INTERVAL '18 years')
    OR
    (country_of_citizenship = 'France'
        AND date_of_birth <= CURRENT_DATE - INTERVAL '17 years')
    OR
    (country_of_citizenship NOT IN ('Kazakhstan', 'France')
        AND date_of_birth <= CURRENT_DATE - INTERVAL '19 years')
)
NOT VALID;


--  8
ALTER TABLE booking
ADD COLUMN ticket_discount DECIMAL(7,2);

UPDATE booking
SET ticket_discount =
    CASE
        WHEN created_at > DATE '2024-01-01' THEN price * 0.05
        WHEN created_at < DATE '2024-01-01' THEN price * 0.10
        ELSE 0
    END;

ALTER TABLE booking
ADD CONSTRAINT check_ticket_discount
CHECK (
    (created_at > DATE '2024-01-01'
        AND ticket_discount = price * 0.05)
    OR
    (created_at < DATE '2024-01-01'
        AND ticket_discount = price * 0.10)
    OR
    (created_at = DATE '2024-01-01'
        AND ticket_discount = 0)
)
NOT VALID;


--  9
ALTER TABLE booking
ALTER COLUMN status
SET DEFAULT 'Confirmed';

INSERT INTO booking (
    booking_id,
    passenger_id,
    booking_platform,
    created_at,
    update_at,
    price,
    ticket_discount
)
VALUES (
    501,
    1,
    'Website',
    '2024-02-01',
    '2024-02-01',
    10000,
    500
);


--  10
ALTER TABLE booking
ALTER COLUMN created_at
SET DEFAULT CURRENT_DATE;