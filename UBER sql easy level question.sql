-- ========================================================================================
-- Problem Statement:
-- 
-- You are given a table 'transactions' that records user transactions with details like user ID, 
-- spend amount, and transaction date. The goal is to find the 3rd transaction for each user, 
-- ordered by transaction date (earliest first). If a user has fewer than 3 transactions, 
-- they will not appear in the result.
-- 
-- Use a Common Table Expression (CTE) with ROW_NUMBER() window function to assign row numbers 
-- per user based on transaction_date. Then, select only the rows where the row number is 3.
-- 
-- Expected Output Columns: user_id, spend, transaction_date
-- 
-- Table: transactions
-- Columns:
-- - user_id: integer (Unique ID for the user)
-- - spend: numeric/decimal (Amount spent in the transaction)
-- - transaction_date: timestamp (Date and time of the transaction)
-- 
-- Example Input (Assumed Structure):
-- user_id | spend  | transaction_date
-- 1       | 100.00 | 2023-01-15 10:00:00
-- 1       | 150.00 | 2023-02-20 14:30:00
-- 1       | 200.00 | 2023-03-10 09:15:00
-- 2       | 50.00  | 2023-01-20 11:45:00
-- 2       | 75.00  | 2023-02-25 16:20:00
-- 3       | 120.00 | 2023-01-10 08:00:00
-- 3       | 180.00 | 2023-01-25 13:10:00
-- 3       | 90.00  | 2023-02-05 12:30:00
-- 
-- Example Output:
-- user_id | spend  | transaction_date
-- 1       | 200.00 | 2023-03-10 09:15:00
-- 3       | 90.00  | 2023-02-05 12:30:00
-- 
-- Approach:
-- - Use CTE to add ROW_NUMBER() over each user_id, ordered by transaction_date (ascending).
-- - Filter the CTE for rn = 3 to get exactly the 3rd transaction per user.
-- - This handles users with at least 3 transactions; others are implicitly excluded.
-- 
-- Time Complexity: O(n log n) due to window function sorting.
-- Space Complexity: O(n) for the CTE.
-- ========================================================================================

-- ========================================================================================
-- Table Schema Creation (PostgreSQL)
-- ========================================================================================
DROP TABLE IF EXISTS transactions;

CREATE TABLE transactions (
    user_id INTEGER,
    spend DECIMAL(10, 2),
    transaction_date TIMESTAMP
);

-- ========================================================================================
-- Sample Data Insertion (Based on Example Above)
-- ========================================================================================
INSERT INTO transactions (user_id, spend, transaction_date) VALUES
(1, 100.00, '2023-01-15 10:00:00'),
(1, 150.00, '2023-02-20 14:30:00'),
(1, 200.00, '2023-03-10 09:15:00'),
(2, 50.00, '2023-01-20 11:45:00'),
(2, 75.00, '2023-02-25 16:20:00'),
(3, 120.00, '2023-01-10 08:00:00'),
(3, 180.00, '2023-01-25 13:10:00'),
(3, 90.00, '2023-02-05 12:30:00');

-- Verify sample data
-- SELECT * FROM transactions ORDER BY user_id, transaction_date;

-- ========================================================================================
-- PostgreSQL Query to Solve the Problem (Analysis and Implementation)
-- ========================================================================================
-- Analysis of Provided Query:
-- - CTE 'cte' selects all columns from 'transactions' and adds a row number (rn) for each user_id, 
--   partitioned by user_id and ordered by transaction_date (ascending). This ranks transactions 
--   chronologically per user.
-- - The outer SELECT filters for rn=3, retrieving the 3rd transaction (user_id, spend, transaction_date) 
--   for users who have at least 3 transactions.
-- - Assumptions: transaction_date is unique per user or ties are handled by the order (stable).
-- - Edge Cases: Users with <3 transactions are excluded (correct). If no such users, empty result.
-- - Optimization: Efficient for large datasets; window functions are performant in PostgreSQL.
-- - Potential Improvements: If transaction_date has ties, add another ORDER BY column (e.g., spend DESC) 
--   for deterministic ranking.

WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date) AS rn
    FROM transactions
)
SELECT user_id, spend, transaction_date
FROM cte
WHERE rn = 3;

-- ========================================================================================
-- Expected Result from Sample Data:
-- user_id | spend  | transaction_date
-- 1       | 200.00 | 2023-03-10 09:15:00
-- 3       | 90.00  | 2023-02-05 12:30:00
-- 
-- Explanation:
-- - User 1: Transactions on 2023-01-15 (rn=1), 2023-02-20 (rn=2), 2023-03-10 (rn=3) → Select 3rd.
-- - User 2: Only 2 transactions → Excluded.
-- - User 3: Transactions on 2023-01-10 (rn=1), 2023-01-25 (rn=2), 2023-02-05 (rn=3) → Select 3rd.
-- 
-- To run this file:
-- 1. Save as 'third_transaction_per_user.sql'.
-- 2. Execute in PostgreSQL: \i third_transaction_per_user.sql
-- 3. The query will output the results after data insertion.
-- ========================================================================================
