
-- ====================================================
-- FACEBOOK ACTIVE USER RETENTION - Hard SQL Problem
-- Source: DataLemur | Difficulty: Hard
-- ====================================================

-- PROBLEM STATEMENT:
-- ====================================================
-- Write a query to obtain the number of monthly active users (MAUs) in July 2022,
-- including the month in numerical format (1, 2, 3).
--
-- DEFINITION:
-- An active user is defined as a user who has performed actions
-- such as 'sign-in', 'like', or 'comment' in BOTH:
--   - The current month (July 2022)
--   - AND the previous month (June 2022)

-- TABLE SCHEMA:
-- ====================================================
-- user_actions Table:
-- | Column Name | Type                                  |
-- | user_id     | integer                               |
-- | event_id    | integer                               |
-- | event_type  | string ('sign-in', 'like', 'comment') |
-- | event_date  | datetime                              |

-- EXAMPLE INPUT:
-- ====================================================
-- user_id | event_id | event_type | event_date
-- 445     | 7765     | sign-in    | 05/31/2022 12:00:00
-- 742     | 6458     | sign-in    | 06/03/2022 12:00:00
-- 445     | 3634     | like       | 06/05/2022 12:00:00
-- 742     | 1374     | comment    | 06/05/2022 12:00:00
-- 648     | 3124     | like       | 06/18/2022 12:00:00

-- EXPECTED OUTPUT:
-- ====================================================
-- For July 2022:
-- month | monthly_active_users
-- 7     | 2

-- ====================================================
-- SQL SOLUTION
-- ====================================================

WITH monthly_users AS (
  SELECT
    user_id,
    EXTRACT(MONTH FROM event_date) AS mn,
    EXTRACT(YEAR FROM event_date) AS yr
  FROM user_actions
  WHERE event_type IN ('sign-in', 'like', 'comment')
  GROUP BY user_id, EXTRACT(MONTH FROM event_date), EXTRACT(YEAR FROM event_date)
),
june_users AS (
  SELECT user_id
  FROM monthly_users
  WHERE mn = 6 AND yr = 2022
),
july_users AS (
  SELECT user_id
  FROM monthly_users
  WHERE mn = 7 AND yr = 2022
)
SELECT
  7 AS month,
  COUNT(*) AS monthly_active_users
FROM july_users jl
INNER JOIN june_users ju
  ON jl.user_id = ju.user_id;
