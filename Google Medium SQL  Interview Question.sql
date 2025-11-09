-- Google SQL Interview Question: Odd and Even Measurements
-- Table: measurements
-- +-------------------+--------------+
-- | measurement_time  | measurement_value |
-- +-------------------+--------------+
-- | TIMESTAMP         | INTEGER      |
-- +-------------------+--------------+
-- 
-- Problem: 
-- Write a query to calculate the sum of odd-numbered and even-numbered measurements separately for a particular day 
-- and display the results in two different columns.
-- Odd/even is based on the order of measurement_time for each day.

WITH cte AS (
    SELECT 
        CAST(measurement_time AS DATE) AS measurement_day,
        measurement_value,
        ROW_NUMBER() OVER (
            PARTITION BY CAST(measurement_time AS DATE)
            ORDER BY measurement_time
        ) AS rn
    FROM
        measurements
)
SELECT
    measurement_day,
    SUM(CASE WHEN rn % 2 = 1 THEN measurement_value ELSE 0 END) AS odd_sum,
    SUM(CASE WHEN rn % 2 = 0 THEN measurement_value ELSE 0 END) AS even_sum
FROM 
    cte
GROUP BY
    measurement_day
ORDER BY 
    measurement_day;
