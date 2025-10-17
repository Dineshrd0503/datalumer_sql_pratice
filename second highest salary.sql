/*
Problem Statement:
------------------
Imagine you're an HR analyst at a tech company tasked with analyzing employee salaries. 
Your manager is keen on understanding the pay distribution and asks you to determine the second highest salary among all employees.

It's possible that multiple employees may share the same second highest salary. 
In case of duplicates, display the salary only once.

Table: employee
----------------
Column Name     | Type      | Description
employee_id      integer     The unique ID of the employee.
name             string      The name of the employee.
salary           integer     The salary of the employee.
department_id    integer     The department ID of the employee.
manager_id       integer     The manager ID of the employee.

Example Input:
---------------
employee_id | name             | salary | department_id | manager_id
1           | Emma Thompson    | 3800   | 1             | 6
2           | Daniel Rodriguez | 2230   | 1             | 7
3           | Olivia Smith     | 2000   | 1             | 8

Expected Output:
----------------
second_highest_salary
2230
*/

-- Drop table if it already exists
DROP TABLE IF EXISTS employee;

-- Create employee table
CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    salary INT,
    department_id INT,
    manager_id INT
);

-- Insert sample data
INSERT INTO employee (employee_id, name, salary, department_id, manager_id) VALUES
(1, 'Emma Thompson', 3800, 1, 6),
(2, 'Daniel Rodriguez', 2230, 1, 7),
(3, 'Olivia Smith', 2000, 1, 8);

-- Query to find the second highest salary (unique)
SELECT DISTINCT salary AS second_highest_salary
FROM employee
ORDER BY salary DESC
LIMIT 1 OFFSET 1;
