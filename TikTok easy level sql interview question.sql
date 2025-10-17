/*
Problem Statement:
------------------
Assume you're given tables with information about TikTok user sign-ups and confirmations through email and text. 
New users on TikTok sign up using their email addresses, and upon sign-up, each user receives a text message confirmation to activate their account.

You need to write a query to display the user IDs of those who did not confirm their sign-up on the first day, 
but confirmed on the second day.

Definitions:
- action_date: The date when users activated their accounts and confirmed their sign-up through text messages.

Table: emails
--------------
Column Name   | Type
email_id      | integer
user_id       | integer
signup_date   | datetime

Table: texts
-------------
Column Name     | Type
text_id         | integer
email_id        | integer
signup_action   | string ('Confirmed', 'Not confirmed')
action_date     | datetime

Example Input:
--------------
emails:
email_id | user_id | signup_date
125      | 7771    | 06/14/2022 00:00:00
433      | 1052    | 07/09/2022 00:00:00

texts:
text_id | email_id | signup_action | action_date
6878    | 125      | Confirmed     | 06/14/2022 00:00:00
6997    | 433      | Not Confirmed | 07/09/2022 00:00:00
7000    | 433      | Confirmed     | 07/10/2022 00:00:00

Expected Output:
----------------
user_id
1052
*/

-- Drop tables if they exist
DROP TABLE IF EXISTS texts;
DROP TABLE IF EXISTS emails;

-- Create emails table
CREATE TABLE emails (
    email_id INT PRIMARY KEY,
    user_id INT,
    signup_date DATETIME
);

-- Create texts table
CREATE TABLE texts (
    text_id INT PRIMARY KEY,
    email_id INT,
    signup_action VARCHAR(20),
    action_date DATETIME
);

-- Insert sample data into emails
INSERT INTO emails (email_id, user_id, signup_date) VALUES
(125, 7771, '2022-06-14 00:00:00'),
(433, 1052, '2022-07-09 00:00:00');

-- Insert sample data into texts
INSERT INTO texts (text_id, email_id, signup_action, action_date) VALUES
(6878, 125, 'Confirmed', '2022-06-14 00:00:00'),
(6997, 433, 'Not Confirmed', '2022-07-09 00:00:00'),
(7000, 433, 'Confirmed', '2022-07-10 00:00:00');

-- Query to find users who did not confirm on the first day but confirmed on the second day
SELECT e.user_id
FROM emails e
JOIN texts t1 ON e.email_id = t1.email_id
JOIN texts t2 ON e.email_id = t2.email_id
WHERE t1.signup_action = 'Not Confirmed'
  AND t2.signup_action = 'Confirmed'
  AND DATEDIFF(t2.action_date, t1.action_date) = 1;
