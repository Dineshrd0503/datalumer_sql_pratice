-- Facebook SQL Interview Question: App Clickthrough Rate
-- Table: events
-- +--------+------------+---------------------+
-- | app_id | event_type |     timestamp       |
-- +--------+------------+---------------------+
-- | 123    | impression | 07/18/2022 11:36:12 |
-- | 123    | impression | 07/18/2022 11:37:12 |
-- | 123    | click      | 07/18/2022 11:37:42 |
-- | 234    | impression | 07/18/2022 14:15:12 |
-- | 234    | click      | 07/18/2022 14:16:12 |
-- +--------+------------+---------------------+
-- 
-- Problem:
-- Write a query to calculate the click-through rate (CTR) for each app in the year 2022.
-- CTR is defined as (Number of Clicks) / (Number of Impressions) * 100, rounded to two decimal places.
-- Output app_id and ctr.

SELECT 
  app_id,
  ROUND(
    100.0 * SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END)
    / NULLIF(SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END), 0),
    2
  ) AS ctr
FROM
  events
WHERE
  EXTRACT(YEAR FROM timestamp) = 2022
GROUP BY 
  app_id
ORDER BY
  app_id;
