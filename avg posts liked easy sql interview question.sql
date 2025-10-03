/*
Problem Statement:
Given a table of Facebook posts, for each user who posted at least twice in 2021, 
write a query to find the number of days between each user’s first post of the year 
and last post of the year in the year 2021. 
Output the user and number of the days between each user's first and last post.

Table: posts
----------------------------------
Column Name   | Type
user_id       | integer
post_id       | integer
post_content  | text
post_date     | timestamp

Example Input:
user_id | post_id | post_content                                                   | post_date
151652  | 599415  | Need a hug                                                     | 2021-07-10 12:00:00
661093  | 624356  | Bed. Class 8-12. Work 12-3. Gym 3-5 or 6. Then class 6-10...  | 2021-07-29 13:00:00
004239  | 784254  | Happy 4th of July!                                             | 2021-07-04 11:00:00
661093  | 442560  | Just going to cry myself to sleep...                           | 2021-07-08 14:00:00
151652  | 111766  | I'm so done with covid - need travelling ASAP!                 | 2021-07-12 19:00:00

Expected Output:
user_id | days_between
151652  | 2
661093  | 21
*/

-- Drop table if exists
DROP TABLE IF EXISTS posts;

-- Create table schema
CREATE TABLE posts (
    user_id INT,
    post_id INT PRIMARY KEY,
    post_content TEXT,
    post_date TIMESTAMP
);

-- Insert sample data
INSERT INTO posts (user_id, post_id, post_content, post_date) VALUES
(151652, 599415, 'Need a hug', '2021-07-10 12:00:00'),
(661093, 624356, 'Bed. Class 8-12. Work 12-3. Gym 3-5 or 6. Then class 6-10. Another day that''s gonna fly by. I miss my girlfriend', '2021-07-29 13:00:00'),
(004239, 784254, 'Happy 4th of July!', '2021-07-04 11:00:00'),
(661093, 442560, 'Just going to cry myself to sleep after watching Marley and Me.', '2021-07-08 14:00:00'),
(151652, 111766, 'I''m so done with covid - need travelling ASAP!', '2021-07-12 19:00:00');

-- Solution Query
SELECT 
    user_id,
    DATEDIFF(MAX(post_date), MIN(post_date)) AS days_between
FROM posts
WHERE YEAR(post_date) = 2021
GROUP BY user_id
HAVING COUNT(*) >= 2;
