/*
====================================================================================
Problem Statement:
====================================================================================
We have user activity data in the 'activities' table and age information in the
'age_breakdown' table. Each activity can be of type 'send' or 'open', with a
certain time spent. 

Objective: Calculate the percentage of total time spent on 'send' and 'open' 
activities for each age bucket.

====================================================================================
Schema:
====================================================================================

Table: activities
-----------------------------------------------------
| Column        | Data Type | Description          |
-----------------------------------------------------
| user_id       | INT       | Unique user ID       |
| activity_type | VARCHAR   | 'send' or 'open'    |
| time_spent    | DECIMAL   | Time spent in minutes|
-----------------------------------------------------

Table: age_breakdown
-----------------------------------------------------
| Column     | Data Type | Description           |
-----------------------------------------------------
| user_id    | INT       | Unique user ID        |
| age_bucket | VARCHAR   | Age group of the user |
-----------------------------------------------------

====================================================================================
Query:
====================================================================================
*/

SELECT 
  ab.age_bucket,
  ROUND(
    SUM(CASE WHEN a.activity_type = 'send' THEN a.time_spent ELSE 0 END) /
    SUM(CASE WHEN a.activity_type IN ('send', 'open') THEN a.time_spent ELSE 0 END) * 100.0, 2
  ) AS send_perc,
  ROUND(
    SUM(CASE WHEN a.activity_type = 'open' THEN a.time_spent ELSE 0 END) /
    SUM(CASE WHEN a.activity_type IN ('send', 'open') THEN a.time_spent ELSE 0 END) * 100.0, 2
  ) AS open_perc
FROM activities a
JOIN age_breakdown ab ON a.user_id = ab.user_id
WHERE a.activity_type IN ('send', 'open')
GROUP BY ab.age_bucket;

/*
====================================================================================
Expected Output (Example):
====================================================================================

| age_bucket | send_perc | open_perc |
--------------------------------------
| 18-25      | 60.50      | 39.50     |
| 26-35      | 55.20      | 44.80     |
| 36-45      | 48.75      | 51.25     |
| 46-60      | 40.00      | 60.00     |

Note:
- Percentages are rounded to 2 decimal places.
- Each row represents the percentage of time spent on 'send' vs 'open' for 
  that age bucket.
*/
