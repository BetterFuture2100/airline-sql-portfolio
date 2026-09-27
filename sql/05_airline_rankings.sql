/*
====================================================================
Task 05: Airline Reliability & Punctuality Leaderboard
Description: Evaluates carrier reliability by computing flight volume 
             and average arrival delay, ranking carriers using window functions.
Skills: Common Table Expressions (CTE), DENSE_RANK() OVER(), CAST
====================================================================
*/

WITH airline_stats AS (
    SELECT 
        airline.carrier_name,
        COUNT(flights.flight_id) AS total_flights,
        ROUND(AVG(flights.arr_delay::NUMERIC), 2) AS avg_delay
    FROM flights_fact AS flights
    JOIN carriers_dim AS airline 
        ON flights.carrier_code = airline.carrier_code
    WHERE flights.cancelled = 0 
      AND flights.arr_delay IS NOT NULL
    GROUP BY airline.carrier_name
)
SELECT 
    carrier_name,
    total_flights,
    avg_delay,
    DENSE_RANK() OVER (ORDER BY avg_delay ASC) AS punctuality_rank
FROM airline_stats
ORDER BY punctuality_rank ASC;