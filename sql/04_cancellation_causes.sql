/*
====================================================================
Task 04: Cancellation Drivers by Carrier
Description: Analyzes cancellation causes per airline using a derived 
             pre-aggregation table joined back to dimensions.
Skills: Derived Tables (Subquery in FROM), Multi-Table JOINs
====================================================================
*/

SELECT 
    airline.carrier_name,
    cancel.cancel_reason,
    sub.cancelled_count
FROM (
    SELECT 
        carrier_code,
        cancel_code,
        COUNT(flight_id) AS cancelled_count
    FROM flights_fact
    WHERE cancelled = 1
    GROUP BY carrier_code, cancel_code
) AS sub
JOIN carriers_dim AS airline 
    ON sub.carrier_code = airline.carrier_code
JOIN cancellations_dim AS cancel 
    ON sub.cancel_code = cancel.cancel_code
ORDER BY sub.cancelled_count DESC;