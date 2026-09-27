/*
====================================================================
Task 03: Underperforming Carriers vs. National Delay Benchmark
Description: Filters carriers with worse average arrival delay than 
             the overall national average across all completed flights.
Skills: Scalar Subqueries in HAVING, Explicit Type Casting (::NUMERIC)
====================================================================
*/

SELECT 
    airline.carrier_name,
    ROUND(AVG(flights.arr_delay::NUMERIC), 2) AS carrier_avg_delay
FROM flights_fact AS flights
JOIN carriers_dim AS airline 
    ON flights.carrier_code = airline.carrier_code
WHERE flights.cancelled = 0 
  AND flights.arr_delay IS NOT NULL
GROUP BY airline.carrier_name
HAVING AVG(flights.arr_delay::NUMERIC) > (
    SELECT AVG(arr_delay::NUMERIC)
    FROM flights_fact
    WHERE cancelled = 0 
      AND arr_delay IS NOT NULL
)
ORDER BY carrier_avg_delay DESC;