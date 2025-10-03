/*
Problem:
IBM wants to generate a histogram of the number of unique queries run by employees
during Q3 2023 (July–Sept), including employees who did not run any queries.
*/

/* Drop tables if they already exist */
DROP TABLE IF EXISTS queries;
DROP TABLE IF EXISTS employees;

/* Create employees table */
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    full_name   VARCHAR(100),
    gender      VARCHAR(10)
);

/* Create queries table */
CREATE TABLE queries (
    query_id        INT PRIMARY KEY,
    employee_id     INT,
    query_starttime TIMESTAMP,
    execution_time  INT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

/* Insert sample employees */
INSERT INTO employees (employee_id, full_name, gender) VALUES
(1, 'Judas Beardon', 'Male'),
(2, 'Lainey Franciotti', 'Female'),
(3, 'Ashbey Strahan', 'Male'),
(4, 'Dinesh Kumar', 'Male'),
(5, 'Navya Sri', 'Female');

/* Insert sample queries */
INSERT INTO queries (query_id, employee_id, query_starttime, execution_time) VALUES
(856987, 1, '2023-07-01 01:04:43', 2698),
(286115, 2, '2023-07-01 03:25:12', 2705),
(33683,  2, '2023-07-02 04:34:38', 91),
(17745,  3, '2023-08-01 14:33:47', 2093),
(413477, 3, '2023-09-02 10:55:14', 470);

/* Final Solution Query */
WITH cte AS (
  SELECT
    e.employee_id,
    COUNT(DISTINCT q.query_id) AS unique_queries
  FROM
    employees e
  LEFT JOIN
    queries q
    ON e.employee_id = q.employee_id
   AND q.query_starttime >= '2023-07-01'
   AND q.query_starttime < '2023-10-01'
  GROUP BY
    e.employee_id
)
SELECT
  unique_queries,
  COUNT(*) AS employee_count
FROM
  cte
GROUP BY
  unique_queries
ORDER BY
  unique_queries;
