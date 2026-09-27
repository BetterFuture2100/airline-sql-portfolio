/*
====================================================================
Task 01: Flight Arrival Delay Distribution
Description: Categorizes arrival delays into operational buckets 
             (Early/On-Time, Minor Delay, Moderate Delay, Severe Delay).
Skills: CASE WHEN, Aggregate Functions, Filtering
====================================================================
*/

SELECT 
    CASE 
        WHEN arr_delay::NUMERIC <= 0 THEN 'On-Time / Early'
        WHEN arr_delay::NUMERIC BETWEEN 1 AND 15 THEN 'Small Delay (1-15 min)'
        WHEN arr_delay::NUMERIC BETWEEN 16 AND 45 THEN 'Medium Delay (16-45 min)'
        ELSE 'Large Delay (>45 min)'
    END AS delay_category,
    COUNT(flight_id) AS total_flights,
    ROUND(COUNT(flight_id) * 100.0 / SUM(COUNT(flight_id)) OVER (), 2) AS percentage_share
FROM flights_fact
WHERE cancelled = 0 
  AND arr_delay IS NOT NULL
GROUP BY delay_category
ORDER BY total_flights DESC;