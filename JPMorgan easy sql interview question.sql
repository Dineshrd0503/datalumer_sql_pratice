/*
Problem Statement:
Your team at JPMorgan Chase is preparing to launch a new credit card, and to gain some insights, 
you're analyzing how many credit cards were issued each month.

Write a query that outputs the name of each credit card and the difference in the number of issued 
cards between the month with the highest issuance cards and the lowest issuance. Arrange the results 
based on the largest disparity.

monthly_cards_issued Table:
Column Name     Type
card_name       string
issued_amount   integer
issue_month     integer
issue_year      integer

Example Input:
card_name               issued_amount   issue_month   issue_year
Chase Freedom Flex      55000           1             2021
Chase Freedom Flex      60000           2             2021
Chase Freedom Flex      65000           3             2021
Chase Freedom Flex      70000           4             2021
Chase Sapphire Reserve  170000          1             2021
Chase Sapphire Reserve  175000          2             2021
Chase Sapphire Reserve  180000          3             2021

Expected Output:
card_name               difference
Chase Freedom Flex      15000
Chase Sapphire Reserve  10000
*/

-- Drop table if it already exists
DROP TABLE IF EXISTS monthly_cards_issued;

-- Create schema
CREATE TABLE monthly_cards_issued (
    card_name      VARCHAR(100),
    issued_amount  INTEGER,
    issue_month    INTEGER,
    issue_year     INTEGER
);

-- Insert sample data
INSERT INTO monthly_cards_issued (card_name, issued_amount, issue_month, issue_year) VALUES
('Chase Freedom Flex', 55000, 1, 2021),
('Chase Freedom Flex', 60000, 2, 2021),
('Chase Freedom Flex', 65000, 3, 2021),
('Chase Freedom Flex', 70000, 4, 2021),
('Chase Sapphire Reserve', 170000, 1, 2021),
('Chase Sapphire Reserve', 175000, 2, 2021),
('Chase Sapphire Reserve', 180000, 3, 2021);

-- Solution Query
SELECT 
    card_name,
    MAX(issued_amount) - MIN(issued_amount) AS difference
FROM 
    monthly_cards_issued
GROUP BY 
    card_name
ORDER BY 
    difference DESC;
