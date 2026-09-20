
CREATE TABLE passenger_3nf (
    passenger_id INTEGER PRIMARY KEY,
    passenger_full_name VARCHAR(100),
    passenger_passport_number VARCHAR(50)
);

CREATE TABLE airport_3nf (
    airport_id INTEGER PRIMARY KEY,
    airport_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE airline_3nf (
    airline_id INTEGER PRIMARY KEY,
    airline_name VARCHAR(100)
);

CREATE TABLE flight_3nf (
    flight_number VARCHAR(20) PRIMARY KEY,
    departure_airport_id INTEGER,
    arrival_airport_id INTEGER,
    airline_id INTEGER,

    FOREIGN KEY (departure_airport_id)
        REFERENCES airport_3nf(airport_id),

    FOREIGN KEY (arrival_airport_id)
        REFERENCES airport_3nf(airport_id),

    FOREIGN KEY (airline_id)
        REFERENCES airline_3nf(airline_id)
);

CREATE TABLE booking_3nf (
    booking_id INTEGER PRIMARY KEY,
    passenger_id INTEGER,
    flight_number VARCHAR(20),
    ticket_price DECIMAL(10,2),

    FOREIGN KEY (passenger_id)
        REFERENCES passenger_3nf(passenger_id),

    FOREIGN KEY (flight_number)
        REFERENCES flight_3nf(flight_number)
);

CREATE TABLE booking_seat_3nf (
    booking_id INTEGER,
    seat_number VARCHAR(10),

    PRIMARY KEY (booking_id, seat_number),

    FOREIGN KEY (booking_id)
        REFERENCES booking_3nf(booking_id)
);


INSERT INTO airport_3nf
VALUES
(1, 'Almaty Airport', 'Almaty'),
(2, 'Astana Airport', 'Astana'),
(3, 'Aktobe Airport', 'Aktobe');

INSERT INTO airline_3nf
VALUES
(1, 'Air Astana'),
(2, 'SCAT Airlines');

INSERT INTO passenger_3nf
VALUES
(1, 'Nurkanat Yedgenov', 'P10001'),
(2, 'Diana Smagyl', 'P10002'),
(3, 'Erasyl Nirbek', 'P10003'),
(4, 'Naruto Uzumaki', 'P10004'),
(5, 'Itachi Uchiha', 'P10005');

INSERT INTO flight_3nf
VALUES
('KC101', 1, 2, 1),
('KC102', 2, 1, 1),
('DV201', 1, 3, 2);

INSERT INTO booking_3nf
VALUES
(1, 1, 'KC101', 45000.00),
(2, 2, 'KC101', 45000.00),
(3, 3, 'KC102', 40000.00),
(4, 4, 'DV201', 30000.00),
(5, 5, 'DV201', 32000.00);

INSERT INTO booking_seat_3nf
VALUES
(1, '12A'),
(1, '12B'),
(2, '14C'),
(3, '8A'),
(4, '5B'),
(5, '5C');


CREATE TABLE Airline_info (
    airline_id INT,
    airline_code VARCHAR(30),
    airline_name VARCHAR(50),
    airline_country VARCHAR(50),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    info VARCHAR(50)
);

CREATE TABLE Airport (
    airport_id INT,
    airport_name VARCHAR(50),
    country VARCHAR(50),
    state VARCHAR(50),
    city VARCHAR(50),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE Baggage_check (
    baggage_check_id INT,
    check_result VARCHAR(50),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    booking_id INT,
    passenger_id INT
);

CREATE TABLE Baggage (
    baggage_id INT,
    weight_in_kg DECIMAL(4,2),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    booking_id INT
);

CREATE TABLE Boarding_pass (
    boarding_pass_id INT,
    booking_id INT,
    seat VARCHAR(50),
    boarding_time TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE Booking_flight (
    booking_flight_id INT,
    booking_id INT,
    flight_id INT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE Booking (
    booking_id INT,
    flight_id INT,
    passenger_id INT,
    booking_platform VARCHAR(50),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    status VARCHAR(50),
    price DECIMAL(7,2)
);

CREATE TABLE Flights (
    flight_id INT,
    sch_departure_time TIMESTAMP,
    sch_arrival_time TIMESTAMP,
    departing_airport_id INT,
    arriving_airport_id INT,
    departing_gate VARCHAR(50),
    arriving_gate VARCHAR(50),
    airline_id INT,
    act_departure_time TIMESTAMP,
    act_arrival_time TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE Passengers (
    passenger_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender VARCHAR(50),
    country_of_citizenship VARCHAR(50),
    country_of_residence VARCHAR(50),
    passport_number VARCHAR(20),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE Security_check (
    security_check_id INT,
    check_result VARCHAR(20),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    passenger_id INT
);


ALTER TABLE Airline_info
ADD PRIMARY KEY (airline_id);

ALTER TABLE Airport
ADD PRIMARY KEY (airport_id);

ALTER TABLE Baggage_check
ADD PRIMARY KEY (baggage_check_id);

ALTER TABLE Baggage
ADD PRIMARY KEY (baggage_id);

ALTER TABLE Boarding_pass
ADD PRIMARY KEY (boarding_pass_id);

ALTER TABLE Booking_flight
ADD PRIMARY KEY (booking_flight_id);

ALTER TABLE Booking
ADD PRIMARY KEY (booking_id);

ALTER TABLE Flights
ADD PRIMARY KEY (flight_id);

ALTER TABLE Passengers
ADD PRIMARY KEY (passenger_id);

ALTER TABLE Security_check
ADD PRIMARY KEY (security_check_id);


ALTER TABLE Airline_info
    ALTER COLUMN airline_id SET NOT NULL,
    ALTER COLUMN airline_code SET NOT NULL,
    ALTER COLUMN airline_name SET NOT NULL,
    ALTER COLUMN airline_country SET NOT NULL,
    ALTER COLUMN created_at SET NOT NULL,
    ALTER COLUMN updated_at SET NOT NULL,
    ALTER COLUMN info SET NOT NULL;

ALTER TABLE Airport
    ALTER COLUMN airport_id SET NOT NULL,
    ALTER COLUMN airport_name SET NOT NULL,
    ALTER COLUMN country SET NOT NULL,
    ALTER COLUMN state SET NOT NULL,
    ALTER COLUMN city SET NOT NULL,
    ALTER COLUMN created_at SET NOT NULL,
    ALTER COLUMN updated_at SET NOT NULL;

ALTER TABLE Baggage_check
    ALTER COLUMN baggage_check_id SET NOT NULL,
    ALTER COLUMN check_result SET NOT NULL,
    ALTER COLUMN created_at SET NOT NULL,
    ALTER COLUMN updated_at SET NOT NULL,
    ALTER COLUMN booking_id SET NOT NULL,
    ALTER COLUMN passenger_id SET NOT NULL;

ALTER TABLE Baggage
    ALTER COLUMN baggage_id SET NOT NULL,
    ALTER COLUMN weight_in_kg SET NOT NULL,
    ALTER COLUMN created_at SET NOT NULL,
    ALTER COLUMN updated_at SET NOT NULL,
    ALTER COLUMN booking_id SET NOT NULL;

ALTER TABLE Boarding_pass
    ALTER COLUMN boarding_pass_id SET NOT NULL,
    ALTER COLUMN booking_id SET NOT NULL,
    ALTER COLUMN seat SET NOT NULL,
    ALTER COLUMN boarding_time SET NOT NULL,
    ALTER COLUMN created_at SET NOT NULL,
    ALTER COLUMN updated_at SET NOT NULL;

ALTER TABLE Booking_flight
    ALTER COLUMN booking_flight_id SET NOT NULL,
    ALTER COLUMN booking_id SET NOT NULL,
    ALTER COLUMN flight_id SET NOT NULL,
    ALTER COLUMN created_at SET NOT NULL,
    ALTER COLUMN updated_at SET NOT NULL;

ALTER TABLE Booking
    ALTER COLUMN booking_id SET NOT NULL,
    ALTER COLUMN flight_id SET NOT NULL,
    ALTER COLUMN passenger_id SET NOT NULL,
    ALTER COLUMN booking_platform SET NOT NULL,
    ALTER COLUMN created_at SET NOT NULL,
    ALTER COLUMN updated_at SET NOT NULL,
    ALTER COLUMN status SET NOT NULL,
    ALTER COLUMN price SET NOT NULL;

ALTER TABLE Flights
    ALTER COLUMN flight_id SET NOT NULL,
    ALTER COLUMN sch_departure_time SET NOT NULL,
    ALTER COLUMN sch_arrival_time SET NOT NULL,
    ALTER COLUMN departing_airport_id SET NOT NULL,
    ALTER COLUMN arriving_airport_id SET NOT NULL,
    ALTER COLUMN departing_gate SET NOT NULL,
    ALTER COLUMN arriving_gate SET NOT NULL,
    ALTER COLUMN airline_id SET NOT NULL,
    ALTER COLUMN act_departure_time SET NOT NULL,
    ALTER COLUMN act_arrival_time SET NOT NULL,
    ALTER COLUMN created_at SET NOT NULL,
    ALTER COLUMN updated_at SET NOT NULL;

ALTER TABLE Passengers
    ALTER COLUMN passenger_id SET NOT NULL,
    ALTER COLUMN first_name SET NOT NULL,
    ALTER COLUMN last_name SET NOT NULL,
    ALTER COLUMN date_of_birth SET NOT NULL,
    ALTER COLUMN gender SET NOT NULL,
    ALTER COLUMN country_of_citizenship SET NOT NULL,
    ALTER COLUMN country_of_residence SET NOT NULL,
    ALTER COLUMN passport_number SET NOT NULL,
    ALTER COLUMN created_at SET NOT NULL,
    ALTER COLUMN updated_at SET NOT NULL;

ALTER TABLE Security_check
    ALTER COLUMN security_check_id SET NOT NULL,
    ALTER COLUMN check_result SET NOT NULL,
    ALTER COLUMN created_at SET NOT NULL,
    ALTER COLUMN updated_at SET NOT NULL,
    ALTER COLUMN passenger_id SET NOT NULL;


ALTER TABLE Airline_info
RENAME TO Airline;


ALTER TABLE Booking
RENAME COLUMN price TO ticket_price;


ALTER TABLE Flights
ALTER COLUMN departing_gate TYPE TEXT;


ALTER TABLE Airline
DROP COLUMN info;


ALTER TABLE Security_check
ADD FOREIGN KEY (passenger_id)
REFERENCES Passengers(passenger_id);

ALTER TABLE Booking
ADD FOREIGN KEY (passenger_id)
REFERENCES Passengers(passenger_id);

ALTER TABLE Baggage_check
ADD FOREIGN KEY (passenger_id)
REFERENCES Passengers(passenger_id);


ALTER TABLE Baggage_check
ADD FOREIGN KEY (booking_id)
REFERENCES Booking(booking_id);

ALTER TABLE Baggage
ADD FOREIGN KEY (booking_id)
REFERENCES Booking(booking_id);

ALTER TABLE Boarding_pass
ADD FOREIGN KEY (booking_id)
REFERENCES Booking(booking_id);

ALTER TABLE Booking_flight
ADD FOREIGN KEY (booking_id)
REFERENCES Booking(booking_id);


ALTER TABLE Booking_flight
ADD FOREIGN KEY (flight_id)
REFERENCES Flights(flight_id);


ALTER TABLE Flights
ADD FOREIGN KEY (departing_airport_id)
REFERENCES Airport(airport_id);

ALTER TABLE Flights
ADD FOREIGN KEY (arriving_airport_id)
REFERENCES Airport(airport_id);


ALTER TABLE Flights
ADD FOREIGN KEY (airline_id)
REFERENCES Airline(airline_id);