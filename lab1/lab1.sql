CREATE TABLE airport(
    airport_id INTEGER primary key,
    airport_name VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    city VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    uptated_at TIMESTAMP NOT NULL
);

CREATE TABLE airline(
    airline_id INTEGER PRIMARY KEY,
    airline_code VARCHAR(10) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);


CREATE TABLE flight (
    flight_id INTEGER PRIMARY KEY,

    departing_gate VARCHAR(20),
    arriving_gate VARCHAR(20),

    airline_id INTEGER NOT NULL,
    departure_airport_id INTEGER NOT NULL,
    arrival_airport_id INTEGER NOT NULL,

    scheduled_departure_time TIMESTAMP NOT NULL,
    scheduled_arrival_time TIMESTAMP NOT NULL,
    actual_departure_time TIMESTAMP,
    actual_arrival_time TIMESTAMP,

    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,

    FOREIGN KEY (airline_id)
        REFERENCES airline(airline_id),

    FOREIGN KEY (departure_airport_id)
        REFERENCES airport(airport_id),

    FOREIGN KEY (arrival_airport_id)
        REFERENCES airport(airport_id)
);


CREATE TABLE passenger (
    passenger_id INTEGER PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    gender VARCHAR(20),
    date_of_birth DATE NOT NULL,
    country_of_citizenship VARCHAR(100),
    country_of_residence VARCHAR(100),
    passport_number VARCHAR(50) UNIQUE NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);


CREATE TABLE booking (
    booking_id INTEGER PRIMARY KEY,

    flight_id INTEGER NOT NULL,
    passenger_id INTEGER NOT NULL,

    status VARCHAR(50) NOT NULL,
    booking_platform VARCHAR(100),
    ticket_price NUMERIC(10, 2) NOT NULL,

    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,

    FOREIGN KEY (flight_id)
        REFERENCES flight(flight_id),

    FOREIGN KEY (passenger_id)
        REFERENCES passenger(passenger_id)
);


CREATE TABLE boarding_pass (
    boarding_pass_id INTEGER PRIMARY KEY,
    booking_id INTEGER UNIQUE NOT NULL,

    seat VARCHAR(10) NOT NULL,
    boarding_time TIMESTAMP,

    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,

    FOREIGN KEY (booking_id)
        REFERENCES booking(booking_id)
);


CREATE TABLE baggage (
    baggage_id INTEGER PRIMARY KEY,
    booking_id INTEGER NOT NULL,

    weight_kg NUMERIC(6, 2) NOT NULL,

    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,

    FOREIGN KEY (booking_id)
        REFERENCES booking(booking_id)
);


CREATE TABLE security_check (
    security_check_id INTEGER PRIMARY KEY,
    passenger_id INTEGER NOT NULL,

    check_results VARCHAR(100) NOT NULL,

    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,

    FOREIGN KEY (passenger_id)
        REFERENCES passenger(passenger_id)
);


CREATE TABLE baggage_check (
    baggage_check_id INTEGER PRIMARY KEY,

    booking_id INTEGER NOT NULL,
    passenger_id INTEGER NOT NULL,

    check_results VARCHAR(100) NOT NULL,

    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,

    FOREIGN KEY (booking_id)
        REFERENCES booking(booking_id),

    FOREIGN KEY (passenger_id)
        REFERENCES passenger(passenger_id)
);


