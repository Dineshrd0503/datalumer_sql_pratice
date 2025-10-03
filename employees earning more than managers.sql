/*
Problem Statement:
Write a SQL query to find the employees who earn more than their managers.

Table: Employee
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| salary      | int     |
| managerId   | int     |
+-------------+---------+
id is the primary key (column with unique values).
Each row of this table indicates the ID, name, salary, and the manager ID of an employee.
If managerId is null, then the employee has no manager.
 
Example Input:
+----+-------+--------+-----------+
| id | name  | salary | managerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | NULL      |
| 4  | Max   | 90000  | NULL      |
+----+-------+--------+-----------+

Expected Output:
+----------+
| Employee |
+----------+
| Joe      |
+----------+
Explanation: Joe earns 70000 while his manager Sam earns 60000.
*/

-- Drop table if exists
DROP TABLE IF EXISTS Employee;

-- Create Employee table
CREATE TABLE Employee (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    managerId INT
);

-- Insert sample data
INSERT INTO Employee (id, name, salary, managerId) VALUES
(1, 'Joe', 70000, 3),
(2, 'Henry', 80000, 4),
(3, 'Sam', 60000, NULL),
(4, 'Max', 90000, NULL);

-- Solution Query
SELECT 
    e.name AS Employee
FROM Employee e
JOIN Employee m 
    ON e.managerId = m.id
WHERE e.salary > m.salary;
