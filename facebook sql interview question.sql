
/*
Problem Statement:
Given two tables containing data about Facebook Pages and their respective likes,
write a SQL query to return the IDs of Facebook pages that have zero likes.
The output should be sorted in ascending order based on the page IDs.

Table Schemas:
- pages (page_id: integer, page_name: varchar)
- page_likes (user_id: integer, page_id: integer, liked_date: datetime)

Expected Output:
page_id
--------
20701
(Only page 20701 has no likes in the page_likes table.)
*/

-- Create the pages table
CREATE TABLE pages (
    page_id INT PRIMARY KEY,
    page_name VARCHAR(50)
);

-- Create the page_likes table
CREATE TABLE page_likes (
    user_id INT,
    page_id INT,
    liked_date DATETIME,
    PRIMARY KEY (user_id, page_id),
    FOREIGN KEY (page_id) REFERENCES pages(page_id)
);

-- Insert sample data into pages
INSERT INTO pages (page_id, page_name) VALUES
(20001, 'SQL Solutions'),
(20045, 'Brain Exercises'),
(20701, 'Tips for Data Analysts');

-- Insert sample data into page_likes
INSERT INTO page_likes (user_id, page_id, liked_date) VALUES
(111, 20001, '2022-04-08 00:00:00'),
(121, 20045, '2022-03-12 00:00:00'),
(156, 20001, '2022-07-25 00:00:00');

-- Query to find pages with zero likes
SELECT
    p1.page_id
FROM
    pages p1
LEFT JOIN
    page_likes p2
ON
    p1.page_id = p2.page_id
WHERE
    p2.page_id IS NULL
ORDER BY
    p1.page_id;