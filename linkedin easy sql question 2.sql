/*
Problem Statement:
We want to find the number of companies that have duplicate job listings.
A "duplicate company" is defined as a company_id that appears more than once 
in the job_listings table.

Database: Microsoft SQL Server
*/

-- Drop table if it already exists
IF OBJECT_ID('job_listings', 'U') IS NOT NULL
    DROP TABLE job_listings;

-- Create table schema
CREATE TABLE job_listings (
    job_id      INT PRIMARY KEY,
    company_id  INT,
    job_title   VARCHAR(100)
);

-- Insert sample data
INSERT INTO job_listings (job_id, company_id, job_title) VALUES
(1, 101, 'Software Engineer'),
(2, 101, 'Data Analyst'),
(3, 202, 'Product Manager'),
(4, 303, 'DevOps Engineer'),
(5, 303, 'System Architect'),
(6, 303, 'QA Tester'),
(7, 404, 'UI/UX Designer');

-- =====================================================
-- ✅ Solution Query: Count duplicate companies
-- =====================================================
WITH cte AS (
    SELECT 
        company_id,
        COUNT(*) AS duplicates
    FROM job_listings
    GROUP BY company_id
    HAVING COUNT(*) > 1
)
SELECT COUNT(*) AS duplicate_companies
FROM cte;
