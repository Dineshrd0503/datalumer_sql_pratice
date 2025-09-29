
/*
Problem Statement:
Given a table of candidates and their skills, find the candidates best suited for a Data Science job.
The candidates must be proficient in all of the following skills: Python, Tableau, and PostgreSQL.
List the candidate IDs who possess all required skills, sorted by candidate_id in ascending order.

Assumption:
- There are no duplicates in the candidates table (each candidate_id, skill pair is unique).

Table Schema:
- candidates (candidate_id: integer, skill: varchar)

Expected Output:
candidate_id
------------
123
(Only candidate 123 has all required skills: Python, Tableau, PostgreSQL.)
*/

-- Create the candidates table
CREATE TABLE candidates (
    candidate_id INT,
    skill VARCHAR(50),
    PRIMARY KEY (candidate_id, skill)
);

-- Insert sample data
INSERT INTO candidates (candidate_id, skill) VALUES
(123, 'Python'),
(123, 'Tableau'),
(123, 'PostgreSQL'),
(234, 'R'),
(234, 'PowerBI'),
(234, 'SQL Server'),
(345, 'Python'),
(345, 'Tableau');

-- Query to find candidates with all required skills
SELECT
    candidate_id
FROM
    candidates
WHERE
    skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY
    candidate_id
HAVING
    COUNT(DISTINCT skill) = 3
ORDER BY
    candidate_id;
