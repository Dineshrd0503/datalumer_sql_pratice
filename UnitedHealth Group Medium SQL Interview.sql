-- UnitedHealth Group SQL Interview Question (DataLemur)
-- Problem Statement:
-- UnitedHealth Group (UHG) has a program called Advocate4Me, which allows policy holders (members)
-- to call and receive support for their health care needs. 
-- Calls to the Advocate4Me call centre are classified into various categories, 
-- but some calls cannot be categorised. These are labeled as “n/a”, or are left empty when the support agent does not enter anything into the call category field.
-- Write a query to calculate the percentage of calls that cannot be categorised.
-- Round your answer to 1 decimal place.

-- callers Table Schema:
-- | policy_holder_id      | integer  |
-- | case_id              | varchar  |
-- | call_category        | varchar  |
-- | call_date            | timestamp|
-- | call_duration_secs   | integer  |

SELECT
  ROUND(
    100.0 * SUM(
      CASE 
        WHEN call_category LIKE 'n/a' OR call_category IS NULL OR call_category = ''
        THEN 1
        ELSE 0
      END
    ) / COUNT(*),
    1
  ) AS uncategorised_call_pct
FROM callers;
