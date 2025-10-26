-- Walmart SQL Interview Question: Histogram of Users' Purchases
-- -------------------------------------------------------------
-- Problem Statement:
-- For each user, find out how many products they bought on their most recent transaction date.
-- The result should include:
--   - The most recent transaction date,
--   - The user_id,
--   - The number of purchases made by the user on that date.
-- Output should be sorted by transaction_date (chronologically).

-- Sample Table Schema:
-- CREATE TABLE user_transactions (
--   transaction_id INT PRIMARY KEY,
--   user_id INT,
--   product_id INT,
--   transaction_date DATE
-- );

-- Complete Solution:
WITH cte AS (
    SELECT
        transaction_date,
        user_id,
        DENSE_RANK() OVER (
            PARTITION BY user_id
            ORDER BY transaction_date DESC
        ) AS rn
    FROM user_transactions
)
SELECT
    transaction_date,
    user_id,
    COUNT(*) AS purchase_count
FROM cte
WHERE rn = 1
GROUP BY transaction_date, user_id
ORDER BY transaction_date;
