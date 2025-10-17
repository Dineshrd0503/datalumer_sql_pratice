-- ========================================================================================
-- Problem Statement: High Earners in Each Department
-- 
-- Identify employees with salaries in the top three ranks within each department.
-- Display: department_name, name, salary.
-- Sort: department_name ASC, salary DESC, name ASC (alphabetical for ties).
-- Handle duplicate salaries using DENSE_RANK() to include all top earners.
-- 
-- Expected Output:
-- department_name | name           | salary
-- Data Analytics  | James Anderson | 4000
-- Data Analytics  | Emma Thompson  | 3800
-- Data Analytics  | Daniel Rodriguez | 2230
-- Data Science    | Noah Johnson   | 6800
-- Data Science    | William Davis  | 6800
-- 
-- ========================================================================================

-- ========================================================================================
-- Table Schema Creation (PostgreSQL)
-- ========================================================================================
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS department;

-- Employee table
CREATE TABLE employee (
    employee_id INTEGER PRIMARY KEY,
    name VARCHAR(100),
    salary INTEGER,
    department_id INTEGER,
    manager_id INTEGER
);

-- Department table  
CREATE TABLE department (
    department_id INTEGER PRIMARY KEY,
    department_name VARCHAR(100)
);

-- ========================================================================================
-- Sample Data Insertion (Based on Example Input)
-- ========================================================================================
-- Insert departments
INSERT INTO department (department_id, department_name) VALUES
(1, 'Data Analytics'),
(2, 'Data Science'),
(3, 'Engineering');

-- Insert employees
INSERT INTO employee (employee_id, name, salary, department_id, manager_id) VALUES
(1, 'Emma Thompson', 3800, 1, 6),
(2, 'Daniel Rodriguez', 2230, 1, 7),
(3, 'Olivia Smith', 2000, 1, 8),
(4, 'Noah Johnson', 6800, 2, 9),
(5, 'Sophia Martinez', 1750, 1, 11),
(6, 'Liam Brown', 13000, 3, 7),
(7, 'Ava Garcia', 12500, 3, 8),
(8, 'William Davis', 6800, 2, 9),
(9, 'Isabella Wilson', 11000, 3, 10),
(10, 'James Anderson', 4000, 1, 11);

-- Verify sample data
SELECT 
    e.employee_id,
    e.name,
    e.salary,
    e.department_id,
    d.department_name
FROM employee e
JOIN department d ON e.department_id = d.department_id
ORDER BY e.department_id, e.salary DESC;

-- ========================================================================================
-- Fixed PostgreSQL Query Using DENSE_RANK()
-- ========================================================================================
WITH high_earners AS (
    SELECT 
        e.name,
        d.department_name,
        e.salary,
        DENSE_RANK() OVER (
            PARTITION BY e.department_id 
            ORDER BY e.salary DESC
        ) AS salary_rank
    FROM employee e
    JOIN department d ON e.department_id = d.department_id
)
SELECT 
    department_name,
    name,
    salary
FROM high_earners
WHERE salary_rank <= 3
ORDER BY 
    department_name ASC,     -- Department name ascending
    salary DESC,            -- Salary descending within department
    name ASC;               -- Name alphabetical for same salary

-- ========================================================================================
-- Alternative Query Using ROW_NUMBER() (For Comparison)
-- Note: This would miss ties, showing only 3 employees per department regardless of rank
-- ========================================================================================
/*
WITH high_earners_row AS (
    SELECT 
        e.name,
        d.department_name,
        e.salary,
        ROW_NUMBER() OVER (
            PARTITION BY e.department_id 
            ORDER BY e.salary DESC
        ) AS salary_rank
    FROM employee e
    JOIN department d ON e.department_id = d.department_id
)
SELECT 
    department_name,
    name,
    salary
FROM high_earners_row
WHERE salary_rank <= 3
ORDER BY department_name ASC, salary DESC, name ASC;
*/

-- ========================================================================================
-- Expected Results:
-- 
-- Using DENSE_RANK() (Recommended):
-- department_name  | name           | salary
-- Data Analytics   | James Anderson | 4000
-- Data Analytics   | Emma Thompson  | 3800
-- Data Analytics   | Daniel Rodriguez | 2230
-- Data Science     | Noah Johnson   | 6800
-- Data Science     | William Davis  | 6800
-- Engineering      | Liam Brown     | 13000
-- Engineering      | Ava Garcia     | 12500
-- Engineering      | Isabella Wilson| 11000
-- 
-- Explanation:
-- - Data Science: Both Noah (6800) and William (6800) get rank 1, next gets rank 2
-- - Top 3 ranks include both 6800 salaries
-- - Engineering: Top 3 distinct salaries shown
-- 
-- ========================================================================================

-- ========================================================================================
-- Verification Query: Show ranking for all employees (for debugging)
-- ========================================================================================
SELECT 
    d.department_name,
    e.name,
    e.salary,
    DENSE_RANK() OVER (
        PARTITION BY e.department_id 
        ORDER BY e.salary DESC
    ) AS salary_rank
FROM employee e
JOIN department d ON e.department_id = d.department_id
ORDER BY d.department_name, e.salary DESC, e.name ASC;
