-- ========================================================================================
-- Problem Statement:
-- 
-- UnitedHealth Group (UHG) has a program called Advocate4Me, which allows policy holders 
-- (or, members) to call an advocate and receive support for their health care needs – 
-- whether that's claims and benefits support, drug coverage, pre- and post-authorisation, 
-- medical records, emergency assistance, or member portal services.
-- 
-- Write a query to find how many UHG policy holders made three, or more calls, assuming 
-- each call is identified by the case_id column.
-- 
-- If you like this question, try out Patient Support Analysis (Part 2)!
-- 
-- Expected Output: policy_holder_count (integer, e.g., 1)
-- 
-- Table: callers
-- Columns:
-- - policy_holder_id: integer (Unique ID for the policy holder)
-- - case_id: varchar (Unique identifier for each call)
-- - call_category: varchar (Category of the call, e.g., 'emergency assistance')
-- - call_date: timestamp (Date and time of the call)
-- - call_duration_secs: integer (Duration of the call in seconds)
-- 
-- Example Input:
-- policy_holder_id | case_id                              | call_category       | call_date                  | call_duration_secs
-- 1                | f1d012f9-9d02-4966-a968-bf6c5bc9a9fe| emergency assistance| 2023-04-13T19:16:53Z      | 144
-- 1                | 41ce8fb6-1ddd-4f50-ac31-07bfcce6aaab| authorisation       | 2023-05-25T09:09:30Z      | 815
-- 2                | 9b1af84b-eedb-4c21-9730-6f099cc2cc5e| claims assistance   | 2023-01-26T01:21:27Z      | 992
-- 2                | 8471a3d4-6fc7-4bb2-9fc7-4583e3638a9e| emergency assistance| 2023-03-09T10:58:54Z      | 128
-- 2                | 38208fae-bad0-49bf-99aa-7842ba2e37bc| benefits            | 2023-06-05T07:35:43Z      | 619
-- 
-- Example Output:
-- policy_holder_count
-- 1
-- 
-- Approach:
-- - Group by policy_holder_id and count the number of calls (rows) per holder.
-- - Filter groups where count >= 3 using HAVING.
-- - Count the number of such policy holders.
-- 
-- Time Complexity: O(n) where n is the number of rows.
-- Space Complexity: O(1) for aggregation.
-- ========================================================================================

-- ========================================================================================
-- Table Schema Creation (PostgreSQL)
-- ========================================================================================
DROP TABLE IF EXISTS callers;

CREATE TABLE callers (
    policy_holder_id INTEGER,
    case_id VARCHAR(50),
    call_category VARCHAR(50),
    call_date TIMESTAMP,
    call_duration_secs INTEGER
);

-- ========================================================================================
-- Sample Data Insertion (Based on Example Input)
-- ========================================================================================
INSERT INTO callers (policy_holder_id, case_id, call_category, call_date, call_duration_secs) VALUES
(1, 'f1d012f9-9d02-4966-a968-bf6c5bc9a9fe', 'emergency assistance', '2023-04-13 19:16:53', 144),
(1, '41ce8fb6-1ddd-4f50-ac31-07bfcce6aaab', 'authorisation', '2023-05-25 09:09:30', 815),
(2, '9b1af84b-eedb-4c21-9730-6f099cc2cc5e', 'claims assistance', '2023-01-26 01:21:27', 992),
(2, '8471a3d4-6fc7-4bb2-9fc7-4583e3638a9e', 'emergency assistance', '2023-03-09 10:58:54', 128),
(2, '38208fae-bad0-49bf-99aa-7842ba2e37bc', 'benefits', '2023-06-05 07:35:43', 619);

-- Verify sample data
-- SELECT * FROM callers;

-- ========================================================================================
-- PostgreSQL Query to Solve the Problem
-- ========================================================================================
SELECT COUNT(*) AS policy_holder_count
FROM (
    SELECT policy_holder_id
    FROM callers
    GROUP BY policy_holder_id
    HAVING COUNT(*) >= 3
) AS holders_with_3_or_more_calls;

-- ========================================================================================
-- Expected Result from Sample Data:
-- policy_holder_count
-- 1
-- 
-- Explanation:
-- - Policy holder 1 made 2 calls (less than 3, excluded).
-- - Policy holder 2 made 3 calls (>= 3, included).
-- - Total: 1 policy holder.
-- 
-- To run this file:
-- 1. Save as 'uhg_advocate_calls.sql'.
-- 2. Execute in PostgreSQL: \i uhg_advocate_calls.sql
-- 3. The query will output the result after data insertion.
-- ========================================================================================
