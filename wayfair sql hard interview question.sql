/*
================================================================================
                    Y-ON-Y GROWTH RATE
                 Wayfair SQL Interview Question
                      Difficulty: HARD
================================================================================

PROBLEM STATEMENT:
Assume you're given a table containing information about Wayfair user transactions 
for different products. Write a query to calculate the year-on-year growth rate 
for the total spend of each product, grouping the results by product ID.

The output should include the year in ascending order, product ID, current year's 
spend, previous year's spend and year-on-year growth percentage, rounded to 
2 decimal places.

TABLE SCHEMA:
==============

user_transactions Table:
- transaction_id  : INTEGER
- product_id      : INTEGER
- spend           : DECIMAL
- transaction_date: DATETIME

EXAMPLE INPUT:
==============

transaction_id | product_id | spend   | transaction_date
1341           | 123424     | 1500.60 | 12/31/2019 12:00:00
1423           | 123424     | 1000.20 | 12/31/2020 12:00:00
1623           | 123424     | 1246.44 | 12/31/2021 12:00:00
1322           | 123424     | 2145.32 | 12/31/2022 12:00:00

KEY CONCEPTS:
=============
✓ Window Functions (LAG)
✓ Date Extraction (EXTRACT YEAR)
✓ Common Table Expressions (CTE)
✓ PARTITION BY & ORDER BY clauses
✓ YoY Formula: ((Current Year - Previous Year) / Previous Year) * 100

SOLUTION APPROACH:
==================
1. Create CTE to extract year from transaction_date
2. Get previous year's spend using LAG() window function
3. Apply LAG() partitioned by product_id ordered by product_id and year
4. Calculate growth rate with rounding to 2 decimal places
5. Handle NULL values for first year of each product

================================================================================
*/

-- SOLUTION:
WITH yearly_spend_cte AS (
    SELECT
        EXTRACT(YEAR FROM transaction_date) AS year,
        product_id,
        spend AS curr_year_spend,
        LAG(spend) OVER (
            PARTITION BY product_id
            ORDER BY product_id,
                EXTRACT(YEAR FROM transaction_date)
        ) AS prev_year_spend
    FROM user_transactions
)
SELECT
    year,
    product_id,
    curr_year_spend,
    prev_year_spend,
    ROUND(
        100.0 * (curr_year_spend - prev_year_spend) / prev_year_spend,
        2
    ) AS yoy_rate
FROM yearly_spend_cte
ORDER BY year, product_id;

/*
================================================================================
                        EXPECTED OUTPUT
================================================================================

year | product_id | curr_year_spend | prev_year_spend | yoy_rate
-----|------------|-----------------|-----------------|----------
2019 | 123424     | 1500.60         | NULL            | NULL
2019 | 234412     | 1800.00         | NULL            | NULL
2019 | 543623     | 6450.00         | NULL            | NULL
2020 | 123424     | 1000.20         | 1500.60         | -33.35
2020 | 234412     | 1234.00         | 1800.00         | -31.44
2020 | 543623     | 5348.12         | 6450.00         | -17.08
2021 | 123424     | 1246.44         | 1000.20         | 24.62
2021 | 234412     | 889.50          | 1234.00         | -27.92
2021 | 543623     | 2345.00         | 5348.12         | -56.15
2022 | 123424     | 2145.32         | 1246.44         | 72.12
2022 | 234412     | 2900.00         | 889.50          | 226.03
2022 | 543623     | 5680.00         | 2345.00         | 142.22

EXPLANATION:
============

The query calculates year-over-year growth rate for each product across multiple 
years by:

1. Grouping transactions by product and year
2. Using LAG window function to retrieve the previous year's spend for each product
3. Computing the growth rate formula: ((Current Year - Previous Year) / Previous Year) * 100
4. Rounding results to 2 decimal places

Example calculation for Product 123424:
- 2019: First year - no previous data (NULL)
- 2020: (1000.20 - 1500.60) / 1500.60 * 100 = -33.35%
- 2021: (1246.44 - 1000.20) / 1000.20 * 100 = 24.62%
- 2022: (2145.32 - 1246.44) / 1246.44 * 100 = 72.12%

Status: ✅ ACCEPTED on DataLemur
================================================================================
*/
