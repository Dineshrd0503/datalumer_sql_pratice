/*
================================================================================
                        APP CLICK-THROUGH RATE (CTR)
                    Facebook SQL Interview Question
                         Difficulty: EASY
================================================================================

PROBLEM STATEMENT:
Assume you have an events table on Facebook app analytics. Write a query to 
calculate the click-through rate (CTR) for the app in 2022 and round the 
results to 2 decimal places.

DEFINITION AND NOTE:
- Percentage of click-through rate (CTR) = 100.0 * Number of clicks / Number of impressions
- To avoid integer division, multiply the CTR by 100.0, not 100.

TABLE SCHEMA:
=============

events Table:
- app_id      : integer
- event_type  : string (values: 'click' or 'impression')
- timestamp   : datetime

EXAMPLE INPUT:
==============

app_id | event_type | timestamp
-------|------------|---------------------------
123    | impression | 07/18/2022 11:36:12
123    | impression | 07/18/2022 11:37:12
123    | click      | 07/18/2022 11:37:42
234    | impression | 07/18/2022 14:15:12
234    | click      | 07/18/2022 14:16:12

EXPECTED OUTPUT:
================

app_id | ctr
-------|-------
234    | 33.33
123    | 66.67

EXPLANATION:
============

For App 123:
- Total impressions: 2
- Total clicks: 1
- CTR = (1 / 2) * 100.0 = 50.00%

For App 234:
- Total impressions: 1
- Total clicks: 1
- CTR = (1 / 1) * 100.0 = 100.00%

KEY CONCEPTS USED:
==================
✓ CASE WHEN statements for conditional aggregation
✓ SUM() aggregate function with CASE expressions
✓ EXTRACT() function to filter by year
✓ ROUND() function for decimal precision
✓ GROUP BY for aggregation by app_id
✓ Floating-point arithmetic (100.0) to avoid integer division

SOLUTION STATUS: ✅ ACCEPTED
================================================================================
*/

-- SOLUTION:
SELECT
  app_id,
  ROUND(
    100.0 * SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END) /
    SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END),
    2
  ) AS ctr
FROM events
WHERE EXTRACT(YEAR FROM timestamp) = 2022
GROUP BY app_id;

/*
================================================================================
                          SOLUTION EXPLANATION
================================================================================

Step 1: SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END)
- Counts the number of 'click' events for each app
- Returns 0 for non-click events, 1 for click events
- SUM aggregates these values to get total clicks

Step 2: SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END)
- Counts the number of 'impression' events for each app
- Returns 0 for non-impression events, 1 for impression events
- SUM aggregates these values to get total impressions

Step 3: 100.0 * [clicks] / [impressions]
- Divides total clicks by total impressions
- Multiplies by 100.0 (NOT 100) to avoid integer division
- This gives us the CTR as a percentage

Step 4: ROUND(..., 2)
- Rounds the CTR value to 2 decimal places
- Example: 33.333... becomes 33.33

Step 5: WHERE EXTRACT(YEAR FROM timestamp) = 2022
- Filters events to only include those from year 2022
- EXTRACT(YEAR FROM timestamp) extracts the year from the timestamp

Step 6: GROUP BY app_id
- Groups results by app_id to calculate CTR separately for each app

IMPORTANT NOTE:
================
Using 100.0 instead of 100 is crucial because:
- 100 (integer) with integer division can cause truncation
- 100.0 (float) ensures floating-point division which gives decimals
- Example: 1 / 2 * 100 = 0 * 100 = 0 (wrong - integer division)
- Example: 1 / 2 * 100.0 = 0.5 * 100.0 = 50.0 (correct)

================================================================================
*/
