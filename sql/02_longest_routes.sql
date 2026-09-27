/*
====================================================================
Task 02: Longest Domestic Flight Corridors
Description: Identifies top long-haul routes using role-playing 
             airport dimensions for origin and destination.
Skills: Multi-Table JOINs, Role-Playing Dimensions, DISTINCT Routes
====================================================================
*/

SELECT DISTINCT
    orig.airport_name AS origin_airport,
    orig.city AS origin_city,
    dest.airport_name AS destination_airport,
    dest.city AS destination_city,
    flights.distance
FROM flights_fact AS flights
JOIN airports_dim AS orig 
    ON flights.origin_airport_code = orig.airport_code
JOIN airports_dim AS dest 
    ON flights.dest_airport_code = dest.airport_code
ORDER BY flights.distance DESC
LIMIT 10;