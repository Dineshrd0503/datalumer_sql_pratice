/*
Problem Statement:
Tesla is investigating production bottlenecks and needs to identify parts that have begun the assembly process but are not yet finished.
Write a SQL query to return the part and assembly_step for parts with a NULL finish_date.
The output should be sorted by part and assembly_step in ascending order.

Assumptions:
- The parts_assembly table contains all parts currently in production, each at varying stages of the assembly process.
- An unfinished part is one that lacks a finish_date (i.e., finish_date IS NULL).
- The query should be straightforward and simple.

Table Schema:
- parts_assembly (part: string, finish_date: datetime, assembly_step: integer)

Expected Output:
part    | assembly_step
--------+--------------
bumper  | 3
bumper  | 4
(Only bumper at assembly steps 3 and 4 have a NULL finish_date.)
*/

-- Create the parts_assembly table
CREATE TABLE parts_assembly (
    part VARCHAR(50),
    finish_date DATETIME,
    assembly_step INT,
    PRIMARY KEY (part, assembly_step)
);

-- Insert sample data into parts_assembly
INSERT INTO parts_assembly (part, finish_date, assembly_step) VALUES
('battery', '2022-01-22 00:00:00', 1),
('battery', '2022-02-22 00:00:00', 2),
('battery', '2022-03-22 00:00:00', 3),
('bumper', '2022-01-22 00:00:00', 1),
('bumper', '2022-02-22 00:00:00', 2),
('bumper', NULL, 3),
('bumper', NULL, 4);

-- Query to find unfinished parts
SELECT
    part,
    assembly_step
FROM
    parts_assembly
WHERE
    finish_date IS NULL
ORDER BY
    part,
    assembly_step;
